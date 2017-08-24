$bin = Join-Path $(Split-Path -Parent $MyInvocation.MyCommand.Definition) "bin"
$installFolder = $env:USERPROFILE

New-Item "$installFolder\sdfcli" -type directory

$appDir = Join-Path $installFolder "sdfcli"

Copy-Item "$bin\*" $appDir

(Get-Content "$appDir\sdfcli.bat").replace('[APP_PATH]', $appDir) | Set-Content "$appDir\sdfcli.bat"

$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newpath = "$oldpath;$appDir"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath