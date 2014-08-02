# Some Docker utilities
# Credits:
#   - http://kartar.net/2014/03/some-useful-docker-bash-functions-and-aliases/

# Get the IP address of a running container
#   Usage:
#   $ dip 72bbff4d768c
#   172.17.0.3
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Remove "all" containers
drm() { docker rm $(docker ps -q -a); }

# Remove "all" images
dri() { docker rmi $(docker images -q); }

# Run a daemonized container, damn the ports
#   Usage: dgo rgbkrk/301inabox
alias dgo="docker run -d -P"

# Run an interactive container, damn the ports
#   Usage: dgoi ipython/notebook
alias dgoi="docker run -t -i -P"
