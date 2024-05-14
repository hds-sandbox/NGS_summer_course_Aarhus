---
layout: page
title: Bulk RNAseq
grand_parent: Modules
parent: Transcriptomics
has_children: false
nav_order: 2
hide:
  - footer
  - toc
---

# Introduction to bulk RNAseq analysis workshop


<center>
[:material-web-plus: Course Page](https://hds-sandbox.github.io/bulk_RNAseq_course/){  .md-button .md-button--success }
</center>

This workshop material includes a tutorial on how to approach RNAseq data, starting from your count 
matrix. Thus, the workshop only briefly touches upon laboratory protocols, library preparation, and 
experimental design of RNA sequencing experiments, mainly for the purpose of outlining considerations 
in the downstream bioinformatic analysis. This workshop is based on the materials developed by 
members of the teaching team at the 
[Harvard Chan Bioinformatics Core (HBC)](http://bioinformatics.sph.harvard.edu/), a collection of 
modified tutorials from the 
[DESeq2](https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html) and 
R language vignettes.


**Intended use:** The aim of this repository is to run a comprehensive but introductory workshop on 
bulk-RNAseq bioinformatic analyses. Each of the modules of this workshop is accompanied by a 
powerpoint slideshow explaining the steps and the theory behind a typical bioinformatics analysis 
(ideally with a teacher). Many of the slides are annotated with extra information and/or point to 
original sources for extra reading material.

## Goals

By the end of this workshop, you should be able to analyse your own bulk RNAseq count matrix:

-   Normalize your data.
-   Explore your samples with PCAs and heatmaps.
-   Perform Differential Expression Analysis.
-   Annotate your results.

!!! agenda "Syllabus"
    1.  Course Introduction
    2.  Setup
    3.  Experimental planning
    4.  Data Explanation
    5.  Preprocessing
    6.  RNAseq counts
    7.  Exploratory analysis
    8.  Differential Expression Analysis
    9.  Functional Analysis
    10. Summarized workflow

!!! info "Workshop prerequisites"
    -   Knowledge of R, Rstudio and Rmarkdown. It is recommended that you have at least followed our workshop [R basics](https://github.com/Center-for-Health-Data-Science/FromExceltoR_2022)
    -   Basic knowledge of RNAseq technology
    -   Basic knowledge of data science and statistics such as PCA, clustering and statistical testing



### Acknowledgements
-   [Center for Health Data Science](https://heads.ku.dk/), University of Copenhagen.
-   [Hugo Tavares](https://bioinfotraining.bio.cam.ac.uk/about), Bioinformatics Training Facility, University of Cambridge.
-   [Silvia Raineri](https://danstem.ku.dk/people/serup_staff/), Center for Stem Cell Medicine (reNew), University of Copenhagen.
-   [Harvard Chan Bioinformatics Core (HBC)](http://bioinformatics.sph.harvard.edu/), check out their [github repo](https://github.com/hbctraining/DGE_workshop_salmon_online)

