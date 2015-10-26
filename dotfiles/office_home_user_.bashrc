# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    #We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls --color=auto'
   #alias dir='dir --color=auto'
   #alias vdir='vdir --color=auto'

   #alias grep='grep --color=auto'
   #alias fgrep='fgrep --color=auto'
   #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias as='aptitude search'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias u2g='iconv -f UTF-8 -t GBK'
alias g2u='iconv -f GBK -t UTF-8'
alias la='ls -AF --color=auto'
alias ll='ls -lF --color=auto'
alias lm='ls -F --color=auto |more'
alias lslrt='ls -lrt'
alias lslrha='ls -lrta'
alias lslrth='ls -lrth'
alias lslrtha='ls -lrtha'
alias lslrthai='ls -lrtha --ignore="*.pyc"'
alias ..='cd ..'
alias ....='cd ../..'
alias dh='df -hT'
alias h='history'
alias gv='gvim'
alias gno='xdg-open'
alias cdh='cd /home'
alias cdw='cd /home/www'
alias cdws='cd /home/www/chinasite'
alias cdww='cd /home/www/wordpress'
alias cdwh='cd /home/www/domain'
alias cdwhb='cd /home/www/domain/bom'
alias cdwht='cd /home/www/domain/testview'
alias cdwhs='cd /home/www/domain/stress'
alias cdwha='cd /home/www/domain/agile'
alias cdwhd='cd /home/www/domain/DBAPI'
alias cdwk='cd /home/work/'
alias cdu='cd /home/tommy'
alias cdd='cd /home/tommy/Desktop'
alias cdr='cd /'
alias st='su tommy'
alias sr='su -'
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
alias pythonpy='python /home/softs/linux/goagent/local/proxy.py'
alias cdwc='cd /home/www/c/'
alias cdwr='cd /home/www/ruby/'
alias cdwg='cd /home/www/go/'
alias cdwn='cd /home/www/node/'
alias cdwpy='cd /home/www/python/'
alias cdwph='cd /home/www/php/'
alias cdm='cd /home/manual/'
alias cdg='cd /home/vc/git/'

alias shl='sh /home/sh/log.sh'
alias gvimlog='gvim /var/log/php_errors.log'
alias vimlog='vim /var/log/php_errors.log'
alias taillog='tail -f /var/log/php_errors.log'
alias echolog="echo '' > /var/log/php_errors.log"
alias gvimshell='gvim /home/manual/docs/shell.txt'
alias gvimdomain='gvim /home/manual/docs/domain.txt'
alias gvimvimrc='gvim /etc/vim/vimrc'
alias delpyc='find -name "*.pyc" | xargs "rm"'

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export XIM=ibus
export QT_IM_MODULE=ibus
export XIM_ARGS="ibus-daemon -d -x"
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go:$PATH:$GOROOT/bin
export JAVA_HOME=/usr/java/java7
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export WORKON_HOME=$HOME/.virtualenv
source /usr/local/bin/virtualenvwrapper.sh
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
            tmux rename-window "$*"
            command ssh "$@"
            tmux set-window-option automatic-rename "on" 1>/dev/null
    else
            command ssh "$@"
    fi
}
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ "$TERM"=="xterm" ]; then
    export TERM=xterm-256color
fi

alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
#export PATH="/usr/local/lib/cw:$PATH"

#export PS1="\t \u@\h (\w) [\!]$"
echo "Welcome!, Today is `date`."
echo 
echo "Last three logins:";last `logname`|head -3
echo 
echo "Current users:`users`"
echo "System uptime:";uptime
echo
echo "There are `who|wc -l` userids logged in right now."
export EDITOR=vim
export PAGER=less
export LESS='CFMS'
