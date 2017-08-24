$installParent = $env:USERPROFILE
$appDir = Join-Path $installParent "sdfcli"

Remove-Item –path $appDir -Force -Recurse

$oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newPath = ($oldPath.Split(';') | Where-Object { $_ -ne $appDir }) -join ';'

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath