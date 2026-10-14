VOLUMES = /home/mthetcha/data/mariadb /home/mthetcha/data/wordpress
ENV_FILE = srcs/.env
REQUIRED_VARS = DOMAIN_NAME MYSQL_USER \
				DB_NAME DB_PASSWORD DB_USER \
				WP_TITLE \
				WP_ADMIN_USER WP_ADMIN_PASSWORD WP_ADMIN_EMAIL \
				WP_USER WP_USER_PASSWORD WP_USER_EMAIL \
				FTP_USER FTP_PASSWORD

default: up

up: volumes check_env
	docker compose -f srcs/compose.yaml up -d

build: volumes check_env
	docker compose -f srcs/compose.yaml up --build -d

volumes:
	mkdir -p $(VOLUMES)

check_env:
	@test -f $(ENV_FILE) || { echo "No env file"; exit 1; }
	@for var in $(REQUIRED_VARS); do \
		grep -Eq "^$$var=.+" $(ENV_FILE) || { echo "$$var is not defined"; exit 1; }; \
	done

down :
	docker compose -f ./srcs/compose.yaml down

clean:
	docker compose -f ./srcs/compose.yaml down -v

fclean: clean
	-docker rmi -f $$(docker images -qa) 2>/dev/null || true
	-docker system prune -a --volumes -f 2>/dev/null || true
	sudo rm -rf $(VOLUMES)

kvm:
	qemu-system-x86_64 \
	-enable-kvm \
	-m 3G \
	-smp 2 \
	-cpu host \
	-hda /sgoinfre/mthetcha/vm-disk.qcow2 \
	-daemonize \
	-netdev user,id=net0,hostfwd=tcp::2222-:22 \
	-device virtio-net-pci,netdev=net0 \
	-monitor tcp:127.0.0.1:4444,server,nowait \

ssh:
	ssh -p 2222 mthetcha@127.0.0.1
