# Add-RandomJunk
A cmdlet to add random junk to a collection of powershell cmdlets or a single .ps1 file
Currently I have only tested this with the full PowerSploit toolkit, other mileage may vary
I'll test it out on others at a later date.
Using the following command line

Add-RandomJunk -Length 2048 -path C:\Users\daveh\Desktop\PowerSploit -newpath c:\users\daveh\Desktop\new-powersploit -suffix 20

The length of the random junk has a 'jitter' of plus/minus 50 to add to the randomness of the files.

The length of the file name suffix can be adjusted also.
