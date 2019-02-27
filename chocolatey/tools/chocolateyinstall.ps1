$root = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$bin = Join-Path $root "bin"
$installParent = $env:USERPROFILE

$testPath = "$installParent\sdfcli"

If(!(test-path $testPath)) {
    New-Item "$installParent\sdfcli" -type directory
}

$appDir = Join-Path $installParent "sdfcli"

Copy-Item "$bin\*" $appDir

(Get-Content "$appDir\sdfcli.bat").replace('[APP_PATH]', $appDir) | Set-Content "$appDir\sdfcli.bat"

$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newpath = "$oldpath;$appDir"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

$mklinkCommand = 'cmd /c mklink "$appDir\.clicache" "..\.clicache"'

invoke-expression "$mklinkCommand"