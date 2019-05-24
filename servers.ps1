Configuration servers {
    $Computer = 'localhost' 
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName xTimeZone
    Import-DSCResource -ModuleName SystemLocaleDsc
      
    $ConfigData = @{
      AllNodes = @(
          @{
              NodeName = "localhost"
              PSDscAllowPlainTextPassword = $True
              PSDscAllowDomainUser = $True
          }
      )
    }
    Node $Computer {
      WindowsFeature Telnet {
          Ensure = 'Present'
          Name = 'Telnet-Client'
      }
      WindowsFeature Backup {
          Ensure = 'Present'
          Name = 'Windows-Server-Backup'
      }
     
      # Disable Shutdown Tracking 
      Registry DisableShutdownTracking
      {
          Ensure = 'Present'
          Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Reliability'
          ValueName = 'ShutdownReasonOn'
          ValueData = '0'
          ValueType = 'Dword'
          Force = $true
      }
  
  # support for the Azure Patching via Automation
  Registry AzurePatchingSupport
  {
       Ensure = 'Present'
          Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
          ValueName = 'NoAutoUpdate'
          ValueData = '1'
          ValueType = 'Dword'
          Force = $true
  }
      # Set Tome Zone
    xTimeZone TimeZoneSet 
    { 
        IsSingleInstance = 'Yes' 
        TimeZone = 'GMT Standard Time' 
    }
    SystemLocale SystemLocaleExample 
    { 
        IsSingleInstance = 'Yes' 
        SystemLocale     = 'En-GB' 
    } 
      
    }
  }