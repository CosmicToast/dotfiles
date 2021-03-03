set -q __fish_autosource_path
or set __fish_autosource_path $__fish_config_dir/plug

# you must include '' for completions to work
set -q __fish_autosource_exts
or set __fish_autosource_exts .fish ''

function autosource -S -d 'Source plugin'
    for plug in $argv
        for f in $__fish_autosource_path/$plug$__fish_autosource_exts
            if test -f $f -a -r $f
                source $f
                break
            end
        end
    end
end

function __complete_autosource
    for d in $__fish_autosource_path
        set -l len (math (string length $d) + 2) # 1-index + /
        for f in $d/**$__fish_autosource_exts
            if test -f $f -a -r $f
                echo $f | string sub -s $len
            end
        end
    end | sort | uniq
end

complete -c autosource -x -a "(__complete_autosource)"
