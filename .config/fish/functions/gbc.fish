function gbc --description="launch fzf to choose a git branch to checkout"
  git checkout (git branch -a | fzf | awk '{gsub("*"," ");print}' | xargs echo)
  # awk trims the asterix (*) from the current branch name
  # 'xargs echo' trims leading/trailing whitespace
end
