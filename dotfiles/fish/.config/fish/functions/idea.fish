function idea
  if set -q argv[1]
    command idea $argv;
  else
    command idea .
  end
end

