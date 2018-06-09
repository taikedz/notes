archivef="$(basename "${1:-gitea-data.tgz}")"

if [[ -f "./$archivef" ]]; then
	read -p "Overwrite ./$archivef ? y/N> "
	[[ "$REPLY" =~ ^(y|Y|yes|YES)$ ]] || {
		echo Abort
		exit 1
	}
	mv "$archivef" "${archivef}-old"
fi

docker run --rm \
    -v "$PWD":/backup \
    -v gitea_gitea:/data \
    -v gitea_mysql:/var/lib/mysql \
    alpine \
    tar czf "/backup/$archivef" /data /var/lib/mysql

[[ -f "${archivef-old}" ]] && rm "${archivef}-old" -f
