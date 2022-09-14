# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Things stolen from oh-my-zsh
source $HOME/.zsh_termsupport.zsh
source $HOME/.zsh_key-bindings.zsh
source $HOME/.aliases

# # Legacy oh-my-zsh settings; remove if move to p10k is confirmed permanent
# export ZSH=/home/kontroll/.oh-my-zsh
# ZSH_THEME="agnoster"
# source $ZSH/oh-my-zsh.sh

export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz
export PERL_DESTRUCT_LEVEL=2
export PATH=$HOME/.cargo/bin:$HOME/.scripts:$HOME/go/bin:$PATH
export GOPATH=$HOME/go
export FZF_COMPLETION_TRIGGER=',,'

# Just for some flair, let's add a few colored boxes to new terminals.
# $HOME/.scripts/color
# ./.scripts/Color-Scripts/$(ls .scripts/Color-Scripts/ | shuf -n 1)


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kontroll/random/temp/Google/google-cloud-sdk/path.zsh.inc' ]; then . '/home/kontroll/random/temp/Google/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/kontroll/random/temp/Google/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/kontroll/random/temp/Google/google-cloud-sdk/completion.zsh.inc'; fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
