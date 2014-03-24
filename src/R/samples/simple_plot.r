#!/usr/bin/env Rscript
png(file="/mnt/s3-rwizflowy/prod/test/plot1.png")
plot(1:sample(1:100,1))
dev.off()

png(file="/mnt/s3-rwizflowy/prod/test/plot2.png")
plot(1:sample(1:100,1))
dev.off()