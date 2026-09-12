# Virtual Machines Reference

**Version:** 1.0
**Last Updated:** 2026-09-12
**Status:** Living Document

# About This Document

This document describes the virtualization environment configured on the
Arch Linux system for creating and running virtual machines.

The environment uses KVM/QEMU for hardware-assisted virtualization,
libvirt for virtual machine management, and virt-manager as the primary
graphical management interface.

The environment was initially configured while evaluating Omarchy Linux
in a virtual machine. It is intended to provide a reusable virtualization
platform for testing operating systems and other software without modifying
the host system.

## Contents

- [Architecture](#architecture)
- [Host Requirements](#host-requirements)
- [Software Stack](#software-stack)
- [libvirt Configuration](#libvirt-configuration)
- [Creating a Virtual Machine](#creating-a-virtual-machine)
- [VM Operations](#vm-operations)
- [Operational Checks](#operational-checks)
- [Troubleshooting](#troubleshooting)
- [Lessons Learned](#lessons-learned)
- [Related Documentation](#related-documentation)

# Architecture

## Purpose

The virtualization environment provides an isolated platform for evaluating
operating systems and software before deciding whether to install them on
physical hardware.

The original use case was evaluating Omarchy Linux without disrupting the
existing Arch Linux installation.

The virtualization environment remains available for future operating-system
testing and other workloads that benefit from isolation from the host.

## Virtualization Stack

The environment consists of the following layers:

```text
virt-manager
     |
  libvirt
     |
 QEMU/KVM
     |
Linux kernel
     |
Intel VT-x
```

Each component has a separate responsibility:

- **Intel VT-x** provides hardware virtualization support.
- **KVM** provides Linux kernel virtualization support.
- **QEMU** provides virtual hardware and executes the guest.
- **libvirt** provides a management layer for virtual machines, storage,
  and networking.
- **virt-manager** provides a graphical interface for libvirt.
- **dnsmasq** supports DHCP and DNS services for libvirt virtual networks.
- **OVMF** provides UEFI firmware for virtual machines.

## Design Decisions

- Use KVM hardware acceleration rather than software-only virtualization.
- Use the system libvirt connection (`qemu:///system`) rather than a
  per-user session.
- Use virt-manager as the primary graphical management interface.
- Use libvirt's default NAT network for normal guest Internet access.
- Use UEFI firmware for modern operating-system installations.
- Use snapshots before significant guest changes when practical.
- Keep virtual-machine experimentation isolated from the primary Arch
  installation.

# Host Requirements

## Hardware Virtualization

The Arch Linux host is a Dell Latitude with Intel VT-x virtualization
support.

Verify hardware virtualization:

```bash
lscpu | grep -i virtualization
```

Expected result:

```text
Virtualization:                          VT-x
```

## Kernel Support

The Intel KVM kernel modules should be loaded:

```bash
lsmod | grep kvm
```

Verified modules include:

```text
kvm_intel
kvm
irqbypass
```

`kvm_intel` provides Intel-specific KVM support, while `kvm` provides the
core kernel virtualization infrastructure.

# Software Stack

The virtualization environment was installed using Arch Linux packages:

```bash
sudo pacman -S qemu-desktop libvirt virt-manager dnsmasq
```

UEFI firmware support is provided by:

```text
edk2-ovmf
```

Verify the installed components:

```bash
pacman -Q qemu-desktop libvirt virt-manager dnsmasq edk2-ovmf
```

As last verified on 2026-09-12:

```text
qemu-desktop 11.1.1-1
libvirt 1:12.7.0-1
virt-manager 5.1.0-4
dnsmasq 2.93-1
edk2-ovmf 202608-1
```

Package versions will change as Arch Linux is updated and are recorded here
only as the last verified configuration.

# libvirt Configuration

## System vs. Session Connection

libvirt supports multiple connection types.

This environment uses:

```text
qemu:///system
```

rather than:

```text
qemu:///session
```

The system connection provides system-wide virtual machines and networking
and supports libvirt's default NAT network.

Commands should explicitly specify the system connection when there is any
ambiguity:

```bash
virsh -c qemu:///system list --all
```

During initial setup, commands using the default user session did not expose
the expected libvirt default network. Specifying `qemu:///system` resolved the
ambiguity.

## Permissions

The user is a member of the `libvirt` group:

```bash
groups
```

Verified groups include:

```text
ralph libvirt users wheel
```

Membership in the `libvirt` group allows normal management of the system
libvirt environment without repeated authentication prompts.

A logout or reboot may be required after initially adding a user to the
group.

## Services

`libvirtd.service` is enabled and active.

Verify:

```bash
systemctl is-enabled libvirtd.service
systemctl is-active libvirtd.service
```

Expected results:

```text
enabled
active
```

The service can be enabled and started with:

```bash
sudo systemctl enable --now libvirtd.service
```

## Default Network

The standard libvirt NAT network is used for guest networking.

Verify it with:

```bash
virsh -c qemu:///system net-info default
```

The verified configuration is:

```text
Name:           default
Active:         yes
Persistent:     yes
Autostart:      yes
Bridge:         virbr0
```

The `virbr0` bridge provides connectivity between virtual machines and
libvirt's NAT networking infrastructure.

The default network should normally be:

- Active
- Persistent
- Configured to autostart

This allows guests to obtain network connectivity without manually starting
the virtual network after each host reboot.

# Creating a Virtual Machine

virt-manager is the primary interface used to create and configure virtual
machines.

Start it with:

```bash
virt-manager
```

## Installation Media

Operating-system installation media can be stored locally and selected using
the **Local install media (ISO image or CDROM)** option in virt-manager.

A convenient location used on this system is:

```text
~/VMs/iso/
```

Downloaded installation media should be verified before use when the
publisher provides cryptographic signatures or checksums.

See `docs/references/download-verification.md` for the verification workflow.

## CPU and Memory

CPU and memory allocations should reflect both the requirements of the guest
and the resources available on the host.

Avoid allocating all host CPUs or most available memory to a guest. Leaving
sufficient resources for the host keeps the desktop and other applications
responsive while the VM is running.

## Storage

virt-manager can create a virtual disk during VM creation.

VirtIO storage should normally be preferred for Linux guests because it is
designed for efficient virtualized I/O.

The original Omarchy test VM used a 50 GB virtual disk.

Virtual disks consume persistent host storage even when the virtual machine is
shut down.

## Firmware

UEFI firmware is preferred for modern guests.

OVMF firmware is supplied by the `edk2-ovmf` package.

When creating a VM, select UEFI firmware when supported by the guest operating
system.

## Networking

The normal configuration connects the guest network adapter to libvirt's
`default` virtual network.

Traffic follows approximately this path:

```text
Guest
  |
Virtual NIC
  |
virbr0
  |
libvirt NAT
  |
Host network
  |
Internet
```

This allows the guest to access the Internet without requiring it to appear
as a separate physical device on the home LAN.

## Graphics and Display

SPICE is used as the virtual display protocol.

The Omarchy VM was tested with VirtIO video and later with 3D acceleration
and OpenGL enabled.

When OpenGL is enabled in virt-manager, the SPICE **Listen Type** may need to
be set to **None**. virt-manager reports this requirement when incompatible
settings are selected.

3D acceleration can improve desktop responsiveness for graphical Linux
guests but introduces another layer between the guest desktop and the
physical graphics hardware.

Display behavior observed inside a VM should therefore not automatically be
assumed to be a problem with the guest operating system.

# VM Operations

## List Virtual Machines

List all virtual machines managed by the system libvirt connection:

```bash
virsh -c qemu:///system list --all
```

As last verified on 2026-09-12:

```text
 Id   Name      State
--------------------------
 -    omarchy   shut off
```

## Starting and Stopping

Virtual machines can be started and stopped through virt-manager.

A normal guest shutdown is preferred to forcibly stopping the virtual
machine whenever possible.

The host can remain running with a VM shut off without consuming guest CPU or
memory resources. The VM's virtual disks and configuration remain stored on
the host.

## Snapshots

Snapshots provide a convenient recovery point before significant guest
changes.

A useful workflow is:

1. Shut down the guest when practical.
2. Create a snapshot.
3. Start the guest.
4. Perform the experimental change.
5. Restore the snapshot if the change needs to be discarded.

Snapshots are useful during experimentation but should not be treated as a
replacement for backups of important data.

## Host Resource Considerations

A running VM consumes host CPU, memory, storage I/O, and graphics resources.

A shut-down VM consumes persistent storage for its virtual disks, snapshots,
and configuration but does not consume meaningful CPU or guest memory.

Old experimental VMs should eventually be removed when they are no longer
useful so their virtual disks do not consume unnecessary storage.

# Operational Checks

Verify hardware virtualization:

```bash
lscpu | grep -i virtualization
```

Verify KVM modules:

```bash
lsmod | grep kvm
```

Verify installed packages:

```bash
pacman -Q qemu-desktop libvirt virt-manager dnsmasq edk2-ovmf
```

Verify libvirt:

```bash
systemctl is-enabled libvirtd.service
systemctl is-active libvirtd.service
```

Verify user permissions:

```bash
groups
```

Verify the default network:

```bash
virsh -c qemu:///system net-info default
```

List virtual machines:

```bash
virsh -c qemu:///system list --all
```

# Troubleshooting

## libvirt Connection

If `virsh` cannot find a VM, network, or other resource that is visible in
virt-manager, confirm which libvirt connection is being used.

Explicitly test the system connection:

```bash
virsh -c qemu:///system list --all
```

A command run against `qemu:///session` sees a different libvirt environment
from one run against `qemu:///system`.

## Networking

If a guest cannot reach the network, verify the default libvirt network:

```bash
virsh -c qemu:///system net-info default
```

Confirm:

```text
Active:         yes
Autostart:      yes
Bridge:         virbr0
```

Also verify that the guest network adapter is connected to the `default`
virtual network in virt-manager.

## Permissions

If virt-manager repeatedly requests authentication or cannot manage
system-level virtual machines, verify membership in the `libvirt` group:

```bash
groups
```

After adding a user to the group, log out and back in or reboot so the new
group membership takes effect.

## Display and Resolution

Guest display sizing can differ from running the same operating system on
physical hardware.

Check:

- Guest resolution
- virt-manager display scaling
- SPICE configuration
- VirtIO video configuration
- Full-screen or maximized-window behavior

Do not assume an application sizing problem is caused by the guest operating
system until the virtualization display layer has been considered.

## 3D Acceleration

If OpenGL or 3D acceleration causes display problems, temporarily disable 3D
acceleration and compare behavior.

When OpenGL is enabled with SPICE, verify that the configured Listen Type is
compatible. A Listen Type of **None** was required during the Omarchy VM
experiment.

# Lessons Learned

The initial Omarchy evaluation demonstrated that virtual machines are useful
for learning an unfamiliar operating system without disturbing the existing
Arch installation.

The VM provided enough functionality to evaluate the Omarchy desktop,
applications, Internet connectivity, audio, Neovim configuration, and general
workflow before attempting a physical installation.

It also demonstrated an important limitation of VM-based evaluation:
virtualization can introduce behavior that does not exist on physical
hardware.

For example, LibreOffice displayed an oversized Save dialog while Omarchy was
running in the VM. After Omarchy was installed on physical hardware, the Save
dialogs were sized normally. The original behavior was therefore associated
with the virtualized display environment rather than an inherent Omarchy or
LibreOffice problem.

Virtual-machine testing should consequently be treated as an excellent first
evaluation environment, but hardware-sensitive behavior should be verified on
physical hardware before drawing conclusions about the guest operating
system.

# Related Documentation

- `docs/references/download-verification.md` — Verify downloaded installation
  media and other signed downloads before use.
- `docs/machine-status.md` — Current status of the primary computers.
