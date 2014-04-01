RWizFlowy
=========

Combines the nimblness and expressive power of R with some engineering elbow grease to enable agile and collaborative authoring of Reports and Dashboards in R.

Setup doc for local development:
https://docs.google.com/document/d/1AcbX8aH_UnYDHx8wU75xRuteSZdMpJIxLxl2TpH0K-c/edit?usp=sharing

Slides from the presentation:
https://docs.google.com/a/betterment.com/presentation/d/1ekIdY-VpPeOWWC7VgD2aBsT9IU34I9K_98eD_zmuFAM/edit#slide=id.g1dd976d0a_059

The Workflow
------------

Authoring. Data Analyst:
* check out your proejct from GitHub
* use familiar tooling on their workstations to produce static or interactive visualizations from a database
* visualisations are output to a locally mounted network drive such as an S3 bucket hosted in Amazon’s Cloud
* a web server enables web access to the visualization via a predictable URL
* review the produced content in your favorite browser
* a new page on a favorite wiki can then iframe or src the visualization

Staging. Data Analyst:
* add a runtime schedule to /etc/cron to designate how often you want the scrip to run in production
* commit and push your code to GitHub - ideally, open a Pull Request from your branch into a shared branch. get your script peer reviewed.

Deployment. GitHub and Travis-CI:
* once your code is merged into the Master branch, Travis-CI checks out your code
* based on .travis.yml config in this project, Travis will set up a staging environment, run any tests, and pass or fail the buld
* if the build passes, Travis will Git Push to a remote repository configured on your EC2 instance
* a Post-Receive hook on the EC2 instance's git repo will deploy the latest code, update cron, set permissions
* next time cron executes, your script will run against production data and update the visualizations in the S3 bucket (S3 bucket is also mounted on the EC2 server)
* reload your wiki and your visualizations are now updating over time

The Stack
---------
This project provides scaffolding for
* G. GitHub
* R. R-language
* E. Engineering Elbow Grease to glue everything together
* A. Amazon Web Services: EC2 server, S3 Bucket for network storage, RDS running MySQL
* T. Travis-CI: for continuous integration and deployment via GitHub


