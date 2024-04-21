function setux --description "set named -U variables as -gx, overriding if necessary"
	for i in $argv
		if set -qU $i
			set -eg $i
			set -gx $i $$i
		end
	end
	:
end
