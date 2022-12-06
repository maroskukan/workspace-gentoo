# Set VM Name, Switch Name, and Installation Media Path.
$VMName = 'gentoo_bios'
$Switch = 'Default Switch'
$InstallMedia = 'C:\iso\install-amd64-minimal-20221122T220204Z.iso'

# Create New Virtual Machine
New-VM -Name $VMName `
       -Generation 1 `
       -MemoryStartupBytes 8GB `
       -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName\$VMName.vhdx" `
       -NewVHDSizeBytes 20GB `
       -Path "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\$VMName" `
       -Switch $Switch

# Disable Dynamic Memory
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

# Set processor count and dynamic memory
Set-VMProcessor -VMName $VMName -Count 4

# Add DVD Drive to Virtual Machine
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Start Virtual Machine
Start-VM -Name $VMName