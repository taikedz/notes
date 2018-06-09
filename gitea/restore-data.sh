# In order to use this properly:
#
# 	docker-compose down
# 	docker volume rm gitea_gitea gitea_mysql
#
# 	docker-compose up --no-start
# 	./restore.sh [ARCHVIEFILE]
# 	docker-compose up -d

archivef="$(basename "${1:-gitea-data.tgz}")"

[[ -f "$archivef" ]] || {
	echo "No such file ./$archivef"
	exit 1
}

docker run --rm \
    -v "$PWD":/backup \
    -v gitea_gitea:/data \
    -v gitea_mysql:/var/lib/mysql \
    alpine \
    tar xz -C / -f "/backup/$archivef"
