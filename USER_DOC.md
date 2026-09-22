# Services

## MariaDB

An open-source relational database management system that stores and manages the data used by WordPress.

## WordPress

An open-source content management system that allows users to easily create, manage, and publish websites. It uses MariaDB to store data and Redis to improve performance with caching.

## Nginx

An open-source web server that acts as the HTTPS entry point for the website. It securely serves WordPress through port 443.

## FTP Server

A file transfer service that allows users to remotely upload, download, and manage the website's WordPress files.

## Adminer

A lightweight web-based database management tool that allows users to easily manage and interact with the MariaDB database.

## Website

My simple static website in HTML and CSS hosted in python, accessible through port 7000 and independent from WordPress.

## LazyDocker

A terminal-based interface that makes it easier to monitor and manage Docker containers, view logs, and inspect container resources.

## Redis

An in-memory data store used as a cache to improve WordPress performance and reduce the number of requests made to the MariaDB database.


# Commands

## Start
```
make up
```
This command runs Docker Compose, which will start all the services.
<br><br>
To check the status of the services, run this command to view each container:
```
docker ps
```

## Stop
Shut down all services:
```
make down
```

Stop all services and their associated volumes
```
make clean
```

Stop all services and permanently remove all images, volumes, and local data
```
make fclean
```

# Access

Wordpress website Page link:
```
mthetcha.42.fr
```

Wordpress Admin panel link:
```
mthetcha.42.fr/wp-admin
```

# Credentials

Credentials are managed through environment variables defined in the `.env` file. This file contains sensitive information required by the different services, such as **database credentials**, **WordPress admin credentials**, and **user credentials**.

The `.env` file is located at the **root** of the project and is used by Docker Compose to provide the required environment variables to the containers.

Sensitive credentials include:

- MariaDB database name, username, and password
- WordPress administrator username, password, and email
- WordPress user username, password, and email
- Domain name and other service configuration values

To change a credential, update the corresponding variable in the `.env` file and rebuild the affected containers if necessary

# Service status

The status of all services can be checked using Docker Compose:
```
docker ps
```
All containers should have a status such as `Up` and should not be constantly restarting.

To check the logs of a specific service, use:
```
docker logs <service_name>
```
Lazydocker can also be use to see status and logs of all services by:
```
docker attach lazydocker
```