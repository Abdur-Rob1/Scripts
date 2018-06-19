<#
#Script name: Remove ScriptPath
#Creator: Abdur Rob
#Date: 2018-06-19
#Revision: 1
.Synopsis
   Script which retrieves the all the users with a logon script set.
.DESCRIPTION
   Script which will retrieve all users from AD with a logon script set and then delete this based on conditions.
.EXAMPLE
   Remove-ScriptPath -Username
#>

function Remove-ScriptPath
{
   [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False,
                    HelpMessage = "Enter the username",
                    Position = 0,
                    ValueFromPipeLine = $true,
                    ValueFromPipeLineByPropertyName = $true)]
        [Alias('User')]
        [string[] ] $Username
    )

    Begin
    {
          #Get all the users properties from AD 

                $Username = Get-ADUser -Properties * -Filter *

    }

    Process {

    
                foreach ($user in $username) {
               
                        #Get the users ScriptPath property and check if it matches

                If ($User.ScriptPath -match "SBS_LOGIN_SCRIPT.bat")
                
                {
                        #Set-ADUser -ScriptPath $null
                        #Clear-ItemProperty -Name ScriptPath -Path $Username.ScriptPath

                        Write-Output "$User.SamAccountName does have a Script Path Set" | Format-List
                }
                
                #If the user has anything set in the ScriptPath property then delete the value
                              
                 elseif ($User.ScriptPath -notlike "SBS_LOGIN_SCRIPT.bat") 
                 
                {
                        #Set-ADUser -ScriptPath $null
                        #Clear-ItemProperty -Name ScriptPath -Path $Username.ScriptPath
                        
                        Write-host  "$User.SamAccountName Does not have a Script Path Set" | Format-List
                }
                
                #Skip the user if nothing is set

                 else {

                 Write-Output "$User.SamAccountName Does not have anything in Script Path Set" | Format-List
                        
                    }


                }

            }

    End
    {
    }

}

Remove-ScriptPath
