docker run --rm \
    -v "$PWD":/backup \
    -v gitea_gitea:/data \
    -v gitea_mysql:/var/lib/mysql \
    alpine \
    tar czf /backup/gitea-data.tgz /data /var/lib/mysql
