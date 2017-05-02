@ECHO off
mvn -f c:\sdf\cli\pom.xml exec:java -Dexec.args="%*"