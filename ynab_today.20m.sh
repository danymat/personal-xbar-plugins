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

YNAB_TOKEN="d5c8fcb306495ba3757ddd4903653698f426ad56aed05a6a6fa0fad7e61400d4"
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
echo "---"
uri_get_months="https://api.youneedabudget.com/v1/budgets/$budget_id/months"
months=$(eval $execute_command $uri_get_months)
spend_this_month=$(echo $months | jq '.data.months[] | select (.month == "2021-03-01") | .activity/1000')
echo This month: $spend_this_month €