#!/usr/bin/env python3

import pandas as pd
import sys

path_tbl = str(sys.argv[1])

tbl = pd.read_csv(path_tbl, sep = '\t')

print("Method", "SNP_threshold", "Comparison", "Number_isolate_pairs", sep = '\t')

for snp_threshold in range(1,21):
	for comparison in [ 'different_carrier', 'same_carrier_same_timepoint' ]:
		isolate_pairs = tbl.query('comparison == @comparison & SNPs_corrected < @snp_threshold').shape[0]
		print("Pairwise_corrected", snp_threshold, comparison, isolate_pairs, sep = '\t')

for snp_threshold in range(1,21):
	for comparison in [ 'different_carrier', 'same_carrier_same_timepoint' ]:
		isolate_pairs = tbl.query('comparison == @comparison & SNPs_not_corrected < @snp_threshold').shape[0]
		print("Pairwise_not_corrected", snp_threshold, comparison, isolate_pairs, sep = '\t')

for snp_threshold in range(1,21):
	for comparison in [ 'different_carrier', 'same_carrier_same_timepoint' ]:
		isolate_pairs = tbl.query('comparison == @comparison & SNPs_no_gaps < @snp_threshold').shape[0]
		print("Core_genome_nogaps", snp_threshold, comparison, isolate_pairs, sep = '\t')
