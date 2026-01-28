#!/usr/bin/env sh
#
# This shell script installs and configures this repository onto a system by
# cloning it, modifying some local configurations, and moving the Git metadata.
# It should be individually downloaded with a command-line tool (e.g. cURL) and
# either piped to a shell or manually invoked. For example:
#   - curl -fsSL "<url_to_install.sh>" | sh
#   - curl -fsSLO "<url_to_install.sh>" && chmod +x install.sh && ./install.sh
#
# jstnsun

# Variables used throughout the script.
_remoterepo="https://github.com/jstnsun/.linux"
_verbose=""
_location="dotfiles.git"

# Prints this script's help message.
help() {
    printf "Usage: %s [-h] [-v]\n" "$(basename -- "$0")"
    printf "Installs and formats the repository this script is located in.\n"
    printf "It should NOT be run once the repository is locally setup.\n"
    printf "\n"
    printf "    -h  print this message and exit\n"
    printf "    -v  explain every operation as they occur\n"
}

# Moves the contents of .git into the repository itself and prints some aliases.
cleanup() {
    if [ $# -ne 0 ]; then
        printf "Error: \`cleanup\` requires 0 arguments.\n" 1>&2
        exit 2
    fi

    [ -n "$_verbose" ] && printf "Moving Git metadata...\n"
    set -- -i .git/* "."
    [ -n "$_verbose" ] && set -- "-v" "$@"
    mv "$@" || exit $?
    set -- ".git"
    [ -n "$_verbose" ] && set -- "-v" "$@"
    rmdir "$@" || exit $?

    printf "Installed dotfiles to %s! I recommend using the following:\n" "$_location"
    printf "alias dotfiles-cfg=\"git --git-dir=%s --work-tree=\$HOME\"\n" "$PWD"
    printf "alias dotfiles-rtt=\"git --git-dir=%s --work-tree=/\"\n" "$PWD"
    printf "alias dotfiles-dir=\"git --git-dir=%s --work-tree=%s\"\n" "$PWD" "$PWD"
}

# Clones the repository and modifys some local repository configuration.
install_repo() {
    if [ $# -ne 0 ]; then
        printf "Error: \`install_repo\` requires 0 arguments.\n" 1>&2
        exit 2
    fi

    if [ -d "$_location" ]; then
        printf "Error: %s already exists.\n" "$_location" 1>&2
        exit 2
    fi

    if ! command -v git >/dev/null 2>&1; then
        printf "Error: \`git\` is either not installed or not on \$PATH.\n" 1>&2
        exit 1
    fi

    [ -n "$_verbose" ] && printf "Cloning the repository...\n"
    git clone -q "$_remoterepo" "$_location" || exit $?
    cd "$_location" || exit $?

    [ -n "$_verbose" ] && printf "Modifying local configurations...\n"
    set -- config --local core.bare true
    git "$@" || printf "Failed to set the bare repository flag.\n" 1>&2
    set -- config --local status.showUntrackedFiles no
    git "$@" || printf "Failed to hide untracked files.\n" 1>&2
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
    install_repo || exit $?
    cleanup || exit $?
    exit 0
}

main "$@"
