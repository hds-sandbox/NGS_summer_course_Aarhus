# Introduction to Next Generation Sequencing data
**A course of the danish healt data science sandbox**

This course is based on the material developed for the NGS summer school at Aarhus University. The material is organized in four separated jupyter notebooks in both `python` and `R` where you will benefit of an interactive coding setup.

---------------------

## How to run the course material

You have various options to run the course material. You can execute it on your own computer, or alternatively you can access to other resources.

### Access the material on uCloud

`Ucloud` is an interactive online platform that allows users to execute softwares and execute their own computer code. If you are enrolled in a danish university or hospital, you can access the platform for free and try the course.

Please follow these instructions to access uCloud and get access to the course:

* To access uCloud for the first time, go to the ucloud webpage and log in pressing the green button and writing your credentials.

* If you are from a mail address from a danish institution or university, you should be able to login with your institutional credentials.

* Once you log into uCloud, you should see a dashboard window similar to the one below
  ![](./img/ucloud_dashboard.png)

* On top of this page you have `My Workspace`. That is your private space where you have some free hundreds of CPU hours and GBs of memory to run different applications (that you can see by using the menu `Apps` on the left). 
 
* Click on `Apps` and find the application called `Genomics Courses`. Here choose the course `Introduction to NGS data`, and use the other options to choose how many resources you want to use (we suggest at least 8 vCPUs)

### Use the github repository

If you use the material from our `github` repository, it will run locally on the computer you are using. You might not have anough resources to do that if you have less than `4GB` of RAM: the single cell data analysis requires quite some memory usage, but the notebooks show a subsampling solution to solve that problem.
Before using the course, you need to install the `conda` package manager. If you are using the command line on `Linux`, you need to run

```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```

For the Mac platforms you can download installers at this address: [https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html).
Windows platform do not support some of the packages used in this course, so you need to either access `uCloud` or use the `Docker` container as explained in the next section.

Follow then these instructions:

* clone the github repository at this address `https://github.com/hds-sandbox/NGS_summer_course_Aarhus` either using the [Github desktop app](https://desktop.github.com/) or with the Linux/Mac command line instructions
`git clone -b main https://github.com/hds-sandbox/NGS_summer_course_Aarhus.git NGS_summer_course`

* Use the terminal to go into the course folder and run the setup script:
  ```
  cd NGS_summer_course
  sh ./Scripts/courseSetup.sh
  ```

* install and configure `jupyterlab`
 
  ```
  conda activate NGS_summer_course
  conda install jupyterlab
  ${CONDA_DIR}/envs/NGS_summer_course/bin/python" -m ipykernel install --user --name="NGS_python" --display-name "NGS (python)"
  /opt/conda/envs/NGS_summer_course/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')"
  ```

* when you are done with these steps, launch jupyterlab. You will be able to run the notebooks in the Folder `NGS_summer_course/Notebooks`.

### Use the `Docker` container for the course

With `Docker`, you can create containers that will work in the same way on all the machines. We created a container for the course that already contains packages and course material installed. You need to download `Docker Desktop` [at this link](https://www.docker.com/products/docker-desktop/).

* When `Docker Desktop` is installed, you can use the command line to retrieve the container from the web:
`docker pull samuelesoraggi/ngs-summer-aarhus:2022.08.01`

* You can now execute the container. You will see a web address in the output: you need to copy that into your web browser to see `jupyterlab`.

`docker run --rm -it -p 8888:8888 samuelesoraggi/ngs-summer-aarhus:2022.08.01`