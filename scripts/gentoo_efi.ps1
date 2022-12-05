# Set VM Name, Switch Name, and Installation Media Path.
$VMName = 'gentoo_efi'
$Switch = 'Default Switch'
$InstallMedia = 'C:\iso\install-amd64-minimal-20221122T220204Z.iso'

# Create New Virtual Machine
New-VM -Name $VMName `
       -Generation 2 `
       -MemoryStartupBytes 8GB `
       -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName\$VMName.vhdx" `
       -NewVHDSizeBytes 20GB `
       -Path "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName" `
       -Switch $Switch

# Disable Dynamic Memory
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

# Set processor count and dynamic memory
Set-VMProcessor -VMName $VMName -Count 4

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