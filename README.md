# RNAseq-Pipeline
## Adaptation of the GENPIPES RNAseq pipeline

GENPIPES : (https://bitbucket.org/mugqic/genpipes/src/master/pipelines/rnaseq/)


### Setup

First, you should add these lines to your .bash_profile.sh file in your /home/$USER directory if they are not already there
To add them you can open the file with vi (vi .bash_profile) and simply copy paste them (CTL+SHIFT+C for copy, right click with the mouse to paste)

```
export MUGQIC_INSTALL_HOME=/cvmfs/soft.mugqic/CentOS6

export MUGQIC_INSTALL_HOME_DEV=/cvmfs/soft.mugqic/CentOS6

module use $MUGQIC_INSTALL_HOME/modulefiles


export SLURM_ACCOUNT=def-pcampeau

export SBATCH_ACCOUNT=$SLURM_ACCOUNT

export SALLOC_ACCOUNT=$SLURM_ACCOUNT


```

You should also set up your email variable by adding the following line to your .bash_profile


```
export JOB_MAIL=your@email.com
```

Make sure you are in your scratch space:

```
cd ~/scratch
```

You should run RNAseq_pipeline.sh with the following arguments

1. A text file containing the samples to analyse with their paths
2. The word SINGLE or PAIRED according to your run type
3. The sequence for the adapters (the file adapters.txt containing the usual adapters is provided in the folder)
4. The directory in which you want to work
5. The name of the genome you want to align to. Examples are: hg19, GRCh38, mm10, GRCm38


example:
```
bash RNAseq_pipeline.sh paired_end_fastq.txt PAIRED adapters.txt /home/jimd/scratch/RNAseq_pipeline/FASTQ_paired hg19
```

### Additionnal notes
If you have more than one fastq file per sample, merge them into one merged file using the following code.

Go to the directory where the FASTQ files are and merge them:

```
for i in $(ls *.fastq.gz | cut -d '_' -f1 | uniq) ; do cat `ls | grep $i`  >merged_$i.fastq.gz; done
```

Then delete non-merged files:

```
rm `ls *.fastq.gz | grep -v "merged"`
```

To get a list of all samples do, when in the directory with the fastqs:

```
for i in $(ls *.fastq.gz); do echo $i >> samples.txt; done
```
