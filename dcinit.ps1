Configuration dcinit
{
    Import-DSCResource -ModuleName StorageDsc
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        WindowsFeature ADDSInstall
    {
        Ensure = 'Present'
        Name = 'AD-Domain-Services'
    }
        WaitForDisk Disk2
        {
             DiskId = 2
             RetryIntervalSec = 60
             RetryCount = 60
        }

        Disk EVolume
        {
             DiskId = 2
             DriveLetter = 'E'
             FSLabel = 'Data'
             DependsOn = '[WaitForDisk]Disk2'
        }
    }
}