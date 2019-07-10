#!/bin/bash
parse_git_dirty() {
  GIT_STATUS=$(git status 2> /dev/null | tail -n1)
  GIT_CLEAN="nothing to commit, working tree clean"
    if [ "$GIT_STATUS" != "nothing to commit, working tree clean" ]; then
      echo -e "\\033[1;31m*\\033[0m"
    fi
  }

  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1'$(parse_git_dirty)')/'
  }
  #export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)
  export PS1="\[\033[33m\]\w\[\033[m\]\$(parse_git_branch)\[\033[00m\] $ "
