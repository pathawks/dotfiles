~/Dropbox/Mac\ Tools/base16-tomorrow.light.sh

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if hash mvim 2>/dev/null; then
  export GIT_EDITOR='nvim --noplugin -n'
  export GIT_SEQUENCE_EDITOR="$GIT_EDITOR"
  export EDITOR="nvim"
  export VISUAL="mvim >> /dev/null > /dev/null"
fi

export GIT_AUTHOR_EMAIL="pat@pathawks.com"
export GIT_COMMITTER_EMAIL="pat@pathawks.com"
export EMAIL="pat@pathawks.com"

export GIT_AUTHOR_NAME="Pat Hawks"
export GIT_COMMITTER_NAME="Pat Hawks"

export GIT_PS1_SHOWDIRTYSTATE=1

export CFLAGS="-O3"
export optflags="-O3"

# Make ls use colors
export LSCOLORS="exfxHxdxbxegedabagaHad"
alias ls='ls -FGhx'

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

alias dosbox='open -a /usr/local/bin/dosbox --args -conf "$HOME/Dropbox/Mac Tools/DOSBox.conf"'
alias dosgames='open -a /usr/local/bin/dosbox --args -conf "$HOME/Dropbox/DOS Games/DOSBox.conf"'
alias gitwp='git svn dcommit;git push origin HEAD'
alias lynx="lynx -cfg=$HOME/Dropbox/Mac\ Tools/lynx/lynx.cfg -lss=$HOME/Dropbox/Mac\ Tools/lynx/lynx.lss"
alias gpp='g++-4.9 -Wall -Wextra -Wunused -fdiagnostics-color=auto -Wold-style-cast'
alias gist="git commit -a --allow-empty-message -m ''"
alias swiftc="swiftc -sdk $(xcrun --show-sdk-path --sdk macosx)"
alias vim='mvim'
alias vi='$EDITOR'

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

INPUTRC=$HOME/Dropbox/Mac\ Tools/inputrc
export INPUTRC

set -o vi
