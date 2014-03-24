#!/usr/bin/env Rscript

#config
require(yaml)
args <- commandArgs(trailingOnly = TRUE)
config_file_path <- args[1]
output_dir <- args[2]
sprintf("Running Slidify Test with config: %s, output to %s", config_file_path, output_dir)

# slidify stuff
require(slidify)
slidify("index.Rmd")


# publish results to output dir
publish(dirname=output_dir,host="folder")