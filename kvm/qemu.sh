::() {
    (set -x
        "$@"
    )
}

die() {
    echo "$*"
    exit 1
}

set_system() {
    systems=(
        aarch64
        arm
        x86_64
        i386
    )

    for sys in "${systems[@]}"; do
        chosen_system="qemu-system-$sys"
        if which "$chosen_system" 2>/dev/null ; then
            break
        fi
    done

    [[ -n "$chosen_system" ]] || die "No qemu system found"
}

case "$1" in
disk)
    :: qemu-img create "$1.qcow" "$2"
    ;;
run)
    set_system

    if [[ -n "$2" ]]; then
        cdrom=(-cdrom "$2")
    fi

    :: "$chosen_system" -hda "$1" "${cdrom[@]}" -boot d -m 2G -enable-kvm
    ;;
*)
    echo -e "qemu.sh disk NAME SIZE\n\nqemu.sh run DISKIMAGE [ISOFILE]\n\n"
    ;;
esac
