# Created by Jordan Lydon / TurnTheLydon
# There is no implied warranty or promised support with this script
# You can create your own user if you'd like for security reasons, this is just sanitized from my environment

Net user TTLUser jHysuHcSydDw8s /add
Net LocalGroup administrators TTLUser /add

$InstallPath = "C:\Users\TTLUser\Desktop\Installers"
$TempPath = "C:\Users\TTLUser"
$Users = "C:\Users\"

$ProgressPreference = "SilentlyContinue"

New-Item -Path "C:\Users\TTLUser\Desktop\" -Name "Installers" -ItemType "directory"

$Firefox = Test-Path -Path "C:\Program Files\Mozilla Firefox" 
Write-Output $Firefox

if ($firefox -eq 'True') {
}

else {
CD $InstallPath 
Invoke-WebRequest -URI "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US" -OutFile "Firefox.exe"
}


$Chrome = Test-Path -Path "C:\Program Files\Google\Chrome"
Write-Output $Chrome

if ($Chrome -eq 'True') {
}

else {
CD $InstallPath
Invoke-WebRequest -URI "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B03249C4B-E66F-36A9-50D9-677B1E50E8B4%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe" -OutFile "Chrome.exe"
}


$O365 = Test-Path -Path "C:\Program Files\Microsoft Office 15" 
Write-Output $O365

if ($O365 -eq 'True') {
}

else {
CD $InstallPath
Invoke-WebRequest -URI "https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=O365BusinessRetail&platform=Def&language=en-us&TaxRegion=pr&correlationId=28d7877c-dfd4-4dc7-95ab-27dedd969f5e&token=02422a7e-99ce-4d20-ab44-8af6f7f28c7d&version=O16GA&source=O15OLSO365&Br=2" -OutFile "O365.exe"
}


$Adobe = Test-Path -Path "C:\Program Files\Adobe"
Write-Output $Adobe

if ($Adobe -eq 'True') {
}

else {
CD $InstallPath
Invoke-WebRequest -URI "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/2001320064/AcroRdrDC2001320064_en_US.exe" -OutFile "Adobe.exe"
}


CD $InstallPath
Start-Process .\Chrome.exe -ArgumentList "/silent /install" -Wait
Start-Process .\Firefox.exe -ArgumentList "/S" -Wait
Start-Process .\O365.exe -Wait
Start-Process .\Adobe.exe -ArgumentList "/sALL /msi EULA_ACCEPT=YES" -Wait

CD $Users
Remove-Item -Path $TempPath -recurse
Net user TTLUser /delete