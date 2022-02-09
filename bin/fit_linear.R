#!/usr/bin/env Rscript

library(ondisc)
############################
# 1. Load command-line args
############################
args <- commandArgs(trailingOnly = TRUE)
n_args <- length(args)
odm_fp <- args[1L]
meta_fp <- args[2L]
x <- as.integer(args[3L])
y <- as.integer(args[4L])
k <- as.integer(args[5L])
i <- as.integer(args[6L])

#########################
# 2. Load odm and columns
#########################
odm_mtx <- ondisc::read_odm(odm_fp, meta_fp)
x_col <- as.matrix(odm_mtx[[,x]])
y_col <- as.matrix(odm_mtx[[,y]])

################################################################
# 3. Subset the data frame, fit linear model and save the result
################################################################
#assume the first col is x, the second col is y
n <- nrow(odm_mtx)
chunk <- as.integer(n/k)
start <-  (i-1) * chunk + 1
end <- min(i*chunk, n)

sub_x <- x_col[start:end]
sub_y <- y_col[start:end]

linear_model <- lm(sub_y ~ sub_x)
output_coef <- coef(linear_model)
saveRDS(output_coef, "raw_result.rds")

