#FROM dreg.cloud.sdu.dk/ucloud-apps/jupyter-all-spark:3.4.2
FROM jupyter/minimal-notebook:latest

MAINTAINER "Samuele Soraggi <samuele@birc.au.dk>"

LABEL software="GenomicsCourses" \
      author="Samuele Soraggi" \
      version="v2022.08.01" \
      license="MIT" \
      description="Introduction to NGS data analysis"


USER 0

RUN mkdir -p /usr/Material 

COPY ./Notebooks /usr/Material/Notebooks
COPY ./Environments /usr/Material/Environments
COPY ./Scripts /usr/Material/Scripts

#download data
RUN mkdir -p /usr/Material/Data && \
    wget https://zenodo.org/record/6952995/files/clover.tar.gz?download=1 -O /usr/Material/Data/Clover_Data.tar.gz && \
    tar -zxvf /usr/Material/Data/Clover_Data.tar.gz -C /usr/Material/Data/ && \
    wget https://zenodo.org/record/6952995/files/singlecell.tar.gz?download=1 -O /usr/Material/Data/scrna_Data.tar.gz && \
    tar -zxvf /usr/Material/Data/scrna_Data.tar.gz -C /usr/Material/Data/ && \
    rm -f /usr/Material/Data/*.tar.gz
RUN ln -s /usr/Material ./Course_Material
RUN eval "$(mamba shell.bash hook)"

## Add JupyterLab Extensions
RUN printf "Install JupyterLab extensions:" \
 && pip install --no-cache-dir "nteract-on-jupyter" \
 && jupyter labextension install "jupyter-threejs" \
 && jupyter labextension install "ipyvolume" \
 && jupyter lab clean -y \
 ## add support for LaTeX docs
 && pip install --no-cache-dir "jupyterlab-latex" \
 ## open spreadsheets such as Excel and OpenOffice
 && jupyter labextension install "jupyterlab-spreadsheet" \
 && jupyter lab clean -y \
 ## add top bar
 && pip install --no-cache-dir "jupyterlab-topbar" \
 && jupyter labextension install "jupyterlab-topbar-text" \
 && jupyter lab clean -y \
 ## add system monitor
 && pip install --no-cache-dir "jupyterlab-system-monitor" \
 ## add theme toggle bottom
 && jupyter labextension install "jupyterlab-theme-toggle" \
 && jupyter lab clean -y \
 ## add code formatter
 && pip install --no-cache-dir "autopep8" "yapf" "isort" "black" \
 && pip install --no-cache-dir "jupyterlab_code_formatter" \
 && jupyter lab build -y \
 && jupyter lab clean -y \
 && fix-permissions "/home/${NB_USER}" \
 ## add variableInspector
 && pip install --no-cache-dir "lckr-jupyterlab-variableinspector" \
 ## add nbdime
 && pip install --no-cache-dir "nbdime" \
 ## add Bokeh extension
 && pip install --no-cache-dir "jupyter_bokeh" \
 ## add Plotly extension
 && pip install --no-cache-dir  "plotly" \
 && jupyter labextension install "jupyterlab-plotly" \
 && fix-permissions "/home/${NB_USER}" \
 && fix-permissions "${CONDA_DIR}"

#permissions
RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "/usr/Material"

#create environments
RUN mamba env create -p "${CONDA_DIR}/envs/NGS_aarhus_py" -f ./Course_Material/Environments/python_environment.yml && \
    mamba env create -p "${CONDA_DIR}/envs/NGS_aarhus_r" -f ./Course_Material/Environments/R_environment.yml && \
    mamba clean --all -f -y

#install kernels
RUN "${CONDA_DIR}/envs/NGS_aarhus_py/bin/python" -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)" && \
    /opt/conda/envs/NGS_aarhus_r/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"


### modify kernel files with system variables
RUN cp ./Course_Material/Environments/kernel_py_docker.json ~/.local/share/jupyter/kernels/ngs_python/kernel.json && \
    cp ./Course_Material/Environments/kernel_R_docker.json ~/.local/share/jupyter/kernels/ngs_r/kernel.json