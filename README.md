# Gentoo Development Machine Workspace

- [Gentoo Development Machine Workspace](#gentoo-development-machine-workspace)
  - [Introduction](#introduction)
  - [Documentation](#documentation)
  - [Host Hypervisor settings](#host-hypervisor-settings)
    - [Hyper-V](#hyper-v)
      - [EFI-based VM (Generation 2)](#efi-based-vm-generation-2)
  - [Installation - EFI based machine](#installation---efi-based-machine)


## Introduction

This repository contains notes for a fresh Gentoo Linux installation.


## Documentation

- [Gentoo as Guest OS in Hyper-V](https://wiki.gentoo.org/wiki/Hyper-V)


## Host Hypervisor settings

Download the latest Minimal Installation CD file from [Gentoo website](https://www.gentoo.org/downloads/).

### Hyper-V

#### EFI-based VM (Generation 2)

In order to boot the Gentoo Live ISO you need to disable Secure Boot in VM settings. Create a generic Generation v2 VM with 4vCPU, 8192 Mb RAM, and 20GB HDD abd connect to `Default Switch`.

> **Warning**: You are not using elevated privileges ensure that your user account is member of Hyper-V Administrators group.

Simple script for crating an EFI-based virtual machine can be referenced at `./scripts/gentoo_efi.ps1`


## Installation - EFI based machine

Once you are dropped in the live CD shell, start the SSH server with `openrc -s sshd start` and set `root` password with `chpasswd` this gives you remote access the installation via SSH as oppose to using Virtual Console.

```bash
echo "root:gentoorocks"|chpasswd
```

> **Tip**: The root password can also be entered as boot option with e.g. `passwd=gentroorocks`. And SSH server can be automatically started with `dosshd`.

