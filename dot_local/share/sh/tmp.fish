. hascmd mktemp || return
function t
	mkdir -p /tmp/t
	cd /tmp/t
end
function tt
	set -l dir (mktemp -d)
	test -d $dir || return 1
	cd $dir
	trap "rm -r '$dir'" EXIT
end
