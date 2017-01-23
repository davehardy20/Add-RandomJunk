﻿Function Add-RandomJunk{
    <#
            .Synopsis
            Add random junk to a file and append a random suffix to the file name.

            .Description
            The cmdlet will t

            .Parameter Length
            The amount of junk to generate.

            .Parameter Path
            The path of the powershell files (ps1, psm1 & psd1), Can be a single file or nested folders.

            .Parameter Newpath
            The name of the new location for the junkified file/s.

            Written by Dave Hardy, davehardy20@gmail.com @davehardy20

            Version 0.1

            .Example
            PS> Add-RandomJunk -Length 2048 -path C:\Users\daveh\Desktop\PowerSploit -newpath c:\users\daveh\Desktop\new-powersploit


    #>
param (
    [int]$Length, #length of random junk added to begining of file
    [String]$path, #source of files
    [String]$newpath #place of junkified files
)

$set    = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!£$%^&*()_+}{[]#~'@;:".ToCharArray()
$result = ""
$Jitter = Get-Random -Minimum -50 -Maximum 50 #randomise the length of the added junk
$RandomLength = $Length - $Jitter
for ($x = 0; $x -lt $RandomLength; $x++) {
    $result += $set | Get-Random 
}
$begin = "<#`n"
$end = "`n#>`nStart-Sleep -Seconds 10"
$final = $begin+$result+$end
$randomfilename = -join ((65..90) + (97..122) | get-random -Count 10 | % {[char]$_})

#make a backup of the original files / folders
$backup = $path + 'backup'
Copy-Item -Path $path -Destination $backup -Recurse
$files = Get-ChildItem -Recurse -Path $path -Exclude -neq -Filter *.ps*1
foreach ($file in $files)
{
@($final) + (Get-Content $file) | Set-Content $file
Rename-Item $file -NewName ($file.BaseName + "-" + $randomfilename + $file.Extension)
}
Rename-Item $path $newpath -Force
Rename-Item $backup $path -Force
}