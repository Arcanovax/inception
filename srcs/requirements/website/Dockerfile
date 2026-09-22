FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y python3
WORKDIR /var/www/html

COPY index.html .
COPY profile.jpg .

CMD ["python3", "-m", "http.server", "7000"]
