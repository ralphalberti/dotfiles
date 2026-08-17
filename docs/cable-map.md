# Cable Map

**Version:** 1.0
**Last Updated:** 2026-08-16
**Status:** Living Document

---

# About This Document

This document records the current structured cabling layout for the home.

Unlike `home-network.md`, which describes the network architecture, this
document tracks physical cable runs, switch port assignments, wall-jack
destinations, and directly connected network devices.

It should be updated whenever cables are repatched, new devices are connected,
or additional cable runs are identified.

---

## Contents

- [Switch Summary](#switch-summary)
- [Switch Port Inventory](#switch-port-inventory)
- [Known Cable Runs](#known-cable-runs)
- [Unidentified Cable Runs](#unidentified-cable-runs)
- [Future Expansion](#future-expansion)
- [Maintenance](#maintenance)
- [Related Documentation](#related-documentation)

# Switch Summary

- **Model:** XGS-1008
- **Total Ports:** 8
- **Ports Assigned:** 8
- **Numbered Cable Runs:** 4
- **Unnumbered Connections:** 4

All eight switch ports have been investigated. Port 7 remains physically
unidentified but is recorded as an unnumbered, noncritical connection.

# Switch Port Inventory

| Switch Port | Cable | Destination / Connection | Status | Notes |
| --- | --- | --- | --- | --- |
| 1 | Unnumbered | Laundry Room → eero Pro 7 Gateway | Active | Gateway uplink |
| 2 | Unnumbered | PoE injector → Kitchen UniFi Access Point | Active | U-POE-af injector |
| 3 | Unnumbered | PoE injector → Lanai UniFi Access Point | Active | U-POE-af injector |
| 4 | #7 | Lanai Ethernet/coax wall plate | Identified | Structured cable run |
| 5 | #15 | Guest Bedroom wall jack → Guest Bedroom eero Pro 7 | Active | eero provides Ethernet connection to iMac |
| 6 | #3 | Kitchen countertop Ethernet jack | Identified | Structured cable run |
| 7 | Unnumbered | Unknown | Unidentified | Noncritical connection |
| 8 | #11 | Gathering Room wall plate | Identified | Structured cable run |

# Known Cable Runs

The numbered structured cable runs currently identified are:

| Cable | Switch Port | Destination |
| --- | ---: | --- |
| #3 | 6 | Kitchen countertop Ethernet jack |
| #7 | 4 | Lanai Ethernet/coax wall plate |
| #11 | 8 | Gathering Room wall plate |
| #15 | 5 | Guest Bedroom wall jack |

The Guest Bedroom path has been traced end-to-end:

```text
Laundry Room XGS-1008 switch
        ↓
      Cable #15
        ↓
Guest Bedroom wall jack
        ↓
Guest Bedroom eero Pro 7
        ↓
      Ethernet
        ↓
       iMac
```

Switch ports 2 and 3 use unnumbered cables. Earlier assumptions that these
connections corresponded to numbered cable runs were incorrect.

# Unidentified Cable Runs

Switch port 7 remains physically unidentified.

Current understanding:

- The cable is unnumbered.
- Its destination has not been determined.
- It is considered noncritical to the currently documented network topology.

Update this section if the destination is identified.

# Future Expansion

No switch ports are currently reserved for future devices.

Potential future devices include:

- NAS
- Home Assistant
- Additional access points
- Security cameras

These are possibilities rather than planned deployments. Update this section
when a device or port is formally reserved.

# Maintenance

Update this document whenever:

- A cable is repatched.
- A new Ethernet device is connected.
- A wall jack is identified.
- A switch port assignment changes.
- An unidentified cable run is traced.
- A port is reserved for a future device.

When a change affects the logical network architecture as well as the physical
cabling, update `home-network.md` as appropriate.

# Related Documentation

- [`home-network.md`](home-network.md)
