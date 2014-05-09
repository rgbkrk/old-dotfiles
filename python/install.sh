if [[ "$(uname)" == Darwin ]]; then
    export STANDARD_LOG_DIR="Library/Logs";
else
    export STANDARD_LOG_DIR=".cache/pip";
fi;

mkdir -p "${HOME}/${STANDARD_LOG_DIR}";

BOOTSTRAP_LOG="${STANDARD_LOG_DIR}/pip-bootstrap.log";

echo "Install log available in '~/${BOOTSTRAP_LOG}'.";
echo "Installing ... ";

download () {
    curl -sO "$@";
}

message () {
    echo "$@";
    echo "$@" >&10;
}

(
    set -x;

    source "${HOME}/.dotfiles/python/python.bash"

    # Just for this subshell.
    export PIP_USER=yes;
    export PIP_UPGRADE=yes;

    message "Downloading pip.";
    download https://raw.github.com/pypa/pip/master/contrib/get-pip.py;
    message "Installing pip.";
    python get-pip.py;
    message "Preparing to upgrade setuptools.";
    # Make sure that if your user site is enabled, you get _recent_ setuptools,
    # without which virtualenvwrapper et. al. will just be horribly broken.
    echo 'import sys; sys.path.insert(0, sitedir)' > \
         "${PYTHON_USER_LIB}/pip-bootstrap.pth";
    message "Upgrading setuptools.";
    pip install setuptools;
    message "Installing wheel.";
    pip install wheel;
    message "Building wheels...";
    message "Building wheel for setuptools.";
    pip wheel setuptools;
    message "Building wheel for virtualenv.";
    pip wheel virtualenv;
    message "Building wheel for virtualenvwrapper.";
    pip wheel virtualenvwrapper;
    message "Installing virtualenv and virtualenvwrapper...";
    pip install virtualenv virtualenvwrapper;
    message "Configuring virtualenvwrapper...";
    source "$(type -p virtualenvwrapper.sh)";
    virtualenvwrapper_initialize;

) 10>&1 > "${HOME}/${BOOTSTRAP_LOG}" 2>&1;

echo "Done. Please enjoy Pip!";

echo "Start a new terminal now to use pip, or hit enter to keep using this one.";
echo "(Pip won't work yet in this one, though.)";
