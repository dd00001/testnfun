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



write-host "Default source path for importing sites is in your Desktop => $folderpath. Please put .zip packages in there `n"
write-host "Default destination path for application files is E:\Sites.`n`n"

	$patharchive="$folderpath\$foldername\"
	$pathwebdeploy='"C:\Program Files\iis\Microsoft Web Deploy V3\.\msdeploy"'
	write-host "`n`n"
	write-host "Please provide .txt file that contains list of IDs"
	Get-Content .\IDlist.txt | ForEach-Object {
		$currentID=$_
		$filenamesite="Site$currentID.zip"
		$fullpath="$patharchive$filenamesite"
		$filenamelog="Site$currentID.log"
		$fullpath="$patharchive$filenamesite"
	
	cmd /c $pathwebdeploy -verb:sync -source:archivedir=$fullpath -dest:metakey="lm/w3svc/$currentID" > site$currentID.log
	write-host "App ID $currentID has been imported" -backgroundcolor Green -foregroundcolor black
    }



