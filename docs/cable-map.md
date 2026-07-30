# Cable Map

This document records the current structured cabling layout for the home.

Unlike `home-network.md`, which describes the network architecture, this document tracks the physical cable runs and switch port assignments. It should be updated whenever cables are repatched, new devices are connected, or additional cable runs are identified.

## Switch Summary

- Model: XGS-1008
- Total Ports: 8
- Ports in Use: 3
- Available Ports: 5

## Switch Port Inventory

| Switch Port | Room         | Wall Jack | Connected Device   | Status | Notes                 |
| ----------- | ------------ | --------- | ------------------ | ------ | --------------------- |
| 1           | Laundry Room | —         | eero Pro 7 Gateway | Active | Gateway uplink        |
| 2           | Kitchen      | —         | UniFi Access Point | Active | Via U-POE-af injector |
| 3           | Lanai        | —         | UniFi Access Point | Active | Via U-POE-af injector |
| 4           |              |           |                    |        |                       |
| 5           |              |           |                    |        |                       |
| 6           |              |           |                    |        |                       |
| 7           |              |           |                    |        |                       |
| 8           |              |           |                    |        |                       |

## Unidentified Cable Runs

Record any cable runs whose destination has not yet been determined.

| Identifier | Notes |
| ---------- | ----- |
|            |       |

## Future Expansion

Reserved ports:

- None currently identified.

Potential future devices:

- NAS
- Home Assistant
- Additional Access Points
- Security Cameras

## Revision Notes

Update this document whenever:

- A cable is repatched.
- A new Ethernet device is connected.
- A wall jack is identified.
- A switch port assignment changes.
