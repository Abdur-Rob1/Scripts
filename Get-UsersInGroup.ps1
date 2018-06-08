﻿<#
.Synopsis
   Script which retrieves the all the users within an AD Goup.
.DESCRIPTION
   Script which will use PowerShell to retrieve all members from a specified goup and export this to a CSV.
.EXAMPLE
   Get-UsersInGroup -GroupName
#>

function Get-UsersInGroup
{
   [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False,
                    HelpMessage="Computer name or IP address")]
        [string[] ] $Group,
                    $Location
)
            
    Begin
    {

    $Group = Read-Host -Prompt "Enter the group name"

        $Location = Read-Host -Prompt "Enter the output location for the CSV"

    }

    Process {

    # Get the users from the group

        $Members = Get-ADGroupMember -Identity "acumension" | Get-ADUser | select givenname, surname, userprincipalname

      $Members | Export-Csv -Path $Location -NoTypeInformation

    }

    End
    {
    }
}

Get-UsersInGroup