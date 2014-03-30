#!/usr/bin/env Rscript

###############################
## define team name          ##
team_name <- "betternauts"   ##
###############################


# require necessary packages
require(yaml)
require(RMySQL)
require(ggplot2)

# define the yml (properties) file, read it in as a list
config_file_path <- "~/rwiz.yml"
print(paste("Using config yml: ", config_file_path))
config <- yaml.load_file(config_file_path)


# define the output parent directory
output_parent_dir <- config$rwizflowy.folders$outputdirectory
# build team path directory name
team_path <- paste0(output_parent_dir,team_name)
# create a team directory in symlink to s3 bucket (just a warning if it already exists)
system(sprintf("mkdir %s",team_path))
# set this new directory as your working directory so all of your outputs will write to it
setwd(team_path)
# define the yml (properties) file, read it in as a list
config_file_path <- "~/rwiz.yml"
print(paste("Using config yml: ", config_file_path))
config <- yaml.load_file(config_file_path)

# set up db con function
dbCon <- function(dbname, user, password, host="localhost", port=3306){
  dbcon <- dbConnect("MySQL", dbname=dbname, user=user,
                     password=password, host=host, port=port)
  dbcon
}

# define connection using the yml properties
con <- dbCon(config$rwizflowy.db.rwizflowys$name,
             config$rwizflowy.db.rwizflowy$username,
             config$rwizflowy.db.rwizflowy$password,
             config$rwizflowy.db.rwizflowy$host,
             config$rwizflowy.db.rwizflowy$port)

# construct query
user_info_query <- "SELECT * from rwizflowy.user_info;"

# run the query
user_info <- dbGetQuery(con, user_info_query)

# tell R which columns are dates (they come in as characters by default)
# [as.POSIXlt() is R's way of saying as.Datetime]
user_info$user_signup_started_date <- as.POSIXlt(user_info$user_signup_started_date)
user_info$user_signup_completed_date <- as.POSIXlt(user_info$user_signup_completed_date)
user_info$user_initial_deposit_date <- as.POSIXlt(user_info$user_initial_deposit_date)

# signups by month histogram (using ggpot2)
bin <- 30 # used for aggregating the data and aligning the labels
# initialize the png controller
png(filename="signups_histogram.png", width=1440, height=950)
# run the plot.  since it is not being passed to an object, it just prints to the png
ggplot(user_info, aes(as.Date(user_signup_started_date), ..count..)) + geom_histogram(binwidth = bin, colour="white")
# turn off the plotting function
dev.off()