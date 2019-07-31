param ($Task = 'Default')

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

$dependentModules = @('Pester','BuildHelpers','Psake','PSDeploy')

foreach ($module in $dependentModules){
    
        Install-Module -Name $module -Force
    
}

#Import-Module Psake, BuildHelpers

Set-BuildEnvironment -Force

Get-ChildItem Env:BH*

Invoke-psake -buildFile .\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )