# Instructions

You have various options to run the course material. You can execute it on a supercomputing system or on your own computer.

### Access the material on uCloud

`Ucloud` is an interactive online platform from the [University of Southern Danmark eScience center](https://escience.sdu.dk/) that allows users to execute softwares and computer code directly from their browser. If you are enrolled in a danish university or hospital, you can access the platform for free and try the course.

Please follow these instructions to access uCloud and get access to the course:

* To access uCloud for the first time, go to the [ucloud webpage](https://cloud.sdu.dk) and log in by pressing on the green button, choosing your institution, and writing your institutional credentials. If you have a mail address from a danish institution or university, you should be able to login with your institutional credentials.

* If you are participating in the NGS Summer Course 2023 in Aarhus, click **AFTER logging in** on [this link](https://cloud.sdu.dk/app/projects/invite/48779752-3cd2-41f7-b497-fc465d24990b). This will add you to a project on uCloud, where we have data and extra computing credit for the course. You should see a message on your browser where you have to accept the invitation to the project.

* Click on the uCloud symbol on the top-left corner of the uCloud webpage. You should see a dashboard window similar to the one below. The dashboard is a home page you will always see when opening uCloud. You can use the menu on the left to navigate to different sections of uCloud (File explorer, applications, etc.)
  ![](./img/ucloud_dashboard.png)

* On top of the uCloud interface you have `My Workspace`. That is your private space where you have some free hundreds of CPU hours and GBs of memory to run different applications (that you can see by using the menu `Apps` on the left). 
 
* Click on `Apps` and find the application called `Genomics Courses`. Here choose the course `Intro to NGS data`, and use the other options to choose, for example, how many resources you want to use (we suggest at least 8 vCPUs)

### Run the docker container

With `Docker`, you can create containers that will work in the same way on all the machines. The results of the course are *exactly* reproducible if you use such a `Docker` container. We created a container for the course that already contains packages and course material installed. You need to download `Docker Desktop` [at this link](https://www.docker.com/products/docker-desktop/). We suggest you have at least `8GB` of RAM and `20GB` of hard disk space.

* When `Docker Desktop` is installed, you can use the command line to retrieve the container from the web:
`docker pull samuelesoraggi/ngs-summer-aarhus:2022.08.01`

* You can now execute the container. You will see a web address in the output of the command line: you need to copy that into your web browser to see `jupyterlab`.

`docker run --rm -it -p 8888:8888 samuelesoraggi/ngs-summer-aarhus:2022.08.01`