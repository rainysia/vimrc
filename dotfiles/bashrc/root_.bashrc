# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
vman () {
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
                    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
                    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

    # invoke man page
    man $1

    # we muse unset the PAGER, so regular man pager is used afterwards
    unset PAGER
}

if [ `uname` = 'Linux' ]; then
    alias ls=$'ls -XF --color=auto --time-style="+\e[33m[\e[32m%Y-%m-%d \e[35m%k:%M\e[33m]\e[m"'
else
    alias ls='ls -F --color=auto'
fi
export PATH+=:/opt/longene/qq/wine/bin/
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export XIM=ibus
export QT_IM_MODULE=ibus
export XIM_ARGS="ibus-daemon -d -x"
export XDEBUG_CONFIG="idekey=session_name remote_enable=1"
export HISTSIZE=10000
export HISTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PYTHONPATH=~/lib/python
export PATH=~/bin:$PATH
export HGRCPATH=~/.hgrc
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go:$PATH:$GOROOT/bin
export JAVA_HOME=/usr/java/java7
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
#export PATH="/usr/local/lib/cw:$PATH"
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
            tmux rename-window "$*"
            command ssh "$@"
            tmux set-window-option automatic-rename "on" 1>/dev/null
    else
            command ssh "$@"
    fi
}
#parse_git_branch() {
#  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}
#c_1="\[\e[0m\]"
#c0="\[\e[30m\]"
#c1="\[\e[31m\033[1m\]"
#c2="\[\e[32m\033[1m\]"
#c3="\[\e[33m\]"
#c4="\[\e[34m\]"
#c5="\[\e[35m\]"
#c6="\[\e[36m\]"
#c7="\[\e[37m\]"
#PS1="$c2\W $c3(\$(~/.rvm/bin/rvm-prompt v g)) $c1\$(parse_git_branch) $c_1$ "

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"

echo "Welcome!, Today is `date +%Y-%m-%d\ %H:%M:%S`."
echo 
echo "Last three logins:";last `logname`|head -3
echo 
echo "Current users:`users`"
echo "System uptime:";uptime
echo
echo "There are `who|wc -l` userids logged in right now."

source ~/.ssh_tommy
