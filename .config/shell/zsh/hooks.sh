function load-nvmrc() {
    local nvmrc_path
    nvmrc_path="$(find-up .nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        [[ "$(which nvm)" == *lazynvm* ]] && lazynvm

        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
            nvm use
        fi
    elif [ -n "$(PWD=$OLDPWD find-up .nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        nvm use default
    fi
}

function load-venv() {
    local venv_path
    venv_path="$(find-up .venv || find-up venv)"

    if [[ -n "${venv_path}" ]] && [[ -z "${VIRTUAL_ENV}" ]]; then
        source "${venv_path}/bin/activate"
    elif [[ -z "${venv_path}" ]] && [[ -n "${VIRTUAL_ENV}" ]]; then
        deactivate
    fi
}

function _chpwd() {
    load-nvmrc
    load-venv
}

chpwd_functions=($chpwd_functions _chpwd)
_chpwd
