@ECHO off
SET SDFSDK_PATH=c:\sdf\sdk\

IF NOT EXIST %SDFSDK_PATH%\ GOTO WRONGPATH
IF NOT EXIST %SDFSDK_PATH%\pom.xml GOTO FILEMISSING
IF NOT EXIST %SDFSDK_PATH%\com.netsuite.ide.core_*.jar GOTO FILEMISSING
IF NOT EXIST %SDFSDK_PATH%\axis.jar GOTO EXTRACTJAR
IF NOT EXIST %SDFSDK_PATH%\NetSuiteWebService.jar GOTO EXTRACTJAR

:MAIN
mvn -f %SDFSDK_PATH%\pom.xml exec:java -Dexec.args="%*"
GOTO END

:EXTRACTJAR
CLS
ECHO.
ECHO ERROR: Could not find axis.jar or NetSuiteWebService.jar.
ECHO.
ECHO axis.jar or NetSuiteWebService.jar must be extracted from the 
ECHO com.netsuite.ide.eclipse.ws JAR file and placed in the
ECHO %SDFSDK_PATH% folder.
ECHO.
ECHO Oracle recommends using an unzip utility to extract the contents of the
ECHO com.netsuite.ide.eclipse.ws JAR file into the %SDFSDK_PATH% folder.
ECHO.
ECHO For more information about SDF SDK installation, see:
ECHO https://system.netsuite.com/app/help/helpcenter.nl?fid=section_1489072409.html
GOTO END

:FILEMISSING
CLS
ECHO.
ECHO ERROR: A file was missing from %SDFSDK_PATH%.
ECHO.
ECHO The following files are required to run SDF CLI:
ECHO     - axis.jar 
ECHO     - com.netsuite.ide.core_^<NetSuite-version^>.jar
ECHO     - NetSuiteWebService.jar 
ECHO     - pom.xml
ECHO.
ECHO Check your SDF SDK installation path, and make sure that you
ECHO downloaded or extracted the files listed above.
ECHO.
ECHO For more information about SDF SDK installation, see:
ECHO https://system.netsuite.com/app/help/helpcenter.nl?fid=section_1489072409.html
GOTO END

:WRONGPATH
CLS
ECHO.
ECHO ERROR: SDF SDK was not found in %SDFSDK_PATH%.
ECHO.
ECHO Edit this batch file and set the SDFSDK_PATH environment variable to
ECHO the correct path of your SDF SDK installation.
ECHO.
ECHO For more information about SDF SDK installation, see:
ECHO https://system.netsuite.com/app/help/helpcenter.nl?fid=section_1489072409.html
GOTO END

:END
