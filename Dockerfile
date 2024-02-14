FROM tiangolo/uwsgi-nginx-flask:latest
RUN apt-get update
RUN apt-get -y install bash nano
RUN apt-get install -y certbot
ENV STATIC_URL /static
ENV STATIC_PATH /app/app/static
COPY ./app /app
COPY ./requirements.txt /var/www/requirements.txt
RUN pip install -r /var/www/requirements.txt
# Copy SSL certificate and key
COPY ./ssl/fullchain.pem /etc/ssl/certs/fullchain.pem
COPY ./ssl/privkey.pem /etc/ssl/private/privkey.pem

# Nginx configuration
RUN echo "server {" > /etc/nginx/conf.d/ssl.conf && \
    echo "    listen 443 ssl;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    server_name kashconails.in;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    ssl_certificate /etc/ssl/certs/fullchain.pem;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    ssl_certificate_key /etc/ssl/private/privkey.pem;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    location / {" >> /etc/nginx/conf.d/ssl.conf && \
    echo "        try_files \$uri @app;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    }" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    location @app {" >> /etc/nginx/conf.d/ssl.conf && \
    echo "        include uwsgi_params;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "        uwsgi_pass unix:///tmp/uwsgi.sock;" >> /etc/nginx/conf.d/ssl.conf && \
    echo "    }" >> /etc/nginx/conf.d/ssl.conf && \
    echo "}" >> /etc/nginx/conf.d/ssl.conf
