Add-Type -AssemblyName System.IO.Compression.FileSystem

$ns_version = "19.1"
$root = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$bin = Join-Path $root "bin"
$installParent = $env:USERPROFILE

$test_parent = "$installParent\sdfcli"

If(!(test-path $test_parent)) {
    New-Item "$test_parent" -type directory
}

$app_dir = Join-Path $installParent "sdfcli"

$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$install_url = "https://system.netsuite.com/download/suitecloud-sdk/cli/java/$ns_version/sdf-cli.zip"

# Install the CLI Tool
$installation_args = @{
    packageName    = 'sdfcli'
    url            = $install_url
    url64bit       = $install_url
    unzipLocation  = $app_dir
    checksum       = 'f51d4647bb863241583df23ffbcc434af08bffe3e6c7b280a16d2aa43194611a'
    checksumType   = 'sha256'
    checksum64     = 'f51d4647bb863241583df23ffbcc434af08bffe3e6c7b280a16d2aa43194611a'
    checksumType64 = 'sha256'
}
 
Install-ChocolateyZipPackage @installation_args


# Add the CLI tool to the PATH
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$appParent"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

# Add a shortcut to the .clicache file
$mklinkclicache = 'cmd /c mklink "' + $app_dir + '\.clicache" "..\.clicache"'
invoke-expression "$mklinkclicache"