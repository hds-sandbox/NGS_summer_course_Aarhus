FROM dreg.cloud.sdu.dk/ucloud-apps/jupyter-base:3.3.2

MAINTAINER "Emiliano Molinaro <molinaro@imada.sdu.dk>"

LABEL software="JupyterLab" \
      author="Emiliano Molinaro" \
      version="3.3.2" \
      license="MIT" \
      description="Jupyter complete container for UCloud"


USER 0



## Install additional programs
# RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
#     ...

USER $NB_USER


RUN conda install -c conda-forge scanpy==1.9.1 leidenalg=0.8.10 python-igraph==0.9.10\
 && conda clean --all -f -y \ 
 && fix-permissions "${CONDA_DIR}/share/jupyter/kernels/" \
 && fix-permissions "/home/${NB_USER}"


## Set startup script in the PATH
#COPY --chown=${NB_USER}:${NB_GID} start-jupyter ${CONDA_DIR}/bin/
#RUN chmod +x ${CONDA_DIR}/bin/start-jupyter
COPY --chown=${NB_USER}:${NB_GID} start-jupyter ${CONDA_DIR}/bin/
RUN sed -i -e 's/\r$//' ${CONDA_DIR}/bin/start-jupyter \
 && chmod +x ${CONDA_DIR}/bin/start-jupyter

WORKDIR /work

