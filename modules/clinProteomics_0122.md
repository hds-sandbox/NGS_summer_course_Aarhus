---
layout: page
title: Clinical Proteomics
grand_parent: Modules
parent: Proteomics
has_children: false
nav_order: 2
hide:
  - footer
  - toc
---

# Clinical Proteomics
[:fontawesome-brands-github: GitHub Repository](https://github.com/hds-sandbox/proteomics-course)

**Updated:** January 2021  
**Status:** Under expansion

The general strategy for the clinical proteomics module is to provide software, computing resources, datsets and storage using UCloud. Written material (instructions etc.), example notebooks and other auxiliary files will be provided in a Github repository.

* Proteomics Sandbox app will be used for GUI programs
   * Primarily for identification / quantification
   * FragPipe / MSFragger for database search (and perhaps open search)
   * PDV for visualizing spectral matches
   * SearchGUI and PeptideShaker also available
* JupyterLab app for data analysis after quantification
   * Init script to activate conda environment and install custom kernel
   * Notebooks provided through Github (https://github.com/hds-sandbox/proteomics-course)
* Datasets, (installed) software and JSON config files stored in UCloud project folders
   * Students currently need to be project members

**Intended use:** Self-guided introduction to basic proteomics

!!! abstract "Syllabus"
    1. [Identify and quantify peptides/proteins](https://github.com/hds-sandbox/proteomics-documentation/tree/main/TeachingMaterial/Identification.md)
        * "Database search" using MSFragger/FragPipe or MaxQuant
        * Visualize peptide spectrum matches using e.g. PDV, IDPicker, IPSA, ...
    2. Quality control analysis
    3. Bioinformatics
        * Reintegrate clinical metadata
        * JupyterLab / RStudio + e.g. PolySTest / VSClust / …
    4. PhosphoProteomics


!!! info "Workshop requirements"
    Knowledge of Python and Jupyter Notebooks


## Other learning resources
 
* [BMB online computational proteomics course](http://training.bmb.sdu.dk/courses/course-v1:University_of_Southern_Denmark+SDU_BMB_COMPPROT+2020_1/about)
* [NordBioNet summer school 2021](https://docs.google.com/document/d/10kys2A7bFqTVVetXsfQZWXuypIQPYOcWEB-dm9Lti0s/edit#heading=h.m9b3pmbk2btv) (workshops)
* [Introduction to bioinformatics for proteomics](https://www.compomics.com/bioinformatics-for-proteomics/) - Prof. Harald Barsnes, University of Bergen
* [QC workshop](https://github.com/oercompbiomed/Odense-2021/tree/main/QC_Workshop) and [Quantitative Analysis workshop](https://github.com/oercompbiomed/Odense-2021/tree/main/Quant_Workshop), [long 2019 version](https://gtpb.github.io/IBIP19/) - Prof. Veit Schwammle, University of Southern Denmark
* [Simulation of proteomics data](https://github.com/oercompbiomed/Odense-2021/tree/main/InSilicoBottomUp_Workshop) - Dr. Marie Locard-Paulet, University of Copenhagen
* [Proteogenomics](https://github.com/mvaudel/proteogenomics_08.21) - Dr. Marc Vaudel, University of Bergen


### Acknowledgements
- [Center for Health Data Science](https://heads.ku.dk/), University of Copenhagen.