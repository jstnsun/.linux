#!/usr/bin/env sh
#
# This shell script unpacks all the contents of this repository to their
# actual, appropriate system location, mapped as follows:
#   - .dir/ && .file contents -> $HOME
#   - dir/           contents -> /
#   - file           contents -> $REPO (remain in this repository)
# A backup is created for any existing content that may be overwritten.
#
# jstnsun

# Variables used throughout the script.
_verbose=""
_location="./"

# Prints this script's help message.
help() {
    printf "Usage: %s [-h] [-v]\n" "$(basename -- "$0")"
    printf "Unpacks configurations to their appropriate system location.\n"
    printf "Backups are created for configurations that may be overwritten.\n"
    printf "\n"
    printf "    -h  print this message and exit\n"
    printf "    -v  explain every operation as they occur\n"
}

# Removes empty directories from the repository.
cleanup() {
    if [ $# -ne 0 ]; then
        printf "Error: \`cleanup\` requires 0 arguments.\n" 1>&2
        exit 2
    fi

    set -- -empty -delete
    [ -n "$_verbose" ] && printf "Cleaning up empty directories...\n"
    [ -n "$_verbose" ] && set -- "$@" "-print"
    find . -type d \
    ! -path "./hooks/*" \
    ! -path "./info/*" \
    ! -path "./logs/*" \
    ! -path "./objects/*" \
    ! -path "./refs/*" \
    "$@"
    [ -n "$_verbose" ] && printf "Cleaned up empty directories!\n"
}

# Determines the appropriate system location for a given configuration.
get_location() {
    if [ $# -ne 1 ]; then
        printf "Error: \`get_location\` requires 1 argument.\n" 1>&2
        exit 2
    fi

    case "$1" in
        .*)  _location="$HOME/" ;;
        */*) _location="/"      ;;
        *)   _location="./"     ;;
    esac
}

# Moves all configurations to their appropriate system location.
unpack_configs() {
    if [ $# -ne 0 ]; then
        printf "Error: \`unpack_configs\` requires 0 arguments.\n" 1>&2
        exit 2
    fi

    [ -n "$_verbose" ] && printf "Unpacking configurations...\n"
    find . -type f \
    ! -path "./hooks/*" \
    ! -path "./info/*" \
    ! -path "./logs/*" \
    ! -path "./objects/*" \
    ! -path "./refs/*" \
    | while IFS= read -r filepath; do

        fmt_filepath="${filepath#./}"
        get_location "$fmt_filepath"

        if [ "$_location" != "./" ]; then
            [ -n "$_verbose" ] && printf "Found filepath: %s\n" "$filepath"
            [ -n "$_verbose" ] && printf "Formatted filepath: %s\n" "$fmt_filepath"

            rel_dir="$(dirname -- "$fmt_filepath")"
            abs_dir="$_location$rel_dir"
            [ -n "$_verbose" ] && printf "Target directory: %s\n" "$abs_dir"

            elevate=""; [ "$_location" = "/" ] && elevate="sudo"

            set -- -pv -- "$abs_dir"
            $elevate mkdir "$@" < /dev/tty || exit $?

            set -- -iv --target-directory="$abs_dir" --backup=existing --suffix=.bak "$filepath"
            $elevate mv "$@" < /dev/tty || exit $?

            printf "\n"
        fi
    done
    [ -n "$_verbose" ] && printf "Unpacked configurations!\n"
}

# Parses script arguments. See help() for all valid arguments and meanings.
parse_args() {
    while getopts ":hv" opt; do
        case "$opt" in
            h)
                help
                exit 0
                ;;
            v)
                _verbose="-v"
                ;;
            :)
                printf "option %s missing argument.\n" "$OPTARG" 1>&2
                exit 1
                ;;
            ?)
                printf "invalid option %s.\n" "$OPTARG" 1>&2
                exit 1
                ;;
        esac
    done
}

main() {
    parse_args "$@"
    cd "$(dirname -- "$0")" || exit $?
    unpack_configs || exit $?
    cleanup || exit $?
    exit 0
}

main "$@"
