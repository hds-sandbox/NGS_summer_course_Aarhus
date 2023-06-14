# Quality Control and Alignment of raw reads

This first exercise will be executed on `Galaxy`, an interactive platform to run bioinformatics workflow. We will replicate this lesson with computer code later in this course. `Galazy` has the possibility of working with a free account.

## Biological introduction

White clover (*Trifolium repens*) is an **allotetraploid**. This means that it contains genomes
originating from two different species within the same nucleus. Normally, white clover is an
outbreeding species, but a self-compatible line was used for [sequencing the white clover
genome](https://academic.oup.com/plcell/article/31/7/1466/5985684). This line is
designated `S10` in your data, indicating that this is the 10th self-fertilized generation. In
addition, you have data from a wild clover accession (ecotype) called Tienshan (`Ti`), which is
collected from Chinese mountains and is adapted to alpine conditions. 

![](./img/clover.png)
*Figure: Characterisation of the white clover population. T.Repens is a hybrid of T.Occidentale and T.Pallescens*



## Exercise guide

### Prepare the tools and data

1. Install IGV on your computer from [here](https://software.broadinstitute.org/software/igv/download). This is a genome browser you will use to look at some files.
2. Create a galaxy account at [usegalaxy.org](https://usegalaxy.org) and log into galaxy.
3. Find the course data by going to [this web address](https://usegalaxy.org/u/samuele.soraggi/h/ngs2023) and by clicking on `Import this history` (top left corner of the page).

#### Data

You will be working with two types of sequencing data.
The first is *PacBio Hifi reads*, which are long and accurate. You can find them under
Hifi_reads_white_clover.fastq.
The second type is *Illumina RNA-seq reads*, which are short and accurate and should be aligned
using a spliced aligner. There are 24 of these files, 12 for each of the two genotypes mentioned
before. The files are named `[genotype]_[treatment]_[replicate].fastq`. Treatment 1 is before and
treatment 2 is after exposure to frost, respectively.
In addition to the sequencing data, there are also the 4 reference files. Here, you will find three `fasta`
files containing the homologous contigs, i.e. two contigs that represent similar regions in the two
subgenomes. Contig1 is from the T. occidentale-derived subgenome and Contig2 is from the T.
pallescens-derived subgenome. The reference genome was generated using the PacBio Hifi reads
mentioned above.
The file white_clover_genes.gtf contains the gene annotations for the two contigs.

#### Workflow illustration

Through `Galaxy`, we build a workflow applying tools to the data. We will look at the quality of the raw reads for both PacBio HiFi and Illumina RNA-seq reads. Afterwards, we align to references, using two different tools for the two types of data. Finally, we will look at the quality of the alignments. We will work then on `uCloud` to analyze the aligned data in some of the upcoming lessons of the course.

![](./img/scheme_exercise.png)

### Galaxy Workflow

   When you import the files, what you actually import is a **History** - a sequence of files and softwares applied on the data. You can see the history on the right side of your *usegalaxy.org* webpage with green panels. Here, we only have the starting data, and you will build the rest of your history through various tools. 

   ![](./img/history.png)

   On the left side of the screen, you have a menu with various available tools organized by category. All those softwares are also available on a classical computing command line.

   ![](./img/tools.png)   



#### Quality control

1. Run FastQC on the PacBio Hifi reads and on two of the Illumina RNA-seq libraries. FastQC does quality control of the raw sequence data, providing an overview of the data which can help identify if there are any problems that should be addressed before further analysis. 
   
    In the tool menu, click on `FASTQ quality control --> FASTQC read quality reports`. You will see a window with *tool parameters*: for the first option (raw read data from history), choose multiple files and select `Hifi_reads_white_clover.fastq` plus other `fastq` files you want to see the quality of (example in figure below).  Then click on the button `Run Tool`.
    ![](./img/fastqc.png)

    You will notice that some new elements are added to your history. Part of them are `FastQC` producing a text file, while others are `FastQC` producing a webpage report. The reports are ready when coloured in green: click on the *eye symbol* of a history item to read a report.

2. FastQC provides a report for each sample. To have a better comparison between
the *Hifi* and *Illumina* data, we would combine the three `FastQC` reports into one using `MultiQC`.

Choose the MultiQC tool from `FASTQ quality control --> MultiQC aggregate results from ...`. In the options, select `FastQC` as the used tool for the logsselect FastQC as the tool used to generate the output, and then select the items of `FastQC` of your history producing `RawData` (Figure below). In this way, you build a pipeline from the previous reports to the new tool you are using. Now click on `Run Tool`.

![](./img/multiqc.png)

The tool will be now running in your history. When it is done, click on the *eye symbol* to see the report.

select the three “RawData” outputs generated by FastQC. Visualize the Webpage generated by
MultiQC.
Hint: You can find a “Help” button that offers additional information about the plots for each panel.

<summary>Questions:
<p>
<i>Focus on the following panels: “Per base sequence quality”, “Per sequence quality scores”…. (“Per base sequence content” always gives a FAIL for RNA-seq data). What do you notice with respect to the sequence quality scores? And are there any other quality issues worth noting?
</i>
</p>
</summary>

#### Hifi Data Alignment