#!/bin/bash
# Daily run script
R_SCRIPT_HOME=/opt/rwizflowy/prod/src/R
PROPERTIES_PATH=/opt/rwizflowy/prod.yml

# Add you scripts below.
# sample daily script 
$R_SCRIPT_HOME/test/early_balance_growth.R $PROPERTIES_PATH

# withdrawals by user base and cashflow (by date)
$R_SCRIPT_HOME/test/withdrawal_rates_by_date.R $PROPERTIES_PATH