export EDITOR==micro
export GIT_EDITOR==micro
export LESS='-R --mouse --wheel-lines=4'
export SYSTEMD_LESS="$LESS"
export PAGER='less'

if [[ -z $TERMINFO_DIRS ]]; then
	autoload -Uz autosource
	# maybe others later!
	autosource import-systemd-env
fi
