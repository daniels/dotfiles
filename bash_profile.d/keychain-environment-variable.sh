if [ "$( uname )" = "Darwin" ]; then

    # Functions for setting and getting environment variables from the OSX keychain
    #
    # Credit:
    #   - https://www.netmeister.org/blog/keychain-passwords.html
    #   - https://gist.github.com/bmhatfield/f613c10e360b4f27033761bbee4404fd

    function __keychain-path() {
        local keychain="${1}"

        local keychain_path="${keychain:+${HOME}/Library/Keychains/${keychain}.keychain-db}"

        [ -z "${keychain_path}" ] || [ -f "${keychain_path}" ] || {
            echo >&2 "Keychain '${keychain}' not found at '${keychain_path}'"
            return 1
        }

        echo "${keychain_path}"
    }

    # Use: keychain-environment-variable ENV_VAR_NAME [keychain_name]
    function keychain-environment-variable () {
        local variable="${1:?Missing environment variable name}"
        local keychain_name="${2:-${ENV_VAR_KEYCHAIN:-login}}"

        local keychain_path;
        keychain_path="$(__keychain-path ${keychain_name})" || return 1

        security find-generic-password -w -a "${USER}" -D "environment variable" -s "${variable}" "${keychain_path}"
    }

    # Use: set-keychain-environment-variable ENV_VAR_NAME [keychain_name]
    #   provide: super_secret_key_abc123
    function set-keychain-environment-variable () {
        local variable="${1:?Missing environment variable name}"
        local keychain_name="${2:-${ENV_VAR_KEYCHAIN:-login}}"

        local keychain_path;
        keychain_path="$(__keychain-path ${keychain_name})" || return 1

        read -srp "Enter value for '${variable}': " value
        echo
        : "${value:?No value given}"
        security add-generic-password -U -a "${USER}" -D "environment variable" -s "${variable}" -w "${value}" "${keychain_path}"
    }
fi
