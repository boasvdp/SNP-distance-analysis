configfile: "config/config.yaml"

import pandas as pd

# Parse strains from metadata table
path_to_metadata = config["general"]["metadata"]
df = pd.read_csv(path_to_metadata, sep = '\t')
STRAINS = tuple(df.strain)

# Get extensions of forward and reverse reads
fw_ext = config["general"]["forward_extension"]
rv_ext = config["general"]["reverse_extension"]

rule all:
	input:
		"output/multiqc_out/multiqc_fastp.html",
		"output/snp_comparison/carrier_persistence_types.tsv"

### Modules

include: "workflow/rules/fastp.snake"
include: "workflow/rules/multiqc.snake"
include: "workflow/rules/snippy.snake"
include: "workflow/rules/snippycore.snake"
include: "workflow/rules/iqtree.snake"
include: "workflow/rules/clonalframeml.snake"
include: "workflow/rules/maskrc.snake"
include: "workflow/rules/snp_dists.snake"
include: "workflow/rules/alnlengths.snake"
include: "workflow/rules/snp_comparisons.snake"
include: "workflow/rules/plot_snp_comparisons.snake"
include: "workflow/rules/print_carriers.snake"
