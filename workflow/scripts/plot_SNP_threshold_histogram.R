#!/usr/bin/env Rscript
library(ggplot2)
library(ggthemes)
library(patchwork)

args = commandArgs(trailingOnly=TRUE)

snp_comparisons <- read.delim(args[1])
plot_50_SNPs <- args[2]
plot_500_SNPs <- args[3]
plot_all_SNPs <- args[4]

##### Plot with correction for alignment length

### Plot 0-50 SNPs/Mbp
corrected_50 <- ggplot(snp_comparisons, aes(x = SNPs_corrected, fill = comparison)) +
	geom_histogram(bins = 50) +
	scale_x_continuous(limits = c(0,50), name = "SNPs per 1,000,000 bp") +
	labs(title = "Corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

### Plot 0-500 SNPs/Mbp
corrected_500 <- ggplot(snp_comparisons, aes(x = SNPs_corrected, fill = comparison)) +
	geom_histogram(bins = 100) +
	scale_x_continuous(limits = c(0,500), name = "SNPs per 1,000,000 bp") +
	labs(title = "Corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

### Plot all SNPs/Mbp
corrected_all <- ggplot(snp_comparisons, aes(x = SNPs_corrected, fill = comparison)) +
	geom_histogram(bins = 100) +
	scale_x_continuous(name = "SNPs per 1,000,000 bp") +
	labs(title = "Corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

##### Plot without correcting for alignment length

### Plot 0-50 SNPs
notcorrected_50 <- ggplot(snp_comparisons, aes(x = SNPs_not_corrected, fill = comparison)) +
	geom_histogram(bins = 50) +
	scale_x_continuous(limits = c(0,50), name = "SNPs") +
	labs(title = "Not corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

### Plot 0-500 SNPs
notcorrected_500 <- ggplot(snp_comparisons, aes(x = SNPs_not_corrected, fill = comparison)) +
	geom_histogram(bins = 100) +
	scale_x_continuous(limits = c(0,500), name = "SNPs") +
	labs(title = "Not corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

### Plot all SNPs
notcorrected_all <- ggplot(snp_comparisons, aes(x = SNPs_not_corrected, fill = comparison)) +
	geom_histogram(bins = 100) +
	scale_x_continuous(name = "SNPs") +
	labs(title = "Not corrected for alignment length", fill = "Comparison") +
	scale_fill_discrete(labels = c("Different carrier", "Same carrier, different timepoint", "Same carrier, same timepoint")) +
	theme_clean() +
	theme(axis.text = element_text(size = 12), axis.title = element_text(size = 12))

# Write to pdfs using patchwork
pdf(file = plot_50_SNPs, height = 10, width = 10)
corrected_50 / notcorrected_50
dev.off()

pdf(file = plot_500_SNPs, height = 10, width = 10)
corrected_500 / notcorrected_500
dev.off()

pdf(file = plot_all_SNPs, height = 10, width = 20)
corrected_all / notcorrected_all
dev.off()



