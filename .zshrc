export CLICOLOR=1
alias ls="ls --color=auto"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set terminal tab title
function preexec () {
  window_title=""
  process_name="$1"
  if [ "$process_name" = "hx" ] || [ "$process_name" = "hx ." ] || [ "$process_name" = "hx " ]
  then
    process_name="hx"
  elif [ ${process_name:0:2} = "hx" ]
  then
    window_title="\033]0;$process_name\007"
  fi

  if [ -z "$window_title" ]
  then
    parent_dir=$(basename ${PWD%/*})
    window_title="\033]0;$process_name → $parent_dir/${PWD##*/}\007"
  fi

  print -Pn "$window_title"
}

function precmd () {
  parent_dir=$(basename ${PWD%/*})
  window_title="\033]0;$parent_dir/${PWD##*/}\007"
  print -Pn "$window_title"
}

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

export PATH=~/.local/bin:$PATH

source ~/.user_zshrc
export PATH="$HOME/.local/bin/:$PATH"
