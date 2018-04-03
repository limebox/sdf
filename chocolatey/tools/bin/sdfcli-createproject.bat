@ECHO off
:PROJECTMENU
CLS
ECHO This script creates a new SuiteCloud project in the current folder.
ECHO Make sure that you have read/write access to the current folder.
ECHO.
ECHO DISCLAIMER: The contents of the SDF CLI supplemental packages are
ECHO provided as-is to help you install SDF CLI and set up your SuiteCloud
ECHO projects.  The packages are only updated when a new version of SDF
ECHO CLI is released.  The files are not officially supported NetSuite
ECHO products.  
ECHO.
ECHO Select Project Type
ECHO ======================
ECHO 1. Account customization project
ECHO 2. SuiteApp project
ECHO.
SET /P ProjectType=Type 1 or 2 then press ENTER: 
IF %ProjectType%==1 GOTO ACP
IF %ProjectType%==2 GOTO SUITEAPP
ECHO Invalid entry.
GOTO PROJECTMENU
:ACP
SET /P ProjectName=Enter a project name: 
GOTO CREATEPROJECT

:SUITEAPP
SET /P PublisherID=Enter your publisher ID: 
SET /P ProjectID=Enter your project ID: 
SET /P ProjectName=Enter your project name: 
SET /P ProjectVersion=Enter your project version: 
GOTO CREATEPROJECT

:CREATEPROJECT
IF %ProjectType%==1 MKDIR %ProjectName%
IF %ProjectType%==1 CD %ProjectName%
IF %ProjectType%==2 MKDIR %PublisherID%.%ProjectID%
IF %ProjectType%==2 CD %PublisherID%.%ProjectID%
MKDIR Objects
MKDIR FileCabinet
IF %ProjectType%==1 MKDIR AccountConfiguration
IF %ProjectType%==1 MKDIR FileCabinet\SuiteScripts
IF %ProjectType%==1 MKDIR FileCabinet\SuiteScripts\.attributes
IF %ProjectType%==2 MKDIR FileCabinet\SuiteApps
IF %ProjectType%==2 MKDIR FileCabinet\SuiteApps\%PublisherID%.%ProjectID%
IF %ProjectType%==2 MKDIR FileCabinet\SuiteApps\%PublisherID%.%ProjectID%\.attributes
@ECHO account= > .sdf
@ECHO email= >> .sdf
@ECHO role=3 >> .sdf
@ECHO url= >> .sdf
@ECHO ^<deploy^> > deploy.xml
IF %ProjectType%==1 @ECHO     ^<configuration^> >> deploy.xml
IF %ProjectType%==1 @ECHO         ^<path^>~/AccountConfiguration/*^</path^> >> deploy.xml
IF %ProjectType%==1 @ECHO     ^</configuration^> >> deploy.xml
@ECHO     ^<files^> >> deploy.xml
IF %ProjectType%==1 @ECHO         ^<path^>~/FileCabinet/SuiteScripts/*^</path^> >> deploy.xml
IF %ProjectType%==2 @ECHO         ^<path^>~/FileCabinet/SuiteApps/%PublisherID%.%ProjectID%/*^</path^> >> deploy.xml
@ECHO     ^</files^> >> deploy.xml
@ECHO     ^<objects^> >> deploy.xml
@ECHO         ^<path^>~/Objects/*^</path^> >> deploy.xml
@ECHO     ^</objects^> >> deploy.xml
@ECHO ^</deploy^> >> deploy.xml
IF %ProjectType%==1 @ECHO ^<manifest projecttype="ACCOUNTCUSTOMIZATION"^> > manifest.xml
IF %ProjectType%==2 @ECHO ^<manifest projecttype="SUITEAPP"^> >> manifest.xml
IF %ProjectType%==2 @ECHO     ^<publisherid^>%PublisherID%^</publisherid^> >> manifest.xml
IF %ProjectType%==2 @ECHO     ^<projectid^>%ProjectID%^</projectid^> >> manifest.xml
@ECHO     ^<projectname^>%ProjectName%^</projectname^> >> manifest.xml
IF %ProjectType%==2 @ECHO     ^<projectversion^>%ProjectVersion%^</projectversion^> >> manifest.xml
@ECHO     ^<frameworkversion^>1.0^</frameworkversion^> >> manifest.xml
@ECHO     ^<dependencies^> >> manifest.xml
@ECHO         ^<features^> >> manifest.xml
@ECHO             ^<feature required="true"^>CUSTOMRECORDS^</feature^> >> manifest.xml
@ECHO             ^<feature required="true"^>SERVERSIDESCRIPTING^</feature^> >> manifest.xml
@ECHO             ^<feature required="false"^>CREATESUITEBUNDLES^</feature^> >> manifest.xml
@ECHO         ^</features^> >> manifest.xml
@ECHO     ^</dependencies^> >> manifest.xml
@ECHO ^</manifest^> >> manifest.xml
ECHO.
ECHO End of script.
ECHO Edit the .sdf file in the new project folder to complete the process.
ECHO In the .sdf file, specify your account ID, login, and account URL.