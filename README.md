# Daniele's Tools Test Administrator
DTTestAdministrator <br/>
Tests if script is running with administrator privileges. Restarts calling script with administrator privileges. <br/>
Copyright (C) 2022 daniznf

### Description
This module permits to test if calling script is running with administrator privileges.
It also permits to restart calling script with administrator privileges, using the same parameters used to run calling script.

### Install
Run DTInstallModule.ps1 in DTTestAdministrator directory (https://github.com/daniznf/DTInstallModule), or copy module directory into one of directories in $env:PSModulePath.

### Uninstall
Delete DTTestAdministrator directory from the one you chose in $env:PSModulePath.

### Example
```
if (-not (Test-Administrator))
{
    Write-Output "Restarting as administrator..."
    Restart-AsAdministrator -BypassExecutionPolicy -BoundParameters $PSBoundParameters

    exit
}
```