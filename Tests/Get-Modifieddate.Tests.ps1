$Moduleroot = Resolve-Path "$PSScriptRoot\.."
$test = "$Moduleroot\*.psm1"
#import-module $test

Describe "Get-Modifieddate" {
    It "does something useful" {
        $true | Should -Be $true
    }
    It "Testing path"{
        Test-Path $test | Should -BeFalse
    }
}
