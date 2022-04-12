# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/kontroll/.oh-my-zsh

export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz
export PERL_DESTRUCT_LEVEL=2

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias sudo="sudo "
alias skw="sudo killwine -9"
alias stats="s-tui"
alias ilogout="i3-msg exit"
alias powertune="powertop --auto-tune"
#alias ls="ls --color=tty --group-directories-first"
#alias batstats="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias batstats="upower -i /org/freedesktop/UPower/devices/battery_BAT0 && upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias lastinstalled="expac --timefmt='%F %T' '%l %n' | sort -n"
#alias yyyyclip="xclip -selection c"
alias moff="xset dpms force off"
alias open="xdg-open"
alias orphans="sudo pacman -Qtdq"
alias tomato="tty-clock-tomato"
alias pomato="python $HOME/Documents/Code/Pomato/pomato.py"
alias qc="python ~/quickcell/src/quickcell.py"
alias banner="toilet -f smmono12"
alias bannerp="toilet -f pagga"
#alias font="fontpreview --preview-text abcdefghijklmnopqrstuvwxyzåäö ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ 0123456789" #.:;\(*!?\'/\'\"£$€&\)'"
#alias pdf="open \"$(locate '/home/kontroll' | grep '\.pdf$' | fzf)\"'"
alias yt="ytfzf -t"

# Replace some common utilities with beefier cousins
#alias ls="lsd --group-dirs first "
alias ls="exa --group-directories-first"
alias l="ls -l"
alias ll="ls -la"
# alias cat="bat"
# alias cd="builtin cd $@ && ls"
alias pcp="rsync -ah --progress"

alias rgt="rg -g '*.{org,txt}'"

# Sane "defaults" for commands
alias df="df -h"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias mg="mg -n"



### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

pdf() {
    #[[ ! -z $1 ]] && $_knt_fzfQ="-q \"$1\""
    local target_file
    target_file="$(locate '/home/kontroll' | grep '\.pdf$' | fzf --reverse $([[ ! -z $1 ]] && echo -q "$1"))"
    [[ ! -z $target_file ]] && open $target_file & bg
    #open "$(locate '/home/kontroll' | grep '\.pdf$' | fzf $([[ ! -z $1 ]] && echo -q "$1"))"
}

weather(){
  curl -s "wttr.in/$1" | head -n 37
}

fancy-ctrl-z() {
    emulate -LR zsh
    if [[ $BUFFER -eq 0 ]]; then
	bg
	zle redisplay
    else
	zle push-input
    fi
}
zle -N fancy-ctrl-z
bindkey '^z'    fancy-ctrl-z
# bindkey -s '^\b'   " cd ..\n"

function set_win_title(){
    echo -ne "\033]0; schweinehund $PWD \007"
    }

############################
# File system movement stuff
cd() {
    if [[ $1 = - ]]; then
	builtin cd "$OLDPWD" || return 1
    else
	builtin cd "$@" || return 1
    fi

    if [[ ! $1 = "" ]]; then
        l
    fi
}

k() {
#   [[ -z $1 ]] && echo "No path alias specified. Usage: k ALIAS" && ls ~/.scripts/paths/ && return 1
    [[ -z $1 ]] && cd "$(cat ~/.scripts/paths/$(ls ~/.scripts/paths/ | fzf))" && return 0
    [[ ! -f ~/.scripts/paths/$1 ]] && echo "No such path alias." && return 1

    cd "$(cat ~/.scripts/paths/$1)"
}

countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

stopwatch(){
  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
}

latest(){
  echo $(ls | tail -n 1)
}

mcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

alias cl=". cl"
alias cr=". cr"

############################
# systemctl aliases
alias start="systemctl start"
alias stop="systemctl stop"
alias status="systemctl status"

pcat(){
    which $1 | xargs cat
}

bannerrain(){
    #echo $@ | tr "[:lower:]" "[:upper:]" | tr "[:space:]" "\n" | bannerp
    echo $@ | fold -s -w15 | banner --rainbow
    #bannertext=$(echo $@ | tr "[:lower:]" "[:upper:]")
    #echo $bannertext
 #   bannerp $bannertext
}

bannermono(){
     echo $@ | fold -s -w15 | banner
}

bannerrain-clear(){
    clear && (bannerrain $@) && read -n 1
}

bannermono-clear(){
    clear && (bannermono $@) && read -n 1
}

function yta() {
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

#LS_COLORS=$LS_COLORS:'di=1;4;36:'
# if [ -n "$DISPLAY" ]; then
#   export BROWSER=vivaldi-stable
# else
#   export BROWSER=links
# fi

export PATH=$HOME/.cargo/bin:$HOME/.scripts:$HOME/go/bin:$PATH
export GOPATH=$HOME/go
export FZF_COMPLETION_TRIGGER=',,'

# Just for some flair, let's add a few colored boxes to new terminals.
# $HOME/.scripts/color
#cat "\n" " " $HOME/todo "\n"
# paleofetch
# ./.scripts/Color-Scripts/$(ls .scripts/Color-Scripts/ | shuf -n 1)
#ls

# precmd_functions+=(set_win_title)
# eval "$(starship init zsh)"






