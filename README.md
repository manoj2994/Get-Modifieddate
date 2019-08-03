# Get-Modifieddate

[![Build status](https://ci.appveyor.com/api/projects/status/4319d1qug69yplsc?svg=true)](https://ci.appveyor.com/project/manoj2994/get-modifieddate)

This Module will help you to find the changed file and its modified date inside the folder,Generally in windows the folder modified date will not change if the file inside is changed.consider you are having a folder inside large number of sub-folders and files that you want to monitor or  to know about the file changed folder .this module will come in handy to know the folder last modified date and the affected file.

```PowerShell
    Example: 1
    Get-Modifieddate -Path  "C:\windows"

    Example: 2
    Get-Modifieddate -Path "C:\windows" -ShowWindow
    ```
