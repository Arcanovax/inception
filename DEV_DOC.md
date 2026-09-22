# Set up

## Prerequisites

Before starting the project, make sure the following tools are installed:

- Docker
- Docker Compose
- Make

The project is designed to run inside Docker containers, so no additional installation of MariaDB, WordPress, Nginx, or Redis is required on the host machine.

## Environment file

Create a `.env` file containing all these keys
```properties
DOMAIN_NAME= # Domain name
MYSQL_USER= # MySQL user name

DB_NAME= # Name of the mariadb database
DB_PASSWORD= # Password of the mariadb database
DB_USER= # User of the mariadb database

WP_TITLE = # Title of the Wordpress
WP_ADMIN_USER = # Name of the Admin user of Wordpress
WP_ADMIN_PASSWORD = # Password of the Admin user of Wordpress
WP_ADMIN_EMAIL = # Email of the Admin user of Wordpress
WP_USER = # Name of the user of Wordpress
WP_USER_PASSWORD=# Password of the user of Wordpress
WP_USER_EMAIL= # Email of the user of Wordpress
```

A sample `.env` file is provided at the root of the repository.

## Volumes paths

The MariaDB and WordPress data volumes are stored by default in:

```
/home/mthetcha/data/mariadb
/home/mthetcha/data/wordpress
```

These paths can be changed in the `Makefile` if necessary.

# Build and Launch

The project uses a `Makefile` to simplify the management of the Docker environment.

To create the required volume directories and start all containers in the background:

```bash
make up
```

To rebuild the Docker images and start the containers:
```bash
make build
```

## Access the services

Once the containers are running, the following services are available:

Adminer:
```bash
mthetcha.42.fr:8000
```

Static website:
```bash
mthetcha.42.fr:7000
```

Lazydocker CLI:
```bash
docker attach lazydocker
```

# Management

The `Makefile` provides several commands to manage the Docker environment.

### Stop the containers:
```
make down
```

This stops and removes the containers without removing the volumes.


### Remove containers and volumes:

```
make clean
```

This stops and removes the containers as well as the Docker Compose volumes.

### Completely clean the environment
```
make fclean
```
This performs a complete cleanup of the Docker environment.

This command:

- Removes all containers and volumes.
- Removes all Docker images.
- Removes unused Docker resources.
- Removes the project's persistent data directories.

The data directories removed by this command are:
```
/home/mthetcha/data/mariadb
/home/mthetcha/data/wordpress
```

### Lazydocker:

**Lazydocker** can also be use to check the status of **containers**, **images** and **volumes**.

# Project Data and Persistence

The project uses Docker volumes to persist the data of **MariaDB** and **WordPress**.

The volume directories are defined by the following variable in the `Makefile`.
The Makefile automatically creates the required directories with:
```
make volumes
```

They are mounted inside the WordPress and MariaDB containers at `/var/www/html`

This allows the data to **persist** even when the containers are stopped or recreated.