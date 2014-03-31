#!/bin/bash
# Minute run script
R_SCRIPT_HOME=/opt/rwizflowy/prod/src/R

# Add your scripts below - these will run once a minute
$R_SCRIPT_HOME/samples/sample_choropleth_map.R
$R_SCRIPT_HOME/samples/sample_histogram.R
$R_SCRIPT_HOME/samples/sample_scatterplot_and_lm.R
