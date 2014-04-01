#!/usr/bin/env Rscript

###############################
## define team name          ##
team_name <- "zomg-zombies"   ##
###############################

# import packages or install them if they don't exist [helper written by @Shane from stackoverflow]
list.of.packages <- c("yaml", "ggplot2", "RMySQL")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='http://cran.us.r-project.org')

require(yaml)
require(ggplot2)
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
con <- dbCon(config$rwizflowy.db.rwizflowys$name,
             config$rwizflowy.db.rwizflowy$username,
             config$rwizflowy.db.rwizflowy$password,
             config$rwizflowy.db.rwizflowy$host,
             config$rwizflowy.db.rwizflowy$port)

# construct query
user_info_query <- "SELECT * from rwizflowy.user_info;"

# run the query
user_info <- dbGetQuery(con, user_info_query)

# signups by month histogram (using ggpot2)
bin <- 30 # used for aggregating the data and aligning the labels
# initialize the png controller
png(filename="newthing.png", width=1440, height=950)
# run the plot.  since it is not being passed to an object, it just prints to the png

plot <- ggplot(user_info, aes(x=user_age,y=user_current_balance, color=user_reported_employment_status)) + geom_point() + facet_grid(.~user_reported_employment_status)
plot

# turn off the plotting function
dev.off()
