#!/usr/bin

##enable conda in bash shell
eval "$(conda shell.bash hook)"

conda install -y -n base mamba
conda env create -p ${CONDA_PREFIX}/envs/NGS_aarhus -f Environments/environment.yml
conda activate NGS_Aarhus

${CONDA_PREFIX}/envs/NGS_Aarhus_test/bin/R -e "IRkernel::installspec(name = 'ngs_r', displayname = 'NGS (R)')"
${CONDA_PREFIX}/envs/NGS_Aarhus_test/bin/python -m ipykernel install --user --name ngs_python --display-name "NGS (python)"

cp .Environments/kernel_py.json ~/.local/share/jupyter/kernels/ngs_python/kernel.json && \
cp .Environments/kernel_R.json ~/.local/share/jupyter/kernels/ngs_r/kernel.json