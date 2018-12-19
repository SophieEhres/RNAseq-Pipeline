#!/bin/bash

### USAGE ###
# bash RNAseq_Pipeline.sh [file_with_list_of_bam_or_fastq] [SINGLE or PAIRED] [file_with_adapters] [work_directory]

#Arguments
FILES=$1
END=$2
ADAPTERS=$3
DIRECTORY=$4
GENOME=$5

#create readset and design files
bash make_readset_design.sh $FILES $END $ADAPTERS $DIRECTORY

#create run_steps files
bash RNAseq_preparation.sh $DIRECTORY $GENOME
