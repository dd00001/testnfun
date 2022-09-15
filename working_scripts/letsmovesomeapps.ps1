#############################################
#											#					
#	web.deploy automation					#
#											#
#	Dawid D									#
#	14.09.2022								#																						
#											#
#############################################



$profilepath = $env:HOMEPATH
$folderpath="C:\$profilepath\Desktop"
$foldername="_migrate"



write-host "Temporary destination path for exporting sites is on your Desktop => $folderpath "
	if (!(Test-Path $folderpath))
		{
		New-Item -Path $folderpath -Name $foldername -ItemType "directory"
		}
		else
		{
		write-host "Folder already exists `n`n" -ForegroundColor Green
		}

write-host "Here you can find list of all IIS apps available on this machine `n "
Get-website

do {
	$msg = 'Please provide IIS ID of the app you want to migrate and press enter (write "exit" to close)'

    $response = Read-Host -Prompt $msg
	$patharchive="$folderpath\$foldername\"
	$filenamesite="Site$response.zip"
	$filenamelog="Site$response.log"
	$fullpath="$patharchive$filenamesite"
	$pathwebdeploy='"C:\Program Files\iis\Microsoft Web Deploy V3\.\msdeploy"'
	
    if ($response -ne 'exit') 
	{
	cmd /c "$pathwebdeploy -verb:sync -source:metakey=lm/w3svc/$response -dest:archivedir=$fullpath -enableLink:AppPoolExtension > $filenamelog"
	
	write-host "Please check $folderpath\$foldername for zip package" -backgroundcolor Green -foregroundcolor black
    }
} until ($response -eq 'exit')


