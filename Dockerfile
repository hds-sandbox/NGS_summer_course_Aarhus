FROM dreg.cloud.sdu.dk/ucloud-apps/jupyter-all-spark:3.4.2

MAINTAINER "Samuele Soraggi <samuele@birc.au.dk>"

LABEL software="GenomicsCourses" \
      author="Samuele Soraggi" \
      version="v2022.08.01" \
      license="MIT" \
      description="Genomics Courses - Jupyter complete container for UCloud"


USER 0

RUN mkdir -p /usr/Material 

## Install additional programs
# RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
#     ...

USER $NB_USER

COPY --chown=${NB_USER}:${NB_GID} ./Notebooks /usr/Material/Notebooks
COPY --chown=${NB_USER}:${NB_GID} ./Environments /usr/Material/Environments
COPY ./Notebooks /usr/Material/Notebooks
COPY ./Environments /usr/Material/Environments
RUN ln -s /usr/Material ./Course_Material


RUN conda install mamba
RUN mamba env create -f /usr/Material/Environments/environment.yml -p /usr/Material/NGS_course_aarhus

RUN fix-permissions "${CONDA_DIR}/share/jupyter/kernels/" \
    && fix-permissions "/home/${NB_USER}"



#RUN ln -s /usr/Material /work/Course_Material

#RUN jupyter kernelspec uninstall python3



## Set startup script in the PATH
#COPY --chown=${NB_USER}:${NB_GID} start-jupyter ${CONDA_DIR}/bin/
#RUN chmod +x ${CONDA_DIR}/bin/start-jupyter
#COPY --chown=${NB_USER}:${NB_GID} start-jupyter ${CONDA_DIR}/bin/
#RUN sed -i -e 's/\r$//' ${CONDA_DIR}/bin/start-jupyter \
# && chmod +x ${CONDA_DIR}/bin/start-jupyter

#WORKDIR /work

