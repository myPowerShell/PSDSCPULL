# Pull Client Configuration

[DSCLocalconfigurationManager()]
Configuration PullClientConfigID 
{
    param
        (
            [Parameter(Mandatory=$true)] 
            [string[]]$ComputerName,

            [Parameter(Mandatory=$true)]
            [string]$guid 
        )
        
    Node $ComputerName
    {
        Settings {
                    ConfigurationID = $guid
                    RefreshMode = 'Pull'
                    RefreshFrequencyMins = 30
                    ConfigurationModeFrequencyMins = 60
                    ConfigurationMode = "ApplyAndAutocorrect"
                    AllowModuleOverwrite = $true
                    RebootNodeIfNeeded = $true
                }
          
        ConfigurationRepositoryShare SmbConfigShare 
            {
                Sourcepath = "\\Apollo2\DSCShare" 
            }
        
        ResourceRepositoryShare SmbResourceShare
            {
                SourcePath = '\\Apollo2\DSCShare'
            }  
    }
}



$ComputerName='Apollo2'
$guid=[guid]::NewGuid()

PullClientConfigID -ComputerName $ComputerName -Guid $guid -OutputPath C:\DSC
Set-DscLocalConfigurationManager -ComputerName $ComputerName   -Path C:\DSC -Verbose

# Command to initiate DSC consistancy for Pull
Update-DscConfiguration -wait -verbose