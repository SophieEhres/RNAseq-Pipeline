#!/bin/bash

### USAGE ###
# bash make_readset_design.sh [file_with_list_of_bam_or_fastq] [SINGLE/PAIRED] [file_with_adapters/adapters.txt] [work_directory]

### MAKE READSET AND DESIGN ###

#Argument 1: files to analyse
FILES=$1
TYPE=$(head -1 $FILES | rev | cut -d'.' -f1 | rev)

#Argument 2
RUNTYPE="$2"_END

#Argument 3
ADAPTERS=$3
ADAPTER1=$(head -1 $ADAPTERS)
ADAPTER2=$(tail -1 $ADAPTERS)
echo adapters are $ADAPTERS
#Argument 4
DIRECTORY=$4
echo directory is $DIRECTORY
#Other variables
QUALITYOFFSET=33
COUNTER=1
DESIGN="Sample\tContrast1"

if [ "$TYPE" = "bam" ]; then

        if [ "$RUNTYPE" = "SINGLE_END" ]; then
                HEADER="Sample\tReadset\tRunType\tAdapter1\tQualityOffset\tBAM"
                echo -e $HEADER > $DIRECTORY/readset.txt
                echo -e $DESIGN > $DIRECTORY/design.txt
                for i in $(cat $FILES); do
                        SAMPLE=$(echo $i | rev | cut -d'/' -f1 | rev | sed 's/\.bam//g');
                        echo -e "$SAMPLE\treadset$COUNTER\t$RUNTYPE\t$ADAPTER1\t$QUALITYOFFSET\t$i" >> $DIRECTORY/readset.txt;
                        COUNTER=$((COUNTER+1));
                        echo -e "$SAMPLE\t0" >> $DIRECTORY/design.txt;
                done
        else
                #$RUNTYPE is PAIRED_END
                HEADER="Sample\tReadset\tRunType\tAdapter1\tAdapter2\tQualityOffset\tBAM"
                echo -e $HEADER > $DIRECTORY/readset.txt
                echo -e $DESIGN > $DIRECTORY/design.txt
                for i in $(cat $FILES); do
                        SAMPLE=$(echo $i | rev | cut -d'/' -f1 | rev | sed 's/\.bam//g');
                        echo -e "$SAMPLE\treadset$COUNTER\t$RUNTYPE\t$ADAPTER1\t$ADAPTER2\t$QUALITYOFFSET\t$i" >> $DIRECTORY/readset.txt;
                        COUNTER=$((COUNTER+1));
                        echo -e "$SAMPLE\t0" >> $DIRECTORY/design.txt;
                done
        fi

else
        #$TYPE is fastq
        if [ "$RUNTYPE" = "SINGLE_END" ]; then
                HEADER="Sample\tReadset\tRunType\tAdapter1\tQualityOffset\tFASTQ1"
                echo -e $HEADER > $DIRECTORY/readset.txt
                echo -e $DESIGN > $DIRECTORY/design.txt
                for i in $(cat $FILES); do
                        SAMPLE=$(echo $i | rev | cut -d'/' -f1 | rev | sed 's/\.single\.fastq\.gz//g');
                        echo -e "$SAMPLE\treadset$COUNTER\t$RUNTYPE\t$ADAPTER1\t$QUALITYOFFSET\t$i" >> $DIRECTORY/readset.txt;
                        COUNTER=$((COUNTER+1));
                        echo -e "$SAMPLE\t0" >> $DIRECTORY/design.txt;
                done
        else
                #$RUNTYPE is PAIRED_END
                HEADER="Sample\tReadset\tRunType\tAdapter1\tAdapter2\tQualityOffset\tFASTQ1\tFASTQ2"
                echo -e $HEADER > $DIRECTORY/readset.txt
                echo -e $DESIGN > $DIRECTORY/design.txt
                for i in $(cat $FILES | grep "pair1"); do
                        SAMPLE=$(echo $i | rev | cut -d'/' -f1 | rev | sed 's/\.pair1\.fastq\.gz//g');
                        PAIR=$(echo $i | sed 's/pair1/pair2/g')
                        echo -e "$SAMPLE\treadset$COUNTER\t$RUNTYPE\t$ADAPTER1\t$ADAPTER2\t$QUALITYOFFSET\t$i\t$PAIR" >> $DIRECTORY/readset.txt;
                        COUNTER=$((COUNTER+1));
                        echo -e "$SAMPLE\t0" >> $DIRECTORY/design.txt;
                done
        fi

fi
                                                                                       
