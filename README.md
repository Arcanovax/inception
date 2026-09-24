*This project has been created as part of the 42 curriculum by mthetcha.*

# Description

**Inception** is a Docker project from the 42 curriculum. The goal of the project is to build a infrastructure composed of several services running in isolated Docker containers and connected through a network.

The infrastructure is built around a **WordPress** website and includes:

- **NGINX** as the web server and HTTPS entry point.
- **WordPress** as the content management system.
- **MariaDB** as the relational database.

As a <u>bonus</u>, the project also includes other Docker services:

- **Redis** for WordPress caching.
- **FTP server** for accessing WordPress files.
- **Adminer** for database administration.
- A custom **static website**.
- **Lazydocker** for monitoring and managing the Docker environment.

Each service is built from its own **Dockerfile** and is isolated in its own container. The containers communicate through a dedicated `inception` bridge network.

# Project description

## Virtual Machines vs Docker

| Virtual Machines | Docker |
|---|---|
| Virtualizes an entire operating system | Shares the host kernel |
| Contains its own OS | Containers contain only the required|
| High resource consumption | Low resource consumption |
| Slow to start | Containers start quickly |
| Useful when different kernels/OS environments are required | Well suited for packaging and running individual services |

**VM** and **Docker** containers are therefore not the same, they are used for different purposes depending on the project's needs.

For this project, Docker is appropriate because the infrastructure consists of several independent services that can run as isolated containers with the same kernel.


## Secrets vs Environment Variables

| Environment Variables | Docker Secrets |
|---|---|
| Easy to configure | Designed for sensitive data |
| Convenient for general configuration | Credentials are provided as files |
| Commonly used with Compose | Better suited to secret management |
| Can expose sensitive values through container configuration | Reduces direct exposure of credentials |

This project uses environment variables because they are easier to use, especially with Docker Compose. However, this is not the most secure approach, the most secure approach would have been to use Docker Secrets.


## Docker Network vs Host Network

The difference is that a bridge network creates an isolated Docker network for the containers, while the host network removes this network isolation and allows the container to use the host machine's network directly.

| Docker Network | Host Network |
|---|---|
| Provides network isolation | Container uses the host network directly |
| Containers can communicate using Docker networking | Services share the host's network |
| Better control over exposed services | Less network isolation | 
| Suitable for multi-container applications | Useful when direct host networking is required |

This project uses a dedicated Docker bridge network:

```yaml
networks:
  inception:
    driver: bridge
```

Every service that needs to communicate with another service is connected to this network.

The bridge network is used to keep internal communication private while only publishing the ports required by external clients.

In this project, the exposed ports include:

- `443` for HTTPS;
- `21` and `30000-30005` for FTP;
- `8000` for Adminer;
- `7000` for the static website.

This allows, for example, WordPress to communicate with MariaDB via the Docker network without directly exposing the MariaDB database port to the host.

## Docker Volumes vs Bind Mounts

| Docker-managed volume | Bind mount |
|---|---|
| Managed by Docker | Direct mapping to a host path |
| Docker chooses/manages the storage location by default | User explicitly chooses the host directory |
| Easier to manage portably | Gives precise control over file location |
| Good for persistent application data | Useful when host-side access to files is required |

The project uses **2 Docker volumes configured with bind-style driver options** to store persistent data at known locations on the host.

For this project, WordPress and MariaDB data are stored in these directories:

```text
/home/mthetcha/data/mariadb
/home/mthetcha/data/wordpress
```

This also makes the persistence of the project data explicit.

# Instructions

## Build and start the project

To create the required directories and start the infrastructure:

```bash
make up
```

To rebuild the Docker images and start the containers:

```bash
make build
```

The services will then be started through `Docker Compose`.

---

## Accessing the services

Once the containers are running:

### HTTPS / WordPress

The main web service is available through:

```text
https://mthetcha.42.fr
```

### Adminer

```text
http://mthetcha.42.fr:8000
```

### Static website

```text
http://mthetcha.42.fr:7000
```

### Lazydocker

Lazydocker can be accessed with:

```bash
docker attach lazydocker
```

## Stop the infrastructure

```bash
make down
```

Stops and removes the containers without removing persistent data.

### Clean containers and volumes

```bash
make clean
```

Stops and removes containers and Docker Compose volumes.

### Full cleanup

```bash
make fclean
```


# Resources

<u>Wordpress installation and initialization:</u>
- https://www.gsplugins.com/how-to-install-wordpress-on-debian-12/
- https://verycloud.fr/docs/article/wordpress-debian13
- https://savvy.co.il/en/blog/wordpress-development/advanced-wordpress-management-wp-cli/
- https://developer.wordpress.org/cli/commands/core/install/

<u>Wordpress users configuration:</u>
- https://developer.wordpress.org/cli/commands/user/create/


<u>Wordpress CLI installation:</u>
- https://www.hostinger.com/fr/tutoriels/wp-cli/

<u>NGINX installation:</u>
- https://blog.stephane-robert.info/docs/services/web/nginx/
- https://www.virtua.cloud/learn/fr/tutorials/installer-nginx-debian-ubuntu
- https://blog.nginx.org/blog/9-tips-for-improving-wordpress-performance-with-nginx
- https://debian-facile.org/atelier:chantier:nginx-mariabd-php-multi-sites-dont-wordpress-plusieurs-versions-de-php
- https://www.ionos.com/digitalguide/hosting/blogs/wordpress-nginx/

<u>NGINX config file:</u>
- https://nginx.org/en/docs/http/configuring_https_servers.html
- https://github.com/nginx/nginx/blob/master/conf/nginx.conf


<u>Adminer installation:</u>
- https://www.adminer.org
- https://www.php.net/manual/en/features.commandline.webserver.php

<u>Website Setup:</u>
- https://stackoverflow.com/questions/51016945/create-a-dockerfile-that-runs-a-python-http-server-to-display-an-html-file

<u>Lazydocker installation:</u>
- https://blog.stephane-robert.info/docs/conteneurs/outils/lazydocker/

<u>Ftp server installation:</u>
- https://oleks.ca/2024/12/07/installation-dun-serveur-ftp-sur-debian-12/


## IA usage
