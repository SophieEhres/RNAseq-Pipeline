#!/bin/bash

#LAUNCH
GENPIPE=$MUGQIC_INSTALL_HOME/software/genpipes/genpipes-3.1.0/
VERSION=$(cat $GENPIPE/VERSION)
echo "Launching genpipes version $VERSION"

#SETTING BASE DIRECTORY
dir0=$1
cd $dir0

#ANALYSIS VARIABLES
typepipe="rnaseq"
genome=$(ls $MUGQIC_INSTALL_HOME/genomes/species | grep -e $2)
versionpython="2.7.14" #"2.7.13" ---> Verify the version available in the cluster
#
mysteps="1-15"
analysistype="analysis" #analysis or report
myoutputdir="${dir0}/RNAseq_Pipeline_output"
myreadset="${dir0}/readset.txt"
#
#
dirpipe=$MUGQIC_INSTALL_HOME/software/genpipes/genpipes-3.1.0/pipelines/"$typepipe"
dirgenome=$MUGQIC_INSTALL_HOME/genomes/species/$genome
echo "python $versionpython"

module load python/$versionpython

echo "Generating command files for analysis"

python $dirpipe/$typepipe.py -f -c $dirpipe/$typepipe.base.ini $dirpipe/$typepipe.cedar.ini $dirgenome/$genome.ini oct_2018_config.ini -s $mysteps -o $myoutputdir -r $myreadset -j slurm > run_step_$mysteps.sh

echo "Pipeline_preparation completed, bash run_step_1-15.sh to start"

