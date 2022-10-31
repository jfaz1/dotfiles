export CLICOLOR=1
alias ls="ls --color=auto"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/c/Users/josef/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set terminal tab title
function preexec () {
  process_name="$1"
  if [ ${process_name:0:2} = "hx" ]; then
    process_name="hx"
  fi
  window_title="\033]0;$process_name → ${PWD##*/}\007"
  print -Pn "$window_title"
}

function precmd () {
  $() # this makes it refresh the first time for some reason
  window_title="\033]0;${PWD##*/}\007"
  print -Pn "$window_title"
}

source ~/.user_zshrc
