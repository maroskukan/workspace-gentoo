# Gentoo Development Machine Workspace

- [Gentoo Development Machine Workspace](#gentoo-development-machine-workspace)
  - [Introduction](#introduction)
  - [Host Hypervisor settings](#host-hypervisor-settings)
    - [Hyper-V](#hyper-v)
  - [Installation](#installation)


## Introduction

This repository contains notes for a fresh Gentoo Linux installation.


## Host Hypervisor settings

Download the latest Minimal Installation CD file from [Gentoo website](https://www.gentoo.org/downloads/).

### Hyper-V

In order to boot the Arch ISO you need to disable Secure Boot in VM settings. Create a generic Generation v2 VM with 2vCPU, 2048 Mb RAM, and 20GB HDD abd connect to `Default Switch`.

> **Warning**: You are not using elevated privileges ensure that your user account is member of Hyper-V Administrators group.



```powershell
# Set VM Name, Switch Name, and Installation Media Path.
$VMName = 'gentoo_efi'
$Switch = 'Default Switch'
$InstallMedia = 'C:\iso\install-amd64-minimal-20220911T170535Z.iso'

# Create New Virtual Machine
New-VM -Name $VMName `
       -Generation 2 `
       -MemoryStartupBytes 2GB `
       -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName\$VMName.vhdx" `
       -NewVHDSizeBytes 20GB `
       -Path "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName" `
       -Switch $Switch

# Set processor count and dynamic memory
Set-VM -VMName $VMName -ProcessorCount 2

# Disable Secure Boot
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive

# Start Virtual Machine
Start-VM -Name $VMName
```


## Installation

Once you are dropped in the live CD shell, start the SSH server with `/etc/init.d/sshd start` and set `root` password with `passwd` or `chpasswd` this gives you remote access the installation via SSH as oppose to using Virtual Console.

```bash
echo "root:gentoorocks"|chpasswd
```

Finally, retrieve the installation environment IP address.

```bash
ip a show dev eth0
```
