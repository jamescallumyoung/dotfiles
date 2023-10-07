function glug --description="git log with graph, decorations, oneline, excluding tags"
 git log --oneline --decorate=short --decorate-refs-exclude="refs/tags/" --graph $args;
end
