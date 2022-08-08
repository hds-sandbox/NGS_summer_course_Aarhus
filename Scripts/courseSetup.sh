#!/usr/bin

##enable conda in bash shell
eval "$(conda shell.bash hook)"

conda env create -n NGS_Aarhus_test python==3.9
conda activate NGS_Aarhus_test
conda config --add channels bioconda grst defaults anaconda conda-forge plotly
conda install mamba
mamba install scanpy==1.9.1 \
  - python-igraph==0.9.10 \
  - leidenalg==0.8.10 \
  - anaconda \
  - ipykernel \
  - scvelo==0.2.4 \
  - python-annoy==1.17.0 \
  - multicore-tsne==0.1_d4ff4aab \
  - pytables==3.7.0 \
  - plotly==5.8.0 \
  - nbformat==5.3.0 \
  - star==2.7.10a \
  - bcftools==1.15.1 \
  - scikit-allel==1.3.5 \
  - fastqc==0.11.9 \
  - multiqc==1.13a \
  - qualimap==2.2.2d \
  - minimap2==2.24 \
  - r-base==4.1.3 \
  - r-dplyr==1.0.9 \
  - r-vcfr==1.12.0 \
  - r-formattable==0.2.1 \
  - r-venndiagram==1.7.3 \
  - r-irkernel==1.3 \
  - r-pheatmap==1.0.12 \
  - bioconductor-mixomics==6.17.26 \
  - bioconductor-edger==3.36 \
  - vcftools==0.1.16 \
##install conda environments from environment files
conda env create -f python_environment.yml
conda env create -f R_environment.yml

##setup kernels in jupyterlab
conda activate NGS_Aarhus_R
R -e "IRkernel::installspec(name = 'NGS_Aarhus_R', displayname = 'NGS_Aarhus_R')"
conda deactivate
conda activate NGS_Aarhus_python
python -m ipykernel install --user --name NGS_Aarhus_python --display-name "NGS_Aarhus_python"
conda deactivate