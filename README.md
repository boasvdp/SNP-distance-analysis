# SNP calling pipeline

## Contents

- [Intro](#intro)
- [Dependencies](#dependencies)
- [How to use](#howtouse)
 - [User-supplied input](#user-suppliedinput)
 - [Running](#running)
- [Output](#output)
- [Citation](#citation)

## Intro

This pipeline was designed to assess carriage in studies where bacteria were sampled at two different timepoints and were whole-genome sequenced using Illumina technology. The pipeline was originally designed to work with *Escherichia coli* data, but should work with other bacteria as well. Ideally, multiple isolates should be sampled from the same carrier at both timepoint.

The pipeline identifies SNP differences between all strains in the dataset, and plots SNP distances between strains in groups:

1. **Same carrier, same timepoint**: here we would expect some strain comparisons to show low SNP distances.
2. **Same carrier, different timepoint**: these comparisons might show persistence of the same strain between the included timepoints.
3. **Different carriers**: here we would expect to see no low SNP distances between strains. Low SNP distances in this group might indicate there is a strain in the collection which has spread through clonal expansion. Persistence is typically difficult to determine for these strains, and it might be wise to exclude these from the dataset.

## Dependencies

There are three dependencies for this pipeline:

- Python3 with the pandas lib
- Snakemake (originally tested on v5.7.1)
- Conda

## How to use this pipeline

Raw data should of course be provided by the user, as well as some standard settings.

### User-supplied input

Input and configuration is needed from the user:

- Raw Illumina sequencing data in the `input/raw_illumina` folder.
- A reference genome to which the sequencing data will be mapped. An example *E. coli* genome in Genbank format is supplied (`input/references/ATCC25922.gbk`). A nice tool to select an optimal reference genome is [referenceseeker](https://github.com/oschwengers/referenceseeker).
- Metadata in the `config/metadata.tsv` file. Also here, an example is supplied. The file should contain three columns: carrier, strain and timepoint. These data will be used to plot SNP distances in the three groups explained in the [Intro](#intro).
- The `config.yaml` file should be edited. The path to the metadata file and extensions of the Illumina sequencing data (default: `_R?.fastq.gz`) have to be modified here. Also, settings for some analyses can be modified using this file. Important entries also include the thresholds for assigning a SNP distance as 'very likely clonal', 'likely clonal' or 'not clonal'. 

### Running

Once all data has been loaded and configuration is complete, the pipeline can be started.

To check whether data has been provided correctly, you can run:

```
snakemake -np
```

This command will perform a dry run of the pipeline, and print the commands that will be executed in the pipeline. If this executes without issues, the pipeline can be started:

```
snakemake --use-conda -j [THREADS]
```

Where [THREADS] indicates how many threads should be used in the pipeline.

If you want to re-run a specific rule of the pipeline (e.g. change the SNP treshold of the `print_carriers` rule and redo the analysis), use:

```
snakemake --use-conda -j [THREADS] -R print_carriers
``` 

## Output

Several outputs will be created in the `output` folder. The most important output is:

- `multiqc_out`: this folder contains an aggregated MultiQC report of fastp output. This report summarises relevant quality checks of raw sequencing reads before and after trimming and filtering by fastp
- `snp_comparison/snp_comparisons.tsv`: all SNP data summarised. Contains SNP distances between strains, with corresponding metadata on carriers and timepoint. 
- `snp_comparison/carrier_persistence_types.tsv`: provides strain comparisons with lowest SNP distance, per carrier. Additionally, assigns a persistence type based on SNP thresholds defined in `config.yaml`.
- `snp_comparison_histograms_*_SNPs.pdf`: provide SNP distances between all strains, grouped into three categories (same carrier & same timepoint, same carrier & different timepoint, different carrier). Top panel shows the SNP distances corrected for alignment length, bottom panel shows the uncorrected SNP distances. One plot shows 0-50 SNPs, another shows 0-500 SNPs and the final one shows all SNPs. The better the separation between the "same carrier" groups and the "different carrier" group, the better the method.
- `snp_comparison_thresholds_lineplot.pdf`: shows a lineplot where every point is a SNP threshold, which range from 0 to 20 (can be modified in `config.yaml`. One the x-axis, the amount of strain:strain comparisons below the SNP threshold between strains from different carriers are plotted (this should be as low as possible). On the y-axis, the amount of strain:strain comparisons below the SNP threshold between strains from the same carriers are plotted (this should be as high as possible). SNP thresholds in the `config.yaml` can be modified based on this estimation of the ideal SNP threshold. This SNP threshold would be the point that is closest to the top-left corner of the plot.

## Citation

Will follow soon (hopefully).
