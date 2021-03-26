#!/bin/bash

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Vault counter</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Mathiot</xbar.author>
#  <xbar.author.github>danymat</xbar.author.github>
#  <xbar.desc>Display the number of notes in the specified location</xbar.desc>
#  <xbar.image>http://www.hosted-somewhere/pluginimage</xbar.image>
#  <xbar.dependencies></xbar.dependencies>
#  <xbar.abouturl></xbar.abouturl>
vault="$HOME/Documents/00 Meta/00.01 NewBrain"


number_notes=$(ls -p "$vault" | grep -v / | wc -l)
echo $number_notes Notes
echo "---"
echo "Vault folder: $vault"
