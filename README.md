# CODE FOR THE WEBSITE KASHCONAILS.IN

This repository contains all the code for the website [kashconails.in](https://kashconails.in). 
The website has a simple frontend in vanilla html, css. The backend is designed in flask. 
- The code for the website is within the `app/` directory. The flask design is very simple, with a single file `routes.py` that handles all the web routes, an `__init__.py` file that initializes the flask app and mail configurations. 
- The `templates` and `static` folders contain the html, css, js, and other frontend files.
- The `run.sh` file contains the code to build the docker image for the app and run the container with necessary port buindings.
- The docker image for this app is created from the [tiangolo uwsgi-nginx-flask image](https://github.com/tiangolo/uwsgi-nginx-flask-docker). It uses a uwsgi-nginx docker image to host the flask backend.

### ABOUT KASHCO NAILS

Kashco Nails is a leading manufacturer and supplier of Brad Nails, Coil Nates and Staples in India. 
We have also been importing furniture hardware, self-tapping screws, Insert Type D Nut since 2010. 
For more information about us, you can visit [this](https://kashconails.in/about) page, and contact us [here](https://kashconails.in/contact).
