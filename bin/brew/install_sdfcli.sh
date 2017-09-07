#!/bin/sh
echo "Installing SDFCLI"
mkdir /usr/local/lib/sdfcli
cp /usr/local/Cellar/sdfcli/17.2.0/com.netsuite.ide.core_2017.2.0.jar /usr/local/lib/sdfcli
cp /usr/local/Cellar/sdfcli/17.2.0/pom.xml /usr/local/lib/sdfcli
cp /usr/local/Cellar/sdfcli/17.2.0/sdfcli /usr/local/bin/sdfcli
cp /usr/local/Cellar/sdfcli/17.2.0/sdfcli-createproject /usr/local/bin/sdfcli-createproject