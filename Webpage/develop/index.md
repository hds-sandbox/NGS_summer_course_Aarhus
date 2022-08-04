# Introduction to single cell RNA sequencing data analysis
**A course of the danish healt data science sandbox**
**(Page under construction - course not finalized)**

This course is organized as the analysis project of a dataset with cells from human testis representing the spermatogenesis process. We will also make a comparative analysis against a dataset from a person affected by azoospermia (missing or faulty production of spermatozoa). You will learn to use the tools for integrating and analyzing multiple datasets in both `python` and `R` with the use of interactive coding on `Rstudio` or `Jupyter Notebooks`. 

---------------------

## Biological background and motivation

The testis is a complex organ composed of multiple cell types: germ cells at different stages of maturation and several somatic cell types supporting testicular structure and spermatogen-esis; Sertoli cells, peritubular cells, Leydig cells and other interstitial cells, as outlined in the figure below.

![](img/celltypes.png)

Technological developments have recently made it possible to perform single-cell RNA sequencing (scRNAseq) of all cell types in a tissue. Understanding how scRNAseq data is processed and how to interpret the data is crucial for our ability to draw correct biological conclusions.

In this introduction we will preprocess and integrate multiple datasets together and perform an analysis to detect cell types, developmental stages, genes dominating in the various cell types, in a way that the spermatogenic process can be framed and characterized as an output of this course.

Infertility is a growing problem, especially in the Western world, where approximately 10–15% of couples are infertile. In line with this, we have observed a tremendous increase in the use of assisted reproductive techniques (ART) and espe-cially Intracytoplasmic Sperm Injection.  In about half of the infertile couples, the cause involves a male-factor (Agarwal et al. 2015; Barratt et al. 2017). One of the most severe forms of male infertility is azoo-spermia (from Greek azo - meaning “without life”) where no spermatozoa can be detected in the ejaculate, which ren-ders biological fatherhood difficult. Azoospermia is found in approximately 10–15% of infertile men (Jarow et al. 1989; Olesen et al. 2017) and the aetiology is thought to be primarily genetic.  

As the last step of this course, we will use a dataset of azoospermic cells to make a comparative analysis against the healthy cells. We will try to find which developmental processes are more highlighted in only one of the two datasets, and see which other differences characterize the azoospermic single cell data.