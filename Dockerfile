FROM jupyter/minimal-notebook:latest

MAINTAINER "Samuele Soraggi <samuele@birc.au.dk>"

LABEL software="GenomicsCourses" \
      author="Samuele Soraggi" \
      version="v2022.08.01" \
      license="MIT" \
      description="NGS summer school Aarhus"


USER 0

RUN mkdir -p /usr/Material 

COPY --chown=${NB_USER}:${NB_GID} ./Notebooks /usr/Material/Notebooks
COPY --chown=${NB_USER}:${NB_GID} ./Environments /usr/Material/Environments
COPY --chown=${NB_USER}:${NB_GID} ./Scripts /usr/Material/Scripts
COPY ./Notebooks /usr/Material/Notebooks
COPY ./Environments /usr/Material/Environments
RUN ln -s /usr/Material ./Course_Material

RUN eval "$(mamba shell.bash hook)"
RUN conda config --add channels bioconda
RUN conda config --add channels plotly
RUN conda config --add channels grst
RUN conda config --add channels anaconda
RUN conda config --add channels conda-forge

RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN mamba env create -p "${CONDA_DIR}/envs/NGS_aarhus" -f ./Course_Material/Environments/environment.yml && \
    mamba clean --all -f -y

RUN "${CONDA_DIR}/envs/NGS_aarhus/bin/python" -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)" && \
    /opt/conda/envs/NGS_aarhus/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN echo "c.MappingKernelManager.default_kernel_name='NGS_python'" >> ~/.jupyter/jupyter_notebook_config.py && \
    jupyter kernelspec uninstall -y python3

RUN fix-permissions "/usr/Material"
RUN cp ./Course_Material/Environments/kernel_py.json ~/.local/share/jupyter/kernels/ngs_python/kernel.json