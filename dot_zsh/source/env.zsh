export EDITOR==micro
export GIT_EDITOR==micro
export PAGER='less -R'

if [[ -z $TERMINFO_DIRS ]]; then
	autoload -Uz autosource
	# maybe others later!
	autosource import-systemd-env
fi
