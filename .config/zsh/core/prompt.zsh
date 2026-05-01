# prompt.zsh
#
# Prompt configuration file for the Z shell (zsh), using Powerlevel10k.
# See https://github.com/romkatv/powerlevel10k for more information.
#
# jstnsun

# Determine if Powerlevel10k is installed, otherwise use fallback prompt.
setup () {
    local p10k_base="${ZDEPENDDIR}/powerlevel10k/powerlevel10k.zsh-theme"
    local p10k_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    local fallback='%F{242}╭── %F{39}%n@%F{212}%m %F{79}%B%~%f%b'$'\n''%F{242}╰─%(?.%F{70}.%F{160})#%f '

    [[ ! -f "$p10k_base" ]] && PROMPT="$fallback" && return 1
    [[ -r "$p10k_cache" ]] && source "$p10k_cache"
    source "$p10k_base"
}
setup || return

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

# Configure Powerlevel10k options.
() {
    emulate -L zsh -o extended_glob
    unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
    [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

    # Enable terminal-shell integration with kitty.
    typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true
    # Disable transient prompt (i.e., don't condense prompt after commands).
    typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
    # Enable instant prompt and print a warning if console output is detected.
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
    # Disable hot reload for performance benefits.
    typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
    # Defines the character set used by Powerlevel10k.
    typeset -g POWERLEVEL9K_MODE=nerdfont-v3
    # Add extra icon padding for non-monospace fonts.
    typeset -g POWERLEVEL9K_ICON_PADDING=moderate

    # Basic style options that define the overall look of the prompt.
    typeset -g POWERLEVEL9K_BACKGROUND=
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
    # Have icons appear before content on both sides of the prompt.
    typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true
    # Do not add an empty line before each prompt.
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

    # Connect multiline prompt lines with these symbols.
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%242F╭──'
    typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%242F├─'
    typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%242F╰─'
    # Symbols to be used on the both sides of the prompt.
    typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=' '
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=

    # Segments to be shown on the left (in left-to-right order).
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
        context
        dir
        vcs
        newline
        prompt_char
    )

    # Segments to be shown on the right (in left-to-right order).
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        status
        command_execution_time
        background_jobs
        virtualenv
        time
    )

    # [ context: user@hostname ]
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=196
    typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=180
    typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=39
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%F{212}%m%f'
    typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%F{212}%m%f'
    typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%F{212}%m%f'

    # [ dir: current directory ]
    typeset -g POWERLEVEL9K_DIR_FOREGROUND=79
    typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=47
    typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=83
    typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
    local anchor_files=(
        .bzr
        .citc
        .hg
        .git
        .go-version
        .java-version
        .lua-version
        .node-version
        .perl-version
        .php-version
        .python-version
        .ruby-version
        .svn
        .terraform
        .tool-versions
        CVS
        Cargo.toml
        composer.json
        go.mod
        package.json
        stack.yaml
    )
    typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
    typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=''
    typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
    typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER="first"
    typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
    typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
    typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
    typeset -g POWERLEVEL9K_DIR_HYPERLINK=true
    typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

    # [ vcs: git status ]
    typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uE0A0 '
    typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=76
    typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=244
    typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
    typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=76
    typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178

    # Example output: master wip ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
    # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
    function my_git_formatter() {
        emulate -L zsh

        if [[ -n $P9K_CONTENT ]]; then
            typeset -g my_git_format=$P9K_CONTENT
            return
        fi

        if (( $1 )); then
            # Styling for up-to-date Git status.
            local       meta='%f'
            local      clean='%76F'
            local   modified='%178F'
            local  untracked='%39F'
            local conflicted='%196F'
        else
            # Styling for incomplete and stale Git status.
            local       meta='%244F'
            local      clean='%244F'
            local   modified='%244F'
            local  untracked='%244F'
            local conflicted='%244F'
        fi

        local res

        if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
            local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
            (( $#branch > 32 )) && branch[13,-13]="…"
            res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
        fi

        if [[ -n $VCS_STATUS_TAG && -z $VCS_STATUS_LOCAL_BRANCH ]]; then
            local tag=${(V)VCS_STATUS_TAG}
            (( $#tag > 32 )) && tag[13,-13]="…"
            res+="${meta}#${clean}${tag//\%/%%}"
        fi

        [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"
        if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
            res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
        fi
        if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
            res+=" ${modified}wip"
        fi
        if (( VCS_STATUS_COMMITS_AHEAD || VCS_STATUS_COMMITS_BEHIND )); then
            (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
            (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
            (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
        elif [[ -n $VCS_STATUS_REMOTE_BRANCH ]]; then
            # res+=" ${clean}="
        fi

        (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
        (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
        (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
        (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
        [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
        (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
        (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
        (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
        (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"
        (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

        typeset -g my_git_format=$res
    }
    functions -M my_git_formatter 2>/dev/null

    typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
    typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
    typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
    typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
    typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
    typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

    # [ prompt_char: prompt symbol ]
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=

    # [ status: exit code of the last command ]
    typeset -g POWERLEVEL9K_STATUS_OK=false
    typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=70
    typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION=
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=70
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION=
    typeset -g POWERLEVEL9K_STATUS_ERROR=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=160
    typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION=
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=160
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION=
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=160
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION=
    typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
    typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=true

    # [ command_execution_time: duration of the last command ]
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=184
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=

    # [ background_jobs: presence of background jobs ]
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=240
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

    # [ virtualenv: python virtual environment (venv) ]
    typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=37
    typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
    typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
    typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

    # [ time: current time ]
    typeset -g POWERLEVEL9K_TIME_FOREGROUND=159
    typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
    typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
    typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=

    # If p10k is already loaded, reload configuration.
    (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
