Configuration Disks
{
  $DriveLetters = 'EFGHIJKLMNOPQSRT'
  Import-DscResource -ModuleName StorageDsc

  Node localhost
  {
    Get-Disk | Where-Object {$_.NumberOfPartitions -lt 1} | Foreach-Object {
      Write-Verbose "disk($($_.Number))" -Verbose
      Disk "disk($($_.Number))"
      {
        DriveLetter = $DriveLetters[$_.Number]
        DiskNumber = $_.Number
        FSFormat = 'NTFS'        
      }
    }
  }
}