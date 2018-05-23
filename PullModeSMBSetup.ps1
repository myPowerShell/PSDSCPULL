################################################################
# Pull mode SMB Example

###############################################################
# Pull Mode DSC Setup Example Review

New-SmbShare -Name DSCShare -Path C:\Working\Official\DSCShare -Description 'File share for DSC modules' -ReadAccess everyone -Verbose

Find-Module xPSDesiredStateConfiguration | Save-Module -Path C:\Working\Official\DownloadedModules -Verbose

Compress-Archive -Path C:\Working\Official\DownloadedModules\xPSDesiredStateConfiguration\8.2.0.0\* -DestinationPath C:\Working\Official\DSCShare\xPSDesiredStateConfiguration_8.2.0.0.zip -Verbose
New-DscChecksum -Path C:\Working\Official\DSCShare\xPSDesiredStateConfiguration_8.2.0.0.zip -OutPath C:\Working\Official\DSCShare -Verbose


