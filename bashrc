#!/bin/bash
parse_git_dirty() {
   echo $(git status --porcelain 2> /dev/null | awk '{print $1}'| sort | uniq -c | awk '{if ($2 == "A") {print "" $2 "-" $1 ""} else if ($2 == "M") {print $2 "-" $1 }  else if ($2 == "D") {print "" $2 "-" $1 ""} else if ($2 == "??") {print $2 "-" $1 }}' | sed -e :a -e '$!N; s#\n# | #; ta' | sed -e '1s/^/ [ /' -e '1s/$/ ] /')
}

parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[33m\]\w\[\033[m\]\[\033[34m\]\$(parse_git_branch)\[\033[m\]\[\033[00m\] \$(parse_git_dirty) \$ "
