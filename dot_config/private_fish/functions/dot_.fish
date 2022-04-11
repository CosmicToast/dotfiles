function . -a name
    if ! test -n "$name"; return 255; end
    set -e argv[1]
    for path in . $PATH
        if test -r $path/$name.fish
            source $path/$name.fish $argv
            return
        else if test -r $path/$name
            source $path/$name $argv
            return
        end
    end
end
