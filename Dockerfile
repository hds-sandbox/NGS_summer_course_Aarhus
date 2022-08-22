FROM dreg.cloud.sdu.dk/ucloud-apps/jupyter-all-spark:3.4.2
#jupyter/minimal-notebook:latest

MAINTAINER "Samuele Soraggi <samuele@birc.au.dk>"

LABEL software="GenomicsCourses" \
      author="Samuele Soraggi" \
      version="v2022.08.01" \
      license="MIT" \
      description="NGS summer school Aarhus"


USER 0

RUN mkdir -p /usr/Material 

COPY ./Notebooks /usr/Material/Notebooks
COPY ./Environments /usr/Material/Environments
COPY ./Scripts /usr/Material/Scripts

#download data
RUN mkdir -p /usr/Material/Data && \
    curl https://zenodo.org/record/6952995/files/clover.tar.gz?download=1 -o /usr/Material/Data/Clover_Data.tar.gz && \
    tar -zxvf /usr/Material/Data/Clover_Data.tar.gz -C /usr/Material/Data/ && \
    curl https://zenodo.org/record/6952995/files/singlecell.tar.gz?download=1 -o /usr/Material/Data/scrna_Data.tar.gz && \
    tar -zxvf /usr/Material/Data/scrna_Data.tar.gz -C /usr/Material/Data/ && \
    rm -f /usr/Material/Data/*.tar.gz
RUN ln -s /usr/Material ./Course_Material
RUN eval "$(mamba shell.bash hook)"

#permissions
RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "/usr/Material"

#create environments
RUN mamba env create -p "${CONDA_DIR}/envs/NGS_aarhus" -f ./Course_Material/Environments/environment.yml && \
    mamba clean --all -f -y

#install kernels
RUN "${CONDA_DIR}/envs/NGS_aarhus/bin/python" -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)" && \
    /opt/conda/envs/NGS_aarhus/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

#define default kernel
RUN echo "c.MappingKernelManager.default_kernel_name='NGS_python'" >> ~/.jupyter/jupyter_notebook_config.py && \
    jupyter kernelspec uninstall -y python3

### modify kernel files with system variables
RUN cp ./Course_Material/Environments/kernel_py.json ~/.local/share/jupyter/kernels/ngs_python/kernel.json && \
    cp ./Course_Material/Environments/kernel_R.json ~/.local/share/jupyter/kernels/ngs_r/kernel.json