#!/usr/bin/env Rscript

#config
require(yaml)
args <- commandArgs(trailingOnly = TRUE)
config_file_path <- args[1]
output_dir <- args[2]
sprintf("Running Knitr Test with config: %s, output to %s", config_file_path, output_dir)

# slidify stuff
require(knitr)
require(markdown)
knit("index.Rmd", encoding='UTF-8')
markdownToHTML("index.md", "index.html")

# publish results to output dir
source("publish.R")
publish_folder(dirname=output_dir,html_only=TRUE)