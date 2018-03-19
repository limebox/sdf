@ECHO off
mvn -f "[APP_PATH]\pom.xml" exec:java -Dexec.args="%*"