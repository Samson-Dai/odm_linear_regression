#!/bin/bash
#SBATCH -p RM-shared
#SBATCH -t 00:10:00
#SBATCH --ntasks-per-node=2

export NXF_OPTS="-Xms500M -Xmx2G" # limit NF to 2 GB of memory

# sets up the offsite directory structure
source ~/.research_config

#odm_fp=$LOCAL_LINEAR_REG_DATA_DIR"gasp_scale_gene_expressions.odm"
#meta_fp=$LOCAL_LINEAR_REG_DATA_DIR"gasp_scale_gene_metadata.rds"

#hard code for ondiscdata 
odm_fp="/jet/home/sdai/R/x86_64-redhat-linux-gnu-library/4.0/ondiscdata/extdata/odm/gene/matrix.odm"
meta_fp="/jet/home/sdai/R/x86_64-redhat-linux-gnu-library/4.0/ondiscdata/extdata/odm/gene/metadata.rds"
k=10
x=1
y=2
result_dir=$LOCAL_LINEAR_REG_DATA_DIR"results"
work_dir=$LOCAL_LINEAR_REG_DATA_DIR"work"
#######################
# Run Nextflow pipeline
#######################
rm -f trace.txt

# nextflow run $glmeiv_nf_pipeline \
nextflow run https://github.com/Samson-Dai/odm_linear_regression -r main \
--odm_fp $odm_fp \
--meta_fp $meta_fp \
--x $x \
--y $y \
--k $k \
--result_dir $result_dir \
-with-trace -w $work_dir