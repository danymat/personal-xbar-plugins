#!/bin/bash

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Personal Configs</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Mathiot</xbar.author>
#  <xbar.author.github>danymat</xbar.author.github>
#  <xbar.desc>Display the personal user configs such as hyper keys in skhd</xbar.desc>
#  <xbar.image>http://www.hosted-somewhere/pluginimage</xbar.image>
#  <xbar.dependencies></xbar.dependencies>
#  <xbar.abouturl></xbar.abouturl>

## README

### SKHD
# In order for the hyper key to be recognized, you need to have in your skhd file:
# example: # HYPER A: Do some stuff
#          hyper - a : yabai -m ...


## CONFIG OPTIONS
SKHD_LOCATION="$HOME/.config/skhd/"
ICON_NAVBAR="⛏"
ICON_COMMANDS="🛠"

##
echo $ICON_NAVBAR
echo "---"
echo "skhd"
echo "-- Open skhd folder| shell=open | param1=$SKHD_LOCATION"
cat $SKHD_LOCATION/skhdrc | grep "# HYPER\b" | sed -e 's/# HYPER/--'$ICON_COMMANDS'/g'| xargs -L1 echo
