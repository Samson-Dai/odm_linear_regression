library(ondisc)

odm <- ondisc::create_ondisc_matrix_from_R_matrix("/Users/Administrator/research_offsite/linear_reg/example_data.rds")

error <- rnorm(100, 0, 16)

y <- 5*x + error

output <- data.frame(x,y)

saveRDS(output, file = "example_data.rds")
