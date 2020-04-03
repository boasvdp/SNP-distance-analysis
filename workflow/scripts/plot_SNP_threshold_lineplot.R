#!/usr/bin/env Rscript 
library(reshape2)
library(ggplot2)

# Parse command line arguments
args = commandArgs(trailingOnly=TRUE)

path_to_input = args[1]
path_to_output = args[2]

# Read data
df <- read.delim(path_to_input)

# Cast data using reshape2 lib
df_casted <- dcast(df, formula = SNP_threshold + Method ~ Comparison)

# Axis titles
name_x <- "Number of isolate pairs from different carriers assigned as 'clonal'"
name_y <- "Number of isolate pairs from the same carrier and timepoint assigned as 'clonal'"

# Plot data
plot <- ggplot(df_casted, aes(x = different_carrier, y = same_carrier_same_timepoint, group = Method, color = Method, label = SNP_threshold)) +
	geom_line() +
	geom_point() +
	geom_text(hjust=0, vjust=0, color = "black") +
	scale_y_continuous(name = name_y) +
	scale_x_continuous(name = name_x, limits = c(0,100)) +
	scale_colour_discrete(name = "Method", labels = c("Core genome, no gaps", "Pairwise comparison, corrected for alignment length", "Pairwise comparison, uncorrected"))

# Write to pdf
pdf(file = path_to_output, height = 6, width = 11)
plot
dev.off()