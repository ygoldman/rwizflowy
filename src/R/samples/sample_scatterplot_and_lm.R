#!/usr/bin/env Rscript

###############################
## define team name          ##
team_name <- "zomg-zombies"   ##
###############################

# import packages or install them if they don't exist [helper written by @Shane from stackoverflow]
list.of.packages <- c("yaml", "RMySQL")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='http://cran.us.r-project.org')

require(yaml)
require(RMySQL)

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
con <- dbCon(config$rwizflowy.db.rwizflowy$name,
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

# scatter plot, age vs current balance
png(filename="scatterplot_with_lm_example.png", width=1440, height=950)

plot(user_info$user_age, log10(user_info$user_current_balance), main="Scatterplot Example",
     xlab="User Age ", ylab="Log10 of Current Balance (# is tens place)", pch=20)

# add a simple linear regression on top.  Note: this is a terrible example to throw an lm on top... but whatevs.
reg1 <- lm(log10(user_info$user_current_balance)~user_info$user_age)
# plot the regression on top of the chart
abline(reg1, col="red")
dev.off()
