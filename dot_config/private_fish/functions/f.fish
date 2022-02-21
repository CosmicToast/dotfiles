function f --wraps=fossil
  set -l maybecmd fossil-$argv[1]
  if type -q $maybecmd;
    set -e argv[1];
    $maybecmd $argv;
  else
    fossil $argv;
  end
end
