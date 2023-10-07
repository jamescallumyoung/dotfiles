function webs
  if set -q argv[1]
    webstorm $argv;
  else
    webstorm .
  end
end
