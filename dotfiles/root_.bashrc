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
alias cdw='cd /home/www/ && su tommy'
alias cdws='cd /home/www/chinasite'
alias cdww='cd /home/www/wordpress && su tommy'
alias cdwn='cd /home/www/'
alias cdhs='cd /home/hyve/test_engbom && su tommy'
alias cdu='cd /home/tommy'
alias cdd='cd /home/tommy/Desktop'
alias cdr='cd /'
alias cdc='cd /home/c/'
alias cdv='cd /home/vc/'
alias st='su tommy'
alias sr='su - root'
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
alias cdg='cd /home/vc/git/'
alias pythonpy='python /home/softs/linux/goagent/local/proxy.py'
alias cdrb='cd /home/ruby/'
alias cdgo='cd /home/go/'
alias cdn='cd /home/node/'
alias cdm='cd /home/manual/'
alias cds='cd /home/work/'
alias cdp='cd /home/python/'
alias cda='cd /home/hyve/bom/agile/'
alias shl='sh /home/sh/log.sh'
alias ssh128='sh /home/sh/ssh.sh'
alias sss128='ss-local -c /etc/shadowsocks-libev/config.json'
alias sshjp='sh /home/sh/sshjp.sh'
alias gvimlog='gvim /var/log/php_errors.log'
alias vimlog='vim /var/log/php_errors.log'
alias taillog='tail -f /var/log/php_errors.log'
alias echolog="echo '' > /var/log/php_errors.log"
alias gvimshell='gvim /home/manual/docs/shell.txt'
alias gvimhyve='gvim /home/manual/docs/hyve.txt'
alias gvimvimrc='gvim /etc/vim/vimrc'
alias delpyc='find -name "*.pyc" | xargs "rm"'
alias systart='sh /home/sh/start_debian.sh'
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

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
