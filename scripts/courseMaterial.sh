#!/bin/bash

DIR="./Data"

if [ ! -d $DIR ]; then
    echo "========================================================"
    echo "Copying datasets from https://zenodo.org/record/6952995"
    echo "========================================================"
    mkdir -p ./Data/
    echo "Downloading clover data..."
    wget https://zenodo.org/record/6952995/files/clover.tar.gz?download=1 -O /tmp/Clover_Data.tar.gz
    tar -zxvf /tmp/Clover_Data.tar.gz -C ./Data/
    echo "Downloading single cell data..."
    wget https://zenodo.org/record/6952995/files/singlecell.tar.gz?download=1 -O /tmp/scrna_Data.tar.gz
    tar -zxvf /tmp/scrna_Data.tar.gz -C ./Data/
    rm -f /tmp/*.tar.gz
else
    echo "========================================================"
    echo "Datasets folder already exists, no need to download it"
    echo "========================================================"
fi

DIR="./Notebooks"

if [ ! -d $Notebooks ]; then
    echo "========================================================"
    echo "Copying Notebooks from github"
    echo "========================================================"
    git clone --depth 1 -b main https://github.com/hds-sandbox/NGS_summer_course_Aarhus.git  /tmp/courseData
    mv /tmp/courseData/Notebooks/ .
    rm -rf /tmp/courseData
else
    echo "========================================================"
    echo "Notebooks folder already exists, no need to download it"
    echo "========================================================"
fi

DIR="./Scripts"

if [ ! -d $Scripts ]; then
    echo "========================================================"
    echo "Copying Scripts from github"
    echo "========================================================"
    git clone --depth 1 -b main https://github.com/hds-sandbox/NGS_summer_course_Aarhus.git  /tmp/courseData
    mv /tmp/courseData/Scripts/ .
    rm -rf /tmp/courseData
else
    echo "========================================================"
    echo "Scripts folder already exists, no need to download it"
    echo "========================================================"
fi

echo "Activating kernels..."
/opt/conda/envs/NGS_aarhus_py/bin/python -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)"
/opt/conda/envs/NGS_aarhus_py/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')"

echo "Modifying kernels..."
wget https://raw.githubusercontent.com/hds-sandbox/NGS_summer_course_Aarhus/docker/kernels/kernel_py_docker.json -O $HOME/.local/share/jupyter/kernels/ngs_python/kernel.json
wget https://raw.githubusercontent.com/hds-sandbox/NGS_summer_course_Aarhus/docker/kernels/kernel_R_docker.json -O $HOME/.local/share/jupyter/kernels/ngs_r/kernel.json