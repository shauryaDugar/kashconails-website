FROM tiangolo/uwsgi-nginx-flask:latest
RUN apt-get update
RUN apt-get -y install bash nano
ENV STATIC_URL /static
ENV STATIC_PATH /app/app/static
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./app /app
COPY ./requirements.txt /var/www/requirements.txt
RUN pip install -r /var/www/requirements.txt