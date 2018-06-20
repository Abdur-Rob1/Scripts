<#
#Script name: Remove ScriptPath
#Creator: Abdur Rob
#Date: 2018-06-20
#Revision: 2
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
                    HelpMessage = "Enter the Username",
                    Position = 0,
                    ValueFromPipeLine = $true,
                    ValueFromPipeLineByPropertyName = $true)]
        [Alias('User')]
                    $Username = (Get-ADUser -Identity abdur-rob1 | Select-Object -ExpandProperty SamAccountName),
                    
        [Parameter(Mandatory=$False,
                    HelpMessage = "Enter the Script name",
                    Position = 1)]
                    [Alias('Script')]
        [string[] ] $ScriptValue = "Test"


    )

    Begin
    {                                                                             
    }

    Process {
    
                ForEach-Object {
               
                        #Get the users ScriptPath property and check if it matches

                if ( (Get-ADUser -Properties * -Identity $Username | Select-Object ScriptPath) -match $ScriptValue)
                

                {
                        #Set-ADUser -ScriptPath $null

                        #Write the ouput for testing

                        Write-Host $Username.ToUpper() "Does have a Script Path Set"
                }
                
                #If the user has anything else set in the ScriptPath property then display the value
                
                 else {

                        #Write the ouput for testing

                        Write-Host $Username.ToUpper() "Has the current Logon Script Set in their profile:" (Get-ADUser -Properties * -Identity $Username | Select-Object -ExpandProperty ScriptPath)
                        
                    }


                }

            }

    End
    {
    }

}

#Call function and format the list

Remove-ScriptPath | Format-List
