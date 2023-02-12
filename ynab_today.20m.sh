#!/bin/bash
# -*- coding: utf-8 -*-

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Today's YNAB</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Mathiot</xbar.author>
#  <xbar.author.github>danymat</xbar.author.github>
#  <xbar.desc>Display the amount earned today</xbar.desc>
#  <xbar.image>https://raw.githubusercontent.com/danymat/personal-xbar-plugins/main/images/ynab_2021_03_30.png</xbar.image>
#  <xbar.dependencies>jq, curl</xbar.dependencies>
#  <xbar.var>string(YNAB_TOKEN=""): API key to get access to remote data.</xbar.var>
#  <xbar.var>string(BUDGET_NUMBER="1"): The budget number for your YNAB account.</xbar.var>
#  <xbar.var>string(JQ_PATH="/opt/homebrew/bin/jq"): The budget number for your YNAB account.</xbar.var>
#  <xbar.abouturl></xbar.abouturl>

ICON_MONEY_FLIES="💸"
ICON_AGE_OF_MONEY="🍃"
ICON_TODAY="💰"
ICON_YNAB="Ynab"
jq=$JQ_PATH
#####

today=$(date "+%Y-%m-%d")
this_month=$(date "+%Y-%m-01")

#######
uri_get_budgets="https://api.youneedabudget.com/v1/budgets"
execute_command="curl -s -H 'accept: application/json' \
    --compressed -H 'Authorization: Bearer $YNAB_TOKEN' \
    -X GET"
budgets=$(eval $execute_command $uri_get_budgets)
budget_id=$(echo $budgets | $jq -r '.data.budgets['$BUDGET_NUMBER-1'].id')
uri_get_transactions="https://api.youneedabudget.com/v1/budgets/$budget_id/transactions?since_date=$today"

transactions=$(eval $execute_command $uri_get_transactions)

ynab_today=$(echo $transactions | $jq -r '.data.transactions[] | select(.date == "'$today'") | {amount}' | $jq -r '.amount' | awk '{sum+=$0} END{print sum/1000, "€"}')
uri_get_months="https://api.youneedabudget.com/v1/budgets/$budget_id/months"
months=$(eval $execute_command $uri_get_months)
json_this_month=$(echo $months | $jq -r '.data.months[] | select (.month == "'$this_month'")')
spend_this_month=$(echo $json_this_month | $jq -r '.activity/1000' )
age_of_money=$(echo $json_this_month | $jq -r '.age_of_money' )

echo "$ICON_YNAB"
echo "---"

echo "$ICON_TODAY Today: $ynab_today"
echo $ICON_MONEY_FLIES This month: $spend_this_month €
echo $ICON_AGE_OF_MONEY Age of money: $age_of_money days
