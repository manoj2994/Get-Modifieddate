$Moduleroot = Resolve-Path "$PSScriptRoot\.."
$test = "$Moduleroot\*.psm1"
import-module $test

Describe "Get-Modifieddate Unit Testing" {
    It "Checking the Path Parameter is mandatory" {
        (Get-command -Name Get-Modifieddate ).Parameters['Path'].Attributes.mandatory | Should -BeTrue
    }
    
}
