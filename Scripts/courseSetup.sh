#!/usr/bin

##enable conda in bash shell
eval "$(conda shell.bash hook)"

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