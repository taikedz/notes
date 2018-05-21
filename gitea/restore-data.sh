docker run --rm \
    -v "$PWD":/backup \
    -v gitea_gitea:/data \
    -v gitea_mysql:/var/lib/mysql \
    alpine \
    tar xzf -C / /backup/gitea-data.tgz
