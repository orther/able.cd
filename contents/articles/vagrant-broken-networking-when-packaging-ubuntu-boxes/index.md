---
layout: post
title: "Vagrant: Broken Networking When Packaging Ubuntu Boxes"
date: 2012-04-09 18:25
comments: true
author: orther
template: article.jade
---

When packaging my [Vagrant](http://vagrantup.com/) virtual environment (Ubuntu server with a host-only
network) to a box file I ran into a problem. The issue was that when I tried to use that box file the
host-only network would not work.

With a little investigating I realized the problem was caused by the device name for the network
adapter being `eth2` instead of `eth1`. Vagrant uses `eth1` in the host-only network interface
defined in the `/etc/network/interfaces` file. Since `eth1` network interface doesn't
exist (it is `eth2`) our host-only network does not work.

<span class="more">

### The Cause

Ubuntu uses [udev](http://wiki.debian.org/udev) to dynamically set device names (`eth1` for example).
Ubuntu stores persistent udev rules for network devices in the
`/etc/udev/rules.d/70-persistent-net.rules` file. Below is the `70-persistent-net.rules` file from
the broken host-only network VM.

```bash
# PCI device 0x8086:0x100e (e1000)
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:57:fd:7b", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"

# PCI device 0x8086:0x100e (e1000)
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:53:22:32", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth1"
```

You can see there exists a rule for `eth1`. The reason the host-only network adapater is assigned
`eth2` instead of `eth1` is because it's MAC address doesn't match the udev rule. The reason the MAC
address doesn't match is because when Vagrant creates a new VM (from the box file) VirtualBox by
default generates a random MAC address for that network adapter.

### The Solution

The solution is to remove the persitant network udev rules immediately before you package the box
file. This allows network adapters to be assigned device names without any MAC address issues.

#### Packaging Steps

1. SSH into running VM and remove the persistant network udev rules file:

        sudo rm /etc/udev/rules.d/70-persistent-net.rules

2. Shutdown the VM and package it:

        vagrant halt && vagrant package
