#!/usr/bin/env python3

import sys
import pandas as pd

T1 = float(sys.argv[1])
T2 = float(sys.argv[2])
path_snp_comparisons = str(sys.argv[3])

snp_comparisons = pd.read_csv(path_snp_comparisons, sep = '\t')

snp_comparisons = snp_comparisons.query('comparison == "same_carrier_different_timepoint"')

print("Carrier", "Strain_1", "Strain_2", "SNPs_corrected", "Type", sep = '\t')

for carrier in list(snp_comparisons.carrier1.drop_duplicates()):
	df = snp_comparisons.query('carrier1 == @carrier')
	strain1 = df[df.SNPs_corrected == df.SNPs_corrected.min()].values[0,0]
	strain2 = df[df.SNPs_corrected == df.SNPs_corrected.min()].values[0,1]
	min_SNPs = df[df.SNPs_corrected == df.SNPs_corrected.min()].values[0,10]
	if min_SNPs < T1:
		type = "Very_likely_clonal"
	elif min_SNPs >= T1 and min_SNPs < T2:
		type = "Likely_clonal"
	else:
		type = "Not_clonal"
	print(carrier, strain1, strain2, "%.3f" % min_SNPs, type, sep = '\t')
