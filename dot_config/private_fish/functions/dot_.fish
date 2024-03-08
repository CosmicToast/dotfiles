function . -a name
    if ! test -n "$name"; return 255; end
    set -e argv[1]

    # handle real paths
    if    string match -q   '/*' $name
       or string match -q  './*' $name
       or string match -q '../*' $name
        source $name $argv
    end

    set -q DOTPATH || set -l DOTPATH $PATH
    for path in $DOTPATH
        if test -r $path/$name.fish
            source $path/$name.fish $argv
            return
        else if test -r $path/$name
            source $path/$name $argv
            return
        end
    end
end
