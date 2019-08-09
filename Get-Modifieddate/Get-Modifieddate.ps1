function Get-Modifieddate {

    Param( 
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType 'container' })]  
        [string] $Path,
        [switch]$ShowWindow
    )
    
    Begin {
    
        $main = [System.IO.DirectoryInfo]::new("$Path")
        #Retreiving all directories under the variable dir
        $dir = $main.GetDirectories()
    
    }
    
    Process {
        $result = foreach ($i in $dir) {
    
        try {
            #Prefered to use Foreach method for faster the query
            $i.GetFileSystemInfos("./", [System.IO.SearchOption]::AllDirectories).
            ForEach( 
                    { $length += $_.length })
            
            #Sortin out the last modified date
            $modified =$i.GetFileSystemInfos("./",[System.IO.SearchOption]::AllDirectories)|
                    sort -Property LastWriteTime | select -Last 1
    
                if ((Get-Date).AddMinutes(-60) -lt $modified.LastWriteTime) {
    
                    $span = New-TimeSpan -Start $modified.LastWriteTime -End (Get-Date)
                    $time = "{0:mm} Minutes Ago" -f $span
                }
                else {
                    $time = "{0:g}" -f (Get-date)
                }
        
                [PSCustomObject]@{
                    DirectoryName  = $i.Name
                    Size           = if ($length / 1GB -gt 1) {
                                     "{0:N0} GB" -f ($length / 1GB) 
                                     }elseif ($length / 1MB -gt 1) { 
                                    "{0:N0} MB" -f ($length / 1MB) 
                                     }else { "{0:N0} KB" -f ($length / 1KB) }
                    "AffectedFile" = if($modified.Name ){$modified.Name}else{"--"}
                    "Modified"     = $time
                }
    
            }
    
            catch { }
        }
    }
    
    end {
        if($PSBoundParameters.ContainsKey('ShowWindow')){
            return $result | Out-GridView
        }
        return $result | FT -AutoSize
    }
}