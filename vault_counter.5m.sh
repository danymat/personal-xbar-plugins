#!/bin/bash

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Obsidian Counter</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Mathiot</xbar.author>
#  <xbar.author.github>danymat</xbar.author.github>
#  <xbar.desc>Display the number of notes in the specified location</xbar.desc>
#  <xbar.image>https://raw.githubusercontent.com/danymat/personal-xbar-plugins/main/images/obsidian_2021_03_30.png</xbar.image>
#  <xbar.var>string(vault="/Users/danielmathiot/vault"): The location of your current vault.</xbar.var>
#  <xbar.dependencies></xbar.dependencies>
#  <xbar.abouturl></xbar.abouturl>

number_notes=$(ls -p "$vault" | grep -v / | wc -l)
vault_name_uri=$(echo $vault |  sed -e 's:.*/::' -e 's/ /%20/g')
files_todos=$(grep -R --exclude-dir=.obsidian TODO "$vault" | cut -d ':' -f 1 | uniq | sed -e 's/.*\///g' -e "s|^|$vault/|g")

echo $number_notes Notes
echo "---"
echo "Vault folder: $vault"
echo "---"
echo "TODOS"
while IFS= read -r file
do
    file_name=$(echo "$file" | sed 's|.*/||')
    #file_name_uri=$(echo "$file" | sed -e 's:.*/::' -e 's/ /%20/g' -e "s/'/%39/g")
    echo "$file_name" # | href=obsidian://open?vault=$vault_name_uri&file=$file_name_uri"
    todos=$(grep 'TODO' "$file" | sed -e 's/^[^%]*%*TODO: /--/g' -e 's/%%//g') # keep only what inside %%TODO: %%)
    echo "$todos"
done <<< "$files_todos"
echo "---"
# while read -r file ; do
#     echo "salut$file"
#     # todos=$(grep 'TODO' "$file" | sed -e 's/^[^%]*%*TODO: /--/g' -e 's/%%//g') # keep only what inside %%TODO: %%)
#     # echo "$todos"
# done < "$files_todos"

echo "Open Obsidian vault | href=obsidian://open?vault=$vault_name_uri"
