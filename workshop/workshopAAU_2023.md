---
permalink: /workshop/
hide:
  - navigation
  - toc
  - footer
---

<h1 align=center style="margin:0px">Sandbox Workshop</h1>
<h3 align=center style="margin:0px">Autumn 2023</h3>

<h4 align=center>Welcome to the homepage for in-person workshops introducing the Health Data Science Sandbox to potential users. Thanks for joining us!</h4> 

!!! info "Upcoming Workshop at AAU"
    <b> Intro to the Health Data Science Sandbox at Aalborg University</b>

    Interested in adding **new analysis techniques** to your health data science skill set? Curious about how to use Danish **supercomputing resources**? Looking for how to host **coding material for your own course** as an academic educator? Join our workshop for a demo of the Health Data Science Sandbox, a platform for training and research being built collaboratively across 5 universities. We will introduce our mission, network, and resources and then give you an opportunity to try out our omics-focused training module with **single cell RNA sequencing data** in a guided live session on UCloud (experience with R is a plus but not required). The workshop is open for students, researchers, and educators. 
    
    - Instructors: Sandbox Data Scientists Jakob Skelmose (AAU CLINDA) and Samuele Soraggi (AU BiRC)
    - Time: 6 December 2023, 1200-1600
    - Location: SLV249 moedelokale 11.01.032 at AAU SUND
    - Prerequisites: anyone can join for the first hour to hear about Sandbox resources, how to use them, and plans for the future. Some experience with R or Python will help you if you join the following transcriptomics app demo for the rest of the session (but all are welcome).
    - [Sign up](https://www.moodle.aau.dk/course/view.php?id=50047) on AAU's Moodle or [email the Sandbox](mailto:nhds_sandbox@sund.ku.dk) with questions



<h2>Agenda</h2>
 1. The Sandbox Concept - 30 minutes
 2. Accessing Sandbox resources - 10 minutes
 3. Try out our transcriptomics module - 2 hours
 4. Discussion and feedback - 20 minutes

## The Sandbox concept
The Health Data Science Sandbox aims to be a training resource for bioinformaticians, data scientists, and those generally curious about how to investigate large biomedical datasets. We are an active and developing project seeking interested users (both trainees and educators). All of our open-source materials are available on our [Github page](https://github.com/hds-sandbox) and much more information is available on the rest of the website you are currently visiting! We work with both UCloud and Computerome (major Danish academic supercomputers) - see our [HPC Access page](https://hds-sandbox.github.io/access/index.html) for more info on each set up.

## Access Sandbox resources
We currently provide training materials and resources as topical apps on UCloud, the supercomputer located at the University of Southern Denmark. To use these resources, you'll need the following:

 1. Log onto UCloud at the address http://cloud.sdu.dk using your university credentials.
 2.  the ability to navigate in linux / RStudio / Jupyter. You don't need to be an expert, but it is beyond our ambitions (and course material) to teach you how to code and how to run analyses simultaneously. We recommend a basic R or Python course before diving in.

 **Note:**

 1. To use Sandbox materials outside of the workshop, you can request a project by clicking on `apply for resources` in your uCloud dashboard.
 2. If you are a BSc or MSc student, you need a supervisor to apply on your behalf, or you can try to apply yourself mentioning the supervisor approval in the application.
 3. Remember, however, that you have 1000Kr of computing credit, and around 50GB of free storage to work on uCLoud.

## Try out our transcriptomics module
So our Sandbox data scientists have finished their intro at the workshop? Great, now the brave ones in the audience can try out one of our apps in a live session. Today we are demoing:

![Transcriptomics](../assets/images/transcriptomics.png){ align=left width="10%" }
### Transcriptomics 
If you're interested in bulk or single cell RNA sequencing analysis and visualization, join Sandbox Data Scientist Samuele Soraggi from Aarhus University in testing out our Transcriptomics Sandbox app. 

Follow these instructions to try our app:

1. Click on the button below to join the project for today: <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Green Button</title>
  <style>
    /* Add some basic styling to the button */
    .green-button {
      display: inline-block;
      padding: 10px 20px;
      background-color: #4CAF50; /* Green color */
      color: #fff; /* White text */
      text-align: center;
      text-decoration: none;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }

    /* Add hover effect */
    .green-button:hover {
      background-color: #45a049; /* Darker green color on hover */
    }
  </style>
</head>
<body>
  <!-- Replace the "YOUR_LINK_HERE" placeholder with your actual link -->
  <a href="https://cloud.sdu.dk/app/projects/invite/7eb44b4b-f680-46d5-b17d-df2209b1b287" class="green-button">Go to Link</a>
</body>
</html>
You should see a message on your browser where you have to accept the invitation to the project. This will add you to a project on uCloud, where we have data and extra computing credit for the course.

2. Be sure you have joined the project. Check if you have the project OMICS workshop from the project menu (red circle). Afterwards, click on the App menu (green circle)
![](./img/project.png)

3. * Find the app `Transcriptomics Sandbox` (red circle), which is under the title `Featured`.
  
![](./img/chooseapp_transcriptomics.png)

* Click on it. You will get into the settings window. Choose any Job Name (Nr 1 in the figure below), how many hours you want to use for the job (Nr 2; choose at least 3 hours, you can increase this later), and how many CPUs (Nr 3, choose at least 4 CPUs). Choose the course `RNAseq in RStudio` from the drop-down menu (Nr 4). Finally, click on the blue button `Add Folder`.

![](./img/setting_transcriptomics.png)

* Now, click on the browsing bar that appears (red circle).

![](./img/addfolder.png)

* In the appearing window, you should see already a folder called `Intro_to_scRNAseq_R`. Click on `Use` at its right (red circle)

![](./img/choosefolder_binfconf2023.png)


* Afterwards, you should have something like this in the settings page:

![](./img/addedfolder_binfconf2023.png)

* Now, click on Submit to start the app (the button is on the right side of the settings page)

* You will now enter a waiting queue. When the session starts, the timer begins to count down (red circle), and you should be able to open the interface through the button (green circle). Note the buttons to add time to your session (blue circle) and the button to stop the session when you are done (pink circle)

![](./img/running_transcriptomics.png)

* Open the interface by clicking on the button (green circle of figure above). Sometimes you are warned of a missing connection: simply refresh the page. You will enter `Rstudio`, well-known interface to code in `R`.

* Run the following command to download the tutorial: `download.file("https://raw.githubusercontent.com/hds-sandbox/ELIXIR-workshop/main/Notebooks/scRNAseq_Tutorial_R.Rmd", "tutorial_scrna.Rmd")`

* Open the file `tutorial_scrnaR.Rmd` that should now appear in the file browser of Rstudio. Click now on `visual` (on the tool bar) if you need to see the tutorial in a more readable format.

* The executable code is inside chunks (called cells) to be executed in order from the first to the last using the little green arrow appearing on the right side of each code cell.

* Read carefully through the tutorial and execute the code cells. You will see the outputs appearing as you proceed. 


## Discussion and feedback
We hope you enjoyed the live demo. If you have broader questions, suggestions, or concerns, now is the time to raise them! If you are totally toast for the day, remember that you can check out longer versions of our tutorials as well as other topics and tools in each of the [Sandbox modules](https://hds-sandbox.github.io/modules/index.html) or join us for a multi-day in person [course](https://hds-sandbox.github.io/news/news.html).

As data scientists, we also would be really happy for some quantifiable info and feedback - we want to build things that the Danish health data science community is excited to use. <b>Please answer these [5 questions](survey link) for us before you head out for the day</b>  (*link activated on day of the workshop*).


<h2 align=center style="margin:0px">Nice meeting you and we hope to see you again!</h2>








