<#
    Daniele's Tools Test Administrator
    Copyright (C) 2022 Daniznf

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

    https://github.com/daniznf/DTTestAdministrator
#>

function Test-Administrator
{
    $User = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = (New-Object Security.Principal.WindowsPrincipal $User)
    return $Principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    <#
        .SYNOPSIS
        Returns $true if calling script is run with administrator privileges.

        .NOTES
        Thanks to https://serverfault.com/a/97599
    #>
}

function Restart-AsAdministrator
{
    param(
        [switch]
        $BypassExecutionPolicy,

        [System.Collections.Generic.Dictionary`2[System.String,System.Object]]
        $BoundParameters
    )

    $ScriptPath = $MyInvocation.ScriptName

    $Arguments = ""

    if ($BypassExecutionPolicy)
    {
        $Arguments = "-ExecutionPolicy Bypass"
    }

    $Arguments += " -File ""$ScriptPath"""

    $BoundParameters.Keys | ForEach-Object {
        $Arguments += " -" + $_
        if ($BoundParameters[$_].GetType() -ne [System.Management.Automation.SwitchParameter])
        {
            $Arguments += " ""{0}""" -f $BoundParameters[$_]
        }
    }

    Start-Process Powershell -Verb RunAs -ArgumentList $Arguments

    <#
        .SYNOPSIS
        Launches passed script as administrator

        .PARAMETER BypassExecutionPolicy
        Use ExecutionPolicy Bypass to launch the script

        .PARAMETER BoundParameters
        Parameters to use to launch the script

        .EXAMPLE
        Restart-AsAdministrator -BypassExecutionPolicy -BoundParameters $PSBoundParameters
    #>
}

Export-ModuleMember -Function Test-Administrator, Restart-AsAdministrator
