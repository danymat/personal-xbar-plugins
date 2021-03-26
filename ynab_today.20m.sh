#!/bin/bash
# -*- coding: utf-8 -*-

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Ynab sum</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Mathiot</xbar.author>
#  <xbar.author.github>danymat</xbar.author.github>
#  <xbar.desc>Display the amount earned today</xbar.desc>
#  <xbar.image></xbar.image>
#  <xbar.dependencies>jq, curl</xbar.dependencies>
#  <xbar.var>string(YNAB_TOKEN=""): API key to get access to remote data.</xbar.var>
#  <xbar.abouturl></xbar.abouturl>

export PATH='/usr/local/bin:/usr/bin:/bin:$PATH'

YNAB_TOKEN="token"
BUDGET_NUMBER="1"
today=$(date "+%Y-%m-%d")

#######
uri_get_budgets="https://api.youneedabudget.com/v1/budgets"
execute_command="curl -H 'accept: application/json' \
    --compressed -H 'Authorization: Bearer $YNAB_TOKEN' \
    -X GET"
budget_id=$(eval $execute_command $uri_get_budgets | jq '.data.budgets['$BUDGET_NUMBER-1'].id')
uri_get_transactions="https://api.youneedabudget.com/v1/budgets/$budget_id/transactions?since_date=$today"

transactions=$(eval $execute_command $uri_get_transactions)

# echo salut
echo $transactions | jq '.data.transactions[] | select(.date == "'$today'") | {amount}' | jq '.amount' | awk '{sum+=$0} END{print sum/1000, "€"}'

