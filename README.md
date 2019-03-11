# Notes

Before finalizing the branch of a new version, make sure both Brew and Chocolatey have been updated, working, and approved.

Any pull requests from this repo will be evaluated, so please provide verbose commit comments and history or the PR will be rejected.

Since 19.1.0, installation instructions have been significantly simplified.

## Chocolatey

Update the installation path in chocolateyinstall.ps1

Pack the file from the command line
```cmd
choco pack
```

Before submitting to the Chocolatey store, you will need to test locally.

Run these commands when in the /Files/chocolatey folder (the first one uninstalls previous versions of the sdfcli - which is required to get a proper test of the project).

The command must be run in a PowerShell or CMD window running as Admin (Git Bash or similar cli tool will not work).

If you have a previous version of the sdfcli installed you will need to remove that first.

```cmd
choco uninstall sdfcli
choco install sdfcli -dv -s . -source "'.;https://chocolatey.org/api/v2/'"
```

Once a build works, push to Chocolatey from the same command line:

```cmd
choco push sdfcli.XX.X.X.nupkg -s https://push.chocolatey.org/
```

You will need an API key to the Limebox Chocolatey account. This will not be publically shared, you must be a part of the Limebox organization to push this product. Pull requests on this project will need to be approved by a Limebox moderator to then be submitted to Chocolatey.

## Brew

Update the download path in the brew/sdfsdk.rb file.

Since brew won't allow me to officially post this on the brew list, so the ruby recipe needs to be updated on the [Limebox NetSuite Homebrew repo](https://github.com/limebox/homebrew-netsuite).