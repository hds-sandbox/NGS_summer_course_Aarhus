#FROM dreg.cloud.sdu.dk/ucloud-apps/jupyter-all-spark:4.2.0
FROM jupyter/minimal-notebook:x86_64-lab-4.0.7

MAINTAINER "Samuele Soraggi <samuele@birc.au.dk>"

LABEL software="GenomicsCourses" \
      author="Samuele Soraggi" \
      version="v2024.07" \
      license="MIT" \
      description="Introduction to NGS data analysis using GenomeDK"


#USER 0

#RUN sudo mkdir -p /usr/Material 

# Arguments for the new UID and GID
ARG USER_UID=6835
ARG USER_GID=6835

USER root
RUN groupmod -g $USER_GID users && \
    usermod -u $USER_UID -g $USER_GID jovyan && \
    chown -R jovyan:users /home/jovyan

COPY ./environment.yml /tmp/

RUN sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y build-essential libjpeg9 libcurl4-openssl-dev libxml2-dev libssl-dev libicu-dev \
 && sudo apt-get clean \
 && eval "$(conda shell.bash hook)" \
 && conda config --set channel_priority flexible \
 && conda install -n base --yes conda-libmamba-solver conda-forge::mamba \
 && conda config --set solver libmamba \
 && conda env create -vv -p ${CONDA_DIR}/envs/NGS_aarhus_py -f /tmp/environment.yml \
 && conda activate ${CONDA_DIR}/envs/NGS_aarhus_py \
 && pip install --no-input --no-cache-dir jupyterlab-quarto \
 && pip install --no-input --no-cache-dir jupyterlab-code-formatter \
 && pip install --no-input --no-cache-dir black isort \
 && pip install --no-input --no-cache-dir jupyterlab-github \
 && pip install --no-input --no-cache-dir jupyter_bokeh \
 && pip install --no-input --no-cache-dir plotly \
 && pip install --no-input --no-cache-dir ipywidgets \
 && pip install --no-input --no-cache-dir pip install jupyter-dash \
 && conda clean -y -a

 # Expose the default JupyterLab port
EXPOSE 8888
COPY ./scripts/courseMaterial.sh /home/jovian/
COPY ./kernels/kernel_py_docker.json /home/jovian/
COPY ./kernels/kernel_R_docker.json /home/jovian/

#ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser"]


USER jovyan