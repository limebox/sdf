(right now these are scribbles. They will be updated shortly.)

# Notes

Before finalizing the branch of a new version, make sure both Brew and Chocolatey have been updated, working, and approved.

Any pull requests from this repo will be evaluated, so please provide verbose commit comments and history or the PR will be rejected.

## Unpack Jar file

In order to deploy this system, you must download the latest Eclipse SDF Jar file and unpack it. To do this, navigate to the Eclipse SDK file that you downloaded from the NetSuite help docs, and use this command (Mac or PC). To make it easier, make sure you run this command inside a subfolder as several files will be extracted that you will not use.

```cmd
jar xf com.netsuite.ide.eclipse.ws_XXXX.X.X.jar
```

The axis.jar and NetSuiteWebService.jar files are the ones needed for the SDK. They must always be replaced during an update.

## Chocolatey

### Checklist
* Did you download the latest Windows suplemental files from the NetSuite help center?
* Did you update the .jar file reference names in the VERIFICATION.txt file?
* Did you update the .md5 value for the downloaded files?
* Did you update the .jar file reference names in the sdfcli.nuspec file?
* Did you update the .jar file reference name in the pom.xml file?
* Did you delete the old .jar files?

### Setting the MD5 hash

### PC
```cmd
CertUtil -hashfile sdfsdk-XX.X.X.tar.gz MD5
```

To pack the choco file once the checklist is complete:
```cmd
choco pack
```

Move the sdfcli.XX.X.X.nupkg to /Files/chocolatey/ in this repository and remove the old file.

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

### Checklist
* Did you download the latest Mac suplemental files from the NetSuite help center?
* Did you replace the default SDFSDK reference location in the sdfcli file (SDFSDK_PATH=/usr/local/Cellar/sdfcli/XX.X.X/libexec/)
* Did you confirm the .jar file reference name in the pom.xml file?
* Did you update the .jar file reference name in the sdfsdk.rb file?
* Did you package the project inside a .tar.gz file?
* Did you update the SHA256 value for the .tar.gz file created for the project?
* Did you delete the old .jar files?
* Did you update the /share/man/sdfsdk to the latest version of the manual from the CLI tool?

Since brew won't allow me to officially post this on the brew list, so the ruby recipe needs to be updated on the [Limebox NetSuite Homebrew repo](https://github.com/limebox/homebrew-netsuite). It must point to the file hosted on this repository, /Files/brew/sdfcdk-XX.X.X.tar.gz. Don't forget to update the SHA256 of the .tar.gz file by running:

### Mac
```cmd
openssl sha -sha256 sdfsdk-XX.X.X.tar.gz
```

### PC
```cmd
CertUtil -hashfile sdfsdk-XX.X.X.tar.gz SHA256
```