#!/bin/bash

mkdir -p ./CourseMaterial/Data/
echo "Downloading clover data..."
wget https://zenodo.org/record/6952995/files/clover.tar.gz?download=1 -O /tmp/Clover_Data.tar.gz
tar -zxvf /tmp/Clover_Data.tar.gz -C ./CourseMaterial/Data/
echo "Downloading single cell data..."
wget https://zenodo.org/record/6952995/files/singlecell.tar.gz?download=1 -O /tmp/scrna_Data.tar.gz
tar -zxvf /tmp/scrna_Data.tar.gz -C ./CourseMaterial/Data/
rm -f /tmp/*.tar.gz

echo "Activating kernels..."
/opt/conda/envs/NGS_aarhus_py/bin/python -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)"
/opt/conda/envs/NGS_aarhus_py/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')"

echo "Modifying kernels..."
cp /tmp/kernel_py_docker.json $HOME/.local/share/jupyter/kernels/ngs_python/kernel.json
cp ./Course_Material/Environments/kernel_R_docker.json $HOME/.local/share/jupyter/kernels/ngs_r/kernel.json