function gbdel --description="Interactively delete Git branches"
  git branch -D (git branch | fzf | string trim)
end

