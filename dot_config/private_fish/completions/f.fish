# f wraps fossil by default
complete -c f -w fossil

# additional subcommands
set -l dcommands (fossil help -a)
set -l paths $PATH/fossil-*
set -l commands (string replace -r '.*fossil-' '' $paths)

if set -q commands[1]
  complete -c fossil -n "not __fish_seen_subcommand_from $dcommands" \
    -a "$commands"
end
