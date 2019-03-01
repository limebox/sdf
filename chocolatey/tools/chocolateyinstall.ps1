$root = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$bin = Join-Path $root "bin"
$installParent = $env:USERPROFILE

$version = "19.1.0"
$testParent = "$installParent\sdfcli"
$testPath = "$installParent\sdfcli\$version"

If(!(test-path $testParent)) {
    New-Item "$testParent" -type directory
}

If(!(test-path $testPath)) {
    New-Item "$testPath" -type directory
}

$appParent = Join-Path $installParent "sdfcli"
$appDir = Join-Path $installParent "sdfcli\$version"

Copy-Item "$bin\*" $appDir

(Get-Content "$appDir\sdfcli.bat").replace('[APP_PATH]', $appDir) | Set-Content "$appDir\sdfcli.bat"

$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newpath = "$oldpath;$appParent"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

$mklinkclicache = 'cmd /c mklink "$appDir\.clicache" "..\.clicache"'
$mklinksdfcli = 'cmd /c mklink "$appParent\sdfcli" ".\$version\sdfcli.bat"'

invoke-expression "$mklinkCommand"
invoke-expression "$mklinksdfcli"