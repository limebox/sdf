(right now these are scribbles. They will be updated shortly.)

# Notes

Before finalizing the branch of a new version, make sure both Brew and Chocolatey have been updated, working, and approved.

Any pull requests from this repo will be evaluated, so please provide verbose commit comments and history or the PR will be rejected.

## Chocolatey

Before submitting to the Chocolatey store, you will need to test locally:

Run this command when in the /Files/chocolatey folder.

```cmd
choco install sdfcli -dv -s . -source "'.;https://chocolatey.org/api/v2/'"
```

The command must be run in a PowerShell or CMD window running as Admin (Git Bash or similar cli tool will not work).

If you have a previous version of the sdfcli installed you will need to remove that first.

Once a build works, push to Chocolatey from the same command line:
```cmd
choco push sdfcli.18.1.2.nupkg -s https://push.chocolatey.org/
```

(You will need an API key to the Limebox Chocolatey account. This will not be shared and you must be a part of the organization to push this product)

```cmd
choco uninstall sdfcli
```

## Brew

Since brew won't allow me to officially post this on the brew list, so the ruby recipe needs to be updated on the [Limebox NetSuite Homebrew repo](https://github.com/limebox/homebrew-netsuite). It must point to the file hosted on this repository, /Files/brew/sdfcdk-18.1.2.tar.gz. Don't forget to update the SHA256 of the .tar.gz file by running:

### Mac
```cmd
openssl sha -sha256 sdfsdk-18.1.2.tar.gz
```

### PC
```cmd
CertUtil -hashfile sdfsdk-18.1.2.tar.gz SHA256
```