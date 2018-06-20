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
          #Get all the users properties from AD and create variables
          
                $Username = Get-ADUser -Properties * -Identity abdur-rob1

                #$Username = Get-ADUser -Properties * -Filter *
                
                    #$ScriptPath = "SBS_LOGIN_SCRIPT.bat"
                                        
                        $ScriptValue = "Test"
                                    
    }

    Process {
    
                foreach ($User in $username) {
               
                        #Get the users ScriptPath property and check if it matches

                if ($User.ScriptPath -eq "Test")
                

                {
                        #Set-ADUser -ScriptPath $null
                        #Clear-ItemProperty -Name ScriptPath -Path $Username.ScriptPath

                        Write-Output "$User DOES HAVE a Script Path Set"
                }
                
                #If the user has anything set in the ScriptPath property then delete the value
                              
                 elseif ($User.ScriptPath -ne "$ScriptValue")
                 
                {
                        #Set-ADUser -ScriptPath $null
                        #Clear-ItemProperty -Name ScriptPath -Path $Username.ScriptPath
                        
                        Write-host  "$User DOES NOT have a Script Path Set"
                }
                
                #Skip the user if nothing is set

                 else {

                 Write-Output "$User NOTHING in Script Path Set"
                        
                    }


                }

            }

    End
    {
    }

}

#Call function and format the list

Remove-ScriptPath | Format-List
