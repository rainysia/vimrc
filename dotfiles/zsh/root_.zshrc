# Path to your oh-my-zsh installation.
  export ZSH=/root/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git)

# User configuration

  export PATH="/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/longene/qq/wine/bin/:/usr/local/go/bin:/usr/java/java7/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
#alias gno='gnome-open'
alias gno='xdg-open'
alias cdh='cd /home'
alias cdw='cd /home/www/ && su tommy'
alias cdwn='cd /home/www'
alias cdws='cd /home/www/chinasite'
alias cdww='cd /home/www/wordpress && su tommy'
alias cdwhb='cd /home/www/hyve/bom'
alias cdwht='cd /home/www/hyve/testview'
alias cdwhs='cd /home/www/hyve/stress'
alias cdwha='cd /home/www/hyve/agile/'
alias cdwhd='cd /home/www/hyve/DBAPI'
alias cdwk='cd /home/work/'
alias cdu='cd /home/tommy'
alias cdd='cd /home/tommy/Desktop'
alias cdr='cd /'
alias st='su tommy'
alias sr='su - root'
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
alias sshchina='ssh root@192.168.80.135'
alias ssh128='ssh root@128.199.185.120 -D 7070'
alias sss128='sslocal -c /etc/shadowsocks/config.json'
alias sshhp='ssh root@50.23.122.244 -p5647 -D7070'
alias sshjp='sh /home/sh/sshjp.sh'
alias sshcron='ssh applog@10.88.130.31 -D7071'
alias sshgui='ssh root@10.88.132.44 -p22 -D7071'
alias sshwpgit='ssh root@108.168.228.99  -p5647 -D7072'
alias sshwpdev='ssh root@108.168.228.102 -p5647 -D7073'
alias sshwpuat='ssh root@50.97.254.162 -p55990'
alias sshwpprod='ssh root@158.85.218.228 -p5647 -D7075'
alias sshidebian='ssh root@162.253.54.6'
alias nawpgit='echo 108.168.228.99'
# ssgadmin
alias sshhyvedev='ssh root@10.88.85.80'
alias sshhyvelab='ssh tommyx@10.88.85.80'
alias sshhyvepxe='ssh root@10.0.1.62'
alias sshhyvelabcmd='ssh tester@10.88.84.53'
alias sshhyvedbuat='ssh tommyx@10.88.85.17'
alias gvimlog='gvim /var/log/php_errors.log'
alias vimlog='vim /var/log/php_errors.log'
alias taillog='tail -f /var/log/php_errors.log'
alias echolog="echo '' > /var/log/php_errors.log"
alias gvimshell='gvim /home/manual/docs/shell.txt'
alias gvimhyve='gvim /home/manual/docs/hyve.txt'
alias gvimvimrc='gvim /etc/vim/vimrc'
alias delpyc='find -name "*.pyc" | xargs "rm"'
alias systart='sh /home/sh/start_debian.sh'

alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
export EDITOR=vim
