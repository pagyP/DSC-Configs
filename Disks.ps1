Configuration Disks
{
  $DriveLetters = 'EFGHIJKLMNOPQSRT'
  Import-DscResource -ModuleName xStorage

  Node localhost
  {
    Get-Disk | Where-Object {$_.NumberOfPartitions -lt 1} | Foreach-Object {
      Write-Verbose "disk($($_.Number))" -Verbose
      xDisk "disk($($_.Number))"
      {
        DriveLetter = $DriveLetters[$_.Number]
        DiskNumber = $_.Number
        FSFormat = 'NTFS'        
      }
    }
  }
}