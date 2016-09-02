" 0 => Author {{{
"========================================================================
" * For vim Configuration file

" * VIM 7.4

" * @filename   vimrc
" * @author     Rainy Sia <rainysia@gmail.com>
" * @copyright  2013-2016 BTROOT.ORG
" * @license    https://opensource.org/licenses/MIT license
" * @version    GIT: 7.09.08
" * @createTime 2008-04-01 02:14:55
" * @lastChange 2016-08-09 02:28:27

" * @link http://www.btroot.org
"========================================================================
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 => System Configure {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{                                         " work in linux, echo &rtp
if has("unix")
    if system('uname') =~ "Darwin"
        let $VIMRUNTIME="/usr/share/vim/vim73"
        set runtimepath=/usr/share/vim/vim73,~/.vim,~/.vim/after,~/.vim/bundle/vim-snipmate/after
    else
        let $VIMRUNTIME="/usr/share/vim/vim74"
        set runtimepath=/usr/share/vim/vim74,~/.vim,~/.vim/after,~/.vim/bundle/vim-snipmate/after
    endif
elseif has("win32")
    let $VIMRUNTIME="~/vim74"
    set runtimepath=~/vim74,~/.vim,~/.vim/after,~/.vim/bundle/vim-snipmate/after
else
    let $VIMRUNTIME="/usr/share/vim/vim74"
    set runtimepath=/usr/share/vim/vim74,~/.vim,~/.vim/after,~/.vim/bundle/vim-snipmate/after
endif
"}}
set nocp                                    " close compeletion with vi
set helplang=cn                             " 帮助菜单
set history=1000                            " 设置history文件记录的行数
set confirm                                 " 处理为保存或只读文件的时候弹出确定comfirm
filetype off                                " 检测文件的类型,vundle 关闭,其它on
filetype plugin on                          " 载入ftplugin文件类型插件
filetype indent on                          " 为特定文件类型载入相关缩进文件
filetype plugin indent off
set binary                                  " 可读二进制文件
"set nrformats=                             " 默认<C-a> <C-x> 以十进制来计算. :h nrformats
"{{                                         " 修改一个文件后自动备份,备份文件名为原文件名加~后缀
"if has("vms")                              " linux取消
set nobackup
"else
"set nobackup
"endif                                      " linux取消
"}}
set backupcopy=yes                          " 设置备份时的行为为覆盖autobackup cover "set nowritebackup
set mouse=a                                 " 可以在buffer的任何地方使用鼠标
set selection=exclusive                     " 光标所在位置也属于被选中的范围
set selectmode=mouse,key                    " 鼠标键盘可用
set scrolloff=3                             " 光标移动到buffer的顶部和底部时保持3行距离
setlocal noswapfile                         " 关闭临时文件,不生成swap文件,
set bufhidden=hide                          " 当buffer丢弃时隐藏它
set linespace=0                             " 字符间插入的像素行数目
set wildmenu                                " 增强模式中的命令行自动完成操作,状态栏预览
set shortmess=atI                           " 启动的时候不显示援助索马里儿童提示
set noerrorbells                            " 不让vim发出讨厌的滴滴声 set noeb
set nobomb                                  " 不使用unicode签名
set textwidth=100                           " 每行显示多少字符
"set relativenumber                         " 相对行号
"set cc=101                                 " 红色高亮第101行.
set undofile
set undolevels=1000                         " undo 记忆1000
let g:data_dir = $HOME . '/.vim/'
let g:undo_dir = g:data_dir . 'undofile'
if finddir(g:data_dir) == ''
    silent call mkdir(g:data_dir)
endif
if finddir(g:undo_dir) == ''
    silent call mkdir(g:undo_dir)
endif
unlet g:undo_dir
unlet g:data_dir
set undodir=$HOME/.vim/undofile
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2 => Text Pattern {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                           " "折叠相关的快捷键
"                                           " "zf 创建折叠
"                                               zf\`a   折叠当前光标处到标记a的文本
"                                               zf3j    向下折叠3行
"                                               zf%     在括号光标处折叠括号内文本
"                                           " "zd 删除光标下的折叠.  
"                                           " "zD 删除光标下的折叠,以及嵌套的折叠.  
"                                           " "zE 删除窗口内的所有折叠.仅当 manual 和 marker 折叠方法下有效.  
"                                           " "zF 在当前行创建折叠.当一开始就计划要折叠所写代码的时候,可以用该命令创建一对折叠符号,然后再往里面填写内容
"                                           " "zR 打开所有的折叠
"                                           " "za Open/Close (toggle) a folded group of lines.
"                                           " "zA Open a Closed fold or close and open fold recursively.
"                                           " "zi 全部 展开/关闭 折叠
"                                           " "zo 打开 (open) 在光标下的折叠,
"                                           " "zO 打开光标下的折叠,以及嵌套的折叠.
"                                           " "zc 关闭 (close) 在光标下的折叠
"                                           " "zC 循环关闭 (Close) 在光标下的所有折叠
"                                           " "zM 关闭所有可折叠区域
"                                           " "zj 移动到下一个折叠的开始
"                                           " "zk 移动到上一个折叠的结束
"                                           " "zv 打开当前光标所在折叠,仅打开足够的折叠使光标所在的行不被折叠
"                                           " "[z 到当前打开折叠的开始.如果已在开始处,移到包含这个折叠的折叠开始处.  
"                                           " "]z 到当前打开折叠的结束.如果已在结束处,移到包含这个折叠的折叠结束处.  
"                                           " 可在开始的花括号前添加介绍,花括号后添加级别号,级别号不能为0.如: /*折叠介绍###1*/ code... /*###*/ (用###代替了折叠符号) 
set formatoptions=tcrqn                     " 自动格式化
set foldenable                              " 开始折叠
set foldcolumn=0                            " 设置折叠区域的宽度
setlocal foldlevel=1                        " 设置折叠层数为
" set foldclose=all                         " 设置为自动关闭折叠
set wrap                                    " 自动换行
set linebreak                               " 整词换行
set autoindent                              " 自动对齐,继承前一行的缩进
set smartindent                             " 智能对齐
set sm                                      " 显示括号配对情况 2012-09-05 23:42:33
set ai!                                     " 设置自动缩进
set cindent                                 " 使用c样式的缩进
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set tabstop=4                               " 设置tab为4个空格
set expandtab                               " 用空格来代替制表符tab noexpandtab是不用空格代替制表符tab
set backspace=2                             " 可以使用backspace键一次删2个
set whichwrap+=<,>,[,],h,l                  " 允许backspace和光标键跨越行边界
set shiftwidth=4                            " 设置行间交错为4个空格
set softtabstop=4                           " 统一缩进为4个空格
set smarttab                                " 在行和段开始处使用制表符
"set autoread                               " 设置当文件被改动时自动载入
"{{                                         " 用空格键来开关折叠
"                                           " 设置语法折叠
"                                           " manual  手工定义折叠
"                                           " indent  更多的缩进表示更高级别的折叠,相同的缩进中代码会被折叠
"                                           " expr    用表达式来定义折叠
"                                           " syntax  用语法高亮来定义折叠
"                                           " diff    对没有更改的文本进行折叠
"                                           " marker  对文中的标志折叠,标记折叠方法
set foldmethod=marker
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"}}
"                                           " 在被分割的窗口间显示空白,便于阅读
"{{                                         " 启动后自动最大化
if has("win32")
    au GUIEnter * simalt ~x
endif
"}}
"{{                                         " mark标记 :marks 取得所有标记, :jumps可在多文件跳转, :delmarks 删除指定标记, :delmarks!删除所有
"                                           " ma用a标记当前光标未知,可以用a~z
"                                           " 跳转到标记 `a
"                                           " 跳转到标记所在行首 'a
"                                           " '' 跳转前的位置 Ctrl+O (older)跳转到较老的地方
"                                           " . 最近编辑的位置
"                                           " 0-9 最近使用的文件
"                                           "∧ 最近插入的位置
"                                           " " 最后编辑的位置Ctrl+I 跳转到较新的地方,上一次退出文件时的位置
"                                           " [ 最后修改的位置的开头
"                                           " [ 最后修改的位置的结尾
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  3 => Encoding Configure {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set enc=utf-8                               " vim 支持中文 内部编码
set termencoding=utf-8                      " work in linux
set fenc=utf-8                              " work in linux 解析出来的当前文件编码(可能解析错误)
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936    " 文件解析猜测识别的编码顺序
set langmenu=zh_CN.UTF-8                    " Console output coding
language message zh_CN.UTF-8                " 控制台console编码
set ambiwidth=double                        " 把不明宽度字符设置为双倍字符宽度(中文字符宽度)
set fileencoding=utf-8                      " 当前编辑的文件编码(新文件的编码)
set fileencodings=usc-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin-1

                                            " 当前编辑的文件自动判断依次尝试编码, 打开时可以指定编码
set encoding=utf-8                          " work in linux
set imcmdline
"{{                                         " work in linux
if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif
"}}
set fileformat=unix                         " windows 下会导致编码失败
source $VIMRUNTIME/delmenu.vim              " 解决菜单乱码
source $VIMRUNTIME/menu.vim
set nocompatible                            " 不要使用vi的键盘模式
"set clipboard+=unnamed                     " 与windows共享剪贴板share clipboard with windows
"set iskeyword+=_,$,@,%,#,-                 " 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-                  " 带有如下符号的单词不要被换行分割
nmap <f7> :set iskeyword-=_,$,@,%,#,-,<CR>
                                            " 设置以上面符号为分割, 可以set iskeyword查看当前换行的,
                                            " -是删除掉, +是添加.
nmap <s-f7> :set iskeyword+=_,$,@,%,#,-,<CR>
                                            " 设置不以上面符号为分割
"{{                                         " 保存全局变量," 寄存器中保存几行文本 0不保存500上限
set viminfo+=!
set viminfo='1000,f1,<500
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  4 => Display {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert                          " 设置配色方案
set background=dark                         " 设置背景为黑
set novisualbell                            " No mouseflash
set nu                                      " 设置行号
syntax enable                               " 启用语法高亮
syntax on                                   " 设置语法高亮
"{{                                         " 高亮字符,让其不受100列限制
highlight OverLength ctermbg=darkgray ctermfg=lightblue guibg=#1C1D1E guifg=#DCDCDC
match OverLength '\%500v.*'
"}}
"{{                                         " 高亮显示普通txt文件(需要txt.vim脚本)
au BufRead,BufNewFile * setfiletype txt     " work in linux
set syntax=txt                              " work in linux
au BufRead,BufNewFile *.txt setlocal ft=txt
"                                           " 高亮显示普通txt文件(需要txt.vim脚本)
"                                           " 自动.c .h .sh .java自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.lua,*.py,*.php exec ":call SetTitle()" 
"                                           " 定义函数SetTitle,自动插入文件头 
let g:vimrc_author='Rainy Sia'
let g:vimrc_email='rainysia@gmail.com'
function! SetTitle()
    "                                       " 如果文件类型为.sh文件 
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        let g:vimrc_lang_version=' 2.7.9'
        "let g:vimrc_lang_version=system('python --version')
        let g:snips_php_version=g:vimrc_lang_version
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding: UTF-8 -*-")
        call append(line(".")+1, "")
    " elseif &filetype == 'mkd'
    "    call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    elseif &filetype == 'php'
        "let g:vimrc_lang_version=' version 5.6.24'
        let g:vimrc_lang_version=' version '.system('php -r "echo phpversion();"')
        let g:snips_php_version=g:vimrc_lang_version
        call setline(1,"<?php")
        call append(line("."), "")
    elseif &filetype == 'cpp'
        call setline(1, "#include<iostream>")
        call append(line("."), "using namespace std;")
        call append(line(".")+1, "")
    elseif &filetype == 'c'
        call setline(1, "#include <stdio.h>")
        call append(line("."), "")
    elseif &filetype == 'java'
        call setline(1,"public class ".expand("%"))
        call append(line("."),"")
    elseif &filetype == 'lua'
        let g:vimrc_lang_version=' version 5.3.3'
        let g:snips_php_version=g:vimrc_lang_version
        call setline(1,"#!/usr/local/bin/lua")
        call append(line("."), "")
    elseif &filetype == 'go'
        call setline(1,"#!/usr/local/go/bin")
        call append(line("."), "")
    else
        let g:vimrc_lang_version=' version num'
        let g:snips_php_version=g:vimrc_lang_version
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "  > Author: ".g:vimrc_author)
        call append(line(".")+2, "  > Mail: ".g:vimrc_email)
        call append(line(".")+3, "  > Created Time: ".strftime("%F %T"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    "                                       " 新建文件后,自动定位到文件末尾
endfunction
autocmd BufNewFile * normal G
"}}
set guioptions-=m                           " 去除vim的GUI版本中的toolbar
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
"{{                                         " 状态栏
set laststatus=2                            " 总是显示状态栏,默认1无法显示
"                                           " 我的状态行显示的内容(包括文件类型和解码)
set ruler                                   " 在状态行上显示光标所在位置的行号和列号
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set cmdheight=2                             " 命令行(在状态行下)的高度,默认为1,这里是2
"set report=0                               " 通过使用: commands命令,告诉我们文件的哪一行被改变过
"}}
"{{                                         " 空格的缩进颜色
"indent color
hi 4spa guibg = #771144
hi 8spa guibg = #22464A
hi 12spa guibg = #344333
hi 16spa guibg = #777444
hi 20spa guibg = #555777
hi 24spa guibg = #cc9966
hi 80spa guibg = #ff1111

"style 2
syn match 4spa /\(\s\|\n\)\&\%4v.*\%5v/
syn match 8spa /\s\&\%8v.*\%9v/
syn match 12spa /\s\&\%12v.*\%13v/
syn match 16spa /\s\&\%16v.*\%17v/
syn match 20spa /\s\&\%20v.*\%21v/
syn match 24spa /\s\&\%24v.*\%25v/
syn match 80spa /.\&\%80v.*\%81v/
set list                                    " 缩进线
"set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
" 制表符显示方式定义: trail为拖尾空白显示字符,extends和precedes分别是wrap关闭时,所在行在屏幕右边和左边显示的指示字符
" set listchars=tab:▸\ ,eol:¬ 
" ¬	U+00AC	not sign
" ▸	U+25B8	black right-pointing small triangle
" ☠	U+2620	skull and crossbones
" ❤	U+2764	heavy black heart
" ‽	U+203d	interobang
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
"}}
"{{
set virtualedit=block                       " block 允许可视列块模式的虚拟编辑
                                            " insert 允许插入模式的虚拟编辑
                                            " all 允许所有模式的虚拟编辑
                                            " onemore 允许光标移动到刚刚超过行尾的位置
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  5 => Search Match {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{                                         " 插入邮箱<ctrl+E>,邮箱自动切换,账户自动替换
map  irainysia@gmail.com
"}}
set showmatch                               " 高亮显示匹配的括号
set showcmd
set cursorline                              " 高亮显示当前行
set cursorcolumn                            " 高亮光标列
set matchtime=5                             " 匹配括号高亮的时间(单位是十分之一秒)
set ignorecase                              " 在搜索的时候忽略大小写
set hlsearch                                " 高亮被搜索的句子(phrases)
set incsearch                               " 在 搜索时,输入的词句的逐字符高亮(类似firefox的搜索)
set nowrapscan                              " 禁止搜索到文件两端时重新搜索
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  6 => Plugins {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{                                         " Vundle git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
if has('win32')
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
    "set rtp+=$VIMRUNTIME/bundle/vundle/
    "call vundle#begin('$VIMRUNTIME/bundle')
endif

Bundle 'VundleVim/Vundle.vim'
"" 快速文件查找
Bundle 'kien/ctrlp.vim'
"" ctrlp 函数查找
Bundle 'tacahiroy/ctrlp-funky'
"" ack 更快的搜索
Bundle 'mileszs/ack.vim'
"" 显示tag列表
Bundle 'vim-scripts/taglist.vim'
"" 在开头加入作者信息
Bundle 'rainysia/authorinfo_php'
"" 多种方式加入代码注释
Bundle 'vim-scripts/The-NERD-Commenter'
"" 显示文件浏览
Bundle 'scrooloose/nerdtree'
"" 在文件浏览是git时显示状态
Bundle 'Xuyuanp/nerdtree-git-plugin'
"" 显示minibuf列表在导航
Bundle 'fholgado/minibufexpl.vim'
"" 窗口管理
Bundle 'vim-scripts/winmanager'
"" 在工程中快速查找 F3
Bundle 'yegappan/grep'
"" 更好的查找
Bundle 'dkprice/vim-easygrep'
"" 区块伸缩选中
Bundle 'terryma/vim-expand-region'
"" 最近使用文件浏览
Bundle 'vim-scripts/mru.vim'
"" 显示多次搜索结果
Bundle 'vim-scripts/multisearch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'dimasg/vim-mark'
"" 关键字多文件搜索
Bundle 'dyng/ctrlsf.vim'
"" 中文vim文档
Bundle 'asins/vimcdoc'

"" 显示实际颜色
Bundle 'lilydjwg/colorizer'

"" 日历
Bundle 'itchyny/calendar.vim'

"" 自动缩进线, 彩色渐变
Bundle 'nathanaelkane/vim-indent-guides'
"" 自动缩进线
Bundle 'Yggdroot/indentLine'
"" lightline statusline
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

"" zencoding,快速生成代码
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/Emmet.vim'

"Bundle 'SirVer/ultisnips'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'rainysia/vim-snippets'

Bundle 'vim-scripts/L9'
Bundle 'othree/vim-autocomplpop'
Bundle 'joonty/vim-phpqa'
Bundle 'tpope/vim-surround'
Bundle 'andviro/flake8-vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'elzr/vim-json'

"" (x)html close tag
Bundle 'vim-scripts/closetag.vim'

"" C/C++, Switch in c to h
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/OmniCppComplete'

"" php indent and syntax
Bundle '2072/PHP-Indenting-for-VIm'
Bundle '2072/vim-syntax-for-PHP'
Bundle 'shawncplus/phpcomplete.vim'

"" scala
Bundle 'derekwyatt/vim-scala'
Bundle 'vim-scripts/scala.vim'

"" lua
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-lua-ftplugin'

"" go
Bundle 'fatih/vim-go'

"" format
Bundle 'junegunn/vim-easy-align'
"" Dockerfile syntax
Bundle 'ekalinin/Dockerfile.vim'

if $USER == 'root'
    "echo &rtp
else
    "echo &rtp
endif

call vundle#end()
filetype plugin indent on
let mapleader = ","                         "      键盘映射为 ,
"                                           " ,c   搜索统计光标处单词的次数
nmap <Leader>c *<C-O>:%s///gn<CR>
"}}
"{{                                         " CTags的设定
"                                           "     (地址自定义,我的www在/home/www下)
"                                           "     vim:!ctags -R重编译ctags文件,win先ctags.exe放vim73/
"                                           " ctrl_] 跳转到对应函数 ctrl_t 回跳 ctrl_o 回跳 :tag Tagname
"                                           " ctrl_W_] 新窗口打开跳转

set tags=/home/www/tags
set tags+=tags,./tags,tags                 " 分号必须,让vim递归向上查找tags
map <F8> :!ctags -R<CR>
nnoremap <silent> <S-F8> :!ctags -R<CR>
set autochdir
"}}
"                                           " 只在下列文件类型被侦测时显示行号,普通文本文件不显示
"{{
"                                           " au[tocmd]
set noerrorbells visualbell t_vb=           " disable beep when error
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=

    autocmd FileType html,python,vim,javascript,php,java,scala,lua,c setl shiftwidth=4
    autocmd FileType html,python,vim,javascript,php,java,scala,lua,c setl tabstop=4
    autocmd FileType html,python,vim,javascript,php,java,scala,lua,c setl softtabstop=4
    autocmd FileType html,xml,text,php,vim,c,java,xml,bash,shell,perl,python,scala,go,lua setlocal textwidth=100
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby,scala,go,lua set number
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
    autocmd FileType java,c,cpp,cs,php vmap <C-o> <ESC>'<o/*<ESC>'>o*/

    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType mysql set omnifunc=mysqlcomplete#CompleteMYSQL
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType cpp set omnifunc=cppcomplete#CompleteCPP
    autocmd FileType go set omnifunc=gocomplete#Complete
    autocmd FileType scala set omnifunc=scalacomplete#CompleteTags
    autocmd FileType lua set omnifunc=luacomplete#Complete

    autocmd FileType c,cpp,h map <F8> :!ctags -R -f ~/.vim/csystags --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include<CR>
    autocmd FileType c,cpp,h nnoremap <silent> <S-F8> :!ctags -R -f ~/.vim/csystags --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include<CR>
    autocmd FileType python map <F8> :!ctags -R -f ~/.vim/pysystags --python-kinds=-i --fields=+iaS --extra=+q /usr/lib/python2.7<CR>
    autocmd FileType python nnoremap <silent> <S-F8> :!ctags -R -f ~/.vim/pysystags --python-kinds=-i --fields=+iaS --extra=+q /usr/lib/python2.7<CR>

    autocmd BufNewFile,BufRead *.c,*.cpp               set tags+=tags,~/.vim/csystags;
    autocmd BufNewFile,BufRead *.py                    set tags+=tags,~/.vim/pysystags;
    autocmd BufNewFile,BufRead *.go                    set filetype=go syntax=go
    autocmd BufNewFile,BufRead *.scala                 set filetype=scala
    autocmd BufNewFile,BufRead *Spec.scala,*Test.scala set filetype=scalatest syntax=scala
    autocmd BufNewFile,BufRead *.sbt                   set filetype=scala

    autocmd BufWritePost *.go,*.c silent! !ctags -R & 
    "autocmd BufWritePost *.go,*.js,*.php,*.lua,*.scala silent! !ctags -R &  "自动从当前目录构建ctags,根目录就惨了

    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif                                       " has("autocmd")
"                                           " ctrl+x_ctrl+o后,ctrl+e来停止补全并回到原来录入的文字.ctrl+y接受当前补全并返回

set completeopt=longest,menu                " 提示菜单后输入字母实现即时的过滤和匹配,去掉预览窗口的显示
"                                           " 绑定ctrl+j,ctrl+k来替换掉Ctrl+n,Ctrl+p下,上 在complete弹出层上下翻
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))
"}}
"{{                                         " Ctrlp的设定 https://github.com/kien/ctrlp.vim 2013-07
"                                           "  运行命令:CtrlP或:CtrlP [starting-directory]来以查找文件模式来启用 ctrlp
"                                           "  运行命令:CtrlPBuffer或:CtrlPMRU来以查找缓冲或最近打开文件模式来启用ctrlp
"                                           "  运行命令:CtrlPMixed来查找文件,查找缓冲和最近打开文件混合模式来启动 ctrlp
"                                           "    按<c-f>和<c-b>在三种查找模式中互相切换
"                                           "    按<c-y>来创建新文件和对应的父目录
"                                           "    按<c-d>来切换到只查找文件名而不是全路径
"                                           "    按<c-j>,<c-k>或箭头方向键来移动查找结果列表***
"                                           "    按<c-t>或<c-v>,<c-x>来以新标签或分割窗口的方式来打开文件***
"                                           "    按<c-z>来标识或取消标识文件,然后按<c-o>来打开文件
"                                           "    按<c-n>,<c-p>来在提示历史中选择下一个/上一个字符串
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip    " Linux/MacOSX
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe" Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rvm)$'
let g:ctrlp_working_path_mode=0             " :cd 父目录, :CtrlP 父目录 或者上级目录来查找
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }
"}}
"{{                                         " ctrlp-funky的设定 https://github.com/tacahiroy/ctrlp-funky
nnoremap <Leader>fu :CtrlPFunky<CR>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
"}}
"{{                                         " ACK的设定 https://github.com/mileszs/ack.vim
"                                           " apt-get install ack-grep
"                                           " :Ack [options] {pattern} [{directories}]
"                                           " :Ack, :AckAdd, :LAck, and :LAckAdd
"                                           " -w 递归搜索
"                                           " -i 忽略大小写
"                                           " -Q '$path=.' path 搜索特殊字符串
"                                           " --ignore-dir=xxxpath 忽略某个目录
"                                           " --php --group protected 只搜索php文件中包含protected的文件, 同理--make, --py
"                                           " :ack --help-type
"                                           " 在ack搜索的list中  
"                                           " ?  打开快捷列表, 重复关闭
"}}
"{{
"{{                                         " Taglist的设定 https://github.com/vim-scripts/taglist.vim
"                                           "     F9开关 按wm会启动.F9是单独开关
"                                           "     :Tlist --呼出变量和函数列表 [TagList插件]
map <F9> :TlistToggle<CR>
let Tlist_Ctags_Cmd='ctags'                 "     基于ctags
let Tlist_Auto_Open = 0                     "     默认打开Taglist
let Tlist_Sort_Type = "name"                "     按照名称排序
let Tlist_Show_One_File=1                   "     不同时显示多个文件的tag,只显示当前文件的
let Tlist_Use_Right_Window = 0              "     在右侧显示窗口
let Tlist_Compart_Format = 1                "     不显示空白行
let Tlist_Exist_OnlyWindow = 1              "     如果只有一个buffer,kill窗口也kill掉buffer
let Tlist_File_Fold_Auto_Close = 1          "     打开其他文件的时候自动关闭,只显示一个文件的tag
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Update=1                     "     自动更新,包含新文件时候
let Tlist_Enable_Fold_Column = 0            "     不要显示折叠树
let Tlist_Use_Right_Window=1                "     右边显示 Left_Window 会左边显示
" php的折叠
let tlist_php_settings = 'php;c:class;i:interfaces;d:constant;f:function'
"}}
"{{                                         " authorinfo.vim的设定 https://github.com/rainysia/authorinfo_php
"                                           "     vim自动添加作者信息(需要和NERD_commenter联用)使用,
"                                           "     :AuthorInfoDetect呼出
let g:vimrc_author='Rainy Sia'
let g:vimrc_email='rainysia@gmail.com'
let g:vimrc_link='http://www.btroot.org'
let g:vimrc_copyright='2013-2016 BTROOT.ORG' 
let g:vimrc_license='https://opensource.org/licenses/MIT license'
let g:vimrc_version='GIT: 0.0.1'
let g:vimrc_lang_version = exists('g:vimrc_lang_version') ? g:vimrc_lang_version : ' version num'
nmap <F4> :AuthorInfoDetect<CR>
"}}
"{{                                         " NERD_commenter.vim的设定 https://github.com/vim-scripts/The-NERD-Commenter
"                                           "      vim加入注释
"                                           "      <leader>ca 在可选的注释方式之间切换,比如C/C++ 的块注释/* */和行注释//
"                                           "      <leader>cc 注释当前行
"                                           "      <leader>cs 以"性感"的方式注释
"                                           "      <leader>cA 在当前行尾添加注释符,并进入Insert模式
"                                           "      <leader>cu 取消注释
"                                           "      <leader>cm 添加块注释
"                                           "      [count],c命令 依次从本行开始注释,取消注释,count 为数字 7,cc
"                                           "      定义F11为html的注释
map <F11> <ESC>0i<!--<ESC>$a--><ESC>
"                                           "      定义F12为html的注释取消
map <F12> <ESC>04x$hh3x<ESC>
"}}
"{{                                         " NERDTree的设定 https://github.com/scrooloose/nerdtree
"                                           "     插件F10开启list.tree
"                                           "      :NERDTree   --启动NERDTree插件
"                                           "      o [小写]    --切换当前文件或目录的打开,关闭状态
"                                           "      u           --打开上层目录
"                                           "      p [小写]    --返回上层目录
"                                           "      P [大写]    --返回根目录
"                                           "      K           --转到当前目录第一个节点
"                                           "      J           --转到当前目录最后的节点
"                                           "      m           --显示文件系统菜单 [增a, 删d,移m, 复c, 显示l]
"                                           "      ?           --弹出帮助菜单
"                                           "      q           --退出该插件
map <F10> :NERDTreeToggle<CR>
"                                           " 当打开vim且没有文件时自动打开NERDTREE
autocmd vimenter * if !argc() | NERDTree | endif
"                                           " 只剩NREDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"}}
"{{                                         " nerdtree-git-plugin https://github.com/Xuyuanp/nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
"}}
"{{                                         " minibufexpl.vim的设定 https://github.com/fholgado/minibufexpl.vim
"                                           "     切换c+Tab前c+s+Tab后buff,ctrl+h,j,k,l上下左右
"                                           "     :bp和:bn分别是切换到上一个和下一个Buffer, :bd则删除当前显示的单个Buffer
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowsNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplModSelTarget = 1
"}}
"{{                                         " winmanager 的设定 https://github.com/vim-scripts/winmanager
"                                           "    wm 开启, 窗口管理
"                                           "        ctrl+w+ h,j,k,l  在窗口左下上右移动交换鼠标
"                                           "        ctrl+w+w: 在所有窗口循环,ctrl+w+t: 移动到最左上角的窗口
"                                           "        ctrl+w+b: 移动到最右下角的窗口 ctrl+w+p: 移动到前一个访问的窗口
"                                           "        ctrl+w+r: 向右或向下方交换窗口,而ctrl+w+R: 则和它方向相反
"                                           "        ctrl+w+K: 移动当前窗口至屏幕顶端,并占用全部宽度
"                                           "        ctrl+w+J: 移动窗口至屏幕底端,并占用全部宽度
"                                           "        ctrl+w+H: 移动窗口至屏幕左端,并占用全部高度
"                                           "        ctrl+w+L: 移动窗口至屏幕右端,并占用全部高度
"                                           "        ctrl+w+T: 移动窗口至屏新的现有分页
"                                           "        ctrl+w+=: 让所有窗口调整至相同尺寸(平均划分)
"                                           "        ctrl+w+-: 将当前窗口的高度减少一行,也可在ex命令中,:resize -4明确指定减少的尺寸
"                                           "        ctrl+w++: 将当前窗口的高度增加一行.同样在ex命令中,:resize +n 明确指定增加尺寸
"                                           "        ctrl+w+<: 将当前窗口的宽度减少
"                                           "        ctrl+w+>: 将当前窗口的宽度增加
"                                           "        ctrl+w+|: 将当前窗口的宽度调到最大,也可通过ex命令 :vertical resize n明确指定改变宽度
"                                           "        :tabnew filename  打开新分页并编辑新文件(可选的).如果未指定文件,则只打开新分页,并附上空的缓冲区.
"                                           "        :tabclose  :tabc关闭当前分页
"                                           "        :tabonly  :tabo关闭其他所有的分页.如果其他分页中有修改过的文件,则不会移除该分页
"                                           "        :tabp  前一个, :tabn 后一个, 
"                                           "        普通模式下 gt下一个, gT前一个tab, 2gt直接跳到后2个tab, 3gT跳到前三个tab
"                                           "        ctrl+PageDown: 移动到下一个分页
"                                           "        ctrl+PageUp: 移动到上一个分页
"                                           "        ctrl+w+q: 离开当前窗口
"                                           "        ctrl+w+c: 关闭当前的窗口
"                                           "        ctrl+w+o: 关闭当前窗口以外的所有窗口
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<CR>
"}}
"{{                                         " grep.vim的设定 https://github.com/yegappan/grep
nnoremap <silent> <F3> :Grep<CR>
"}}
"{{                                         " EasyGrep.vim的设定 https://github.com/dkprice/vim-easygrep
" <Leader>vv                                "  Grep for the word under the cursor, match all occurences, like |gstar|   :Grep xxx
" <Leader>vV                                "  Grep for the word under the cursor, match whole word, like |star|         :Grep xxx !
" <Leader>va                                "    Like vv, but add to existing list   :GrepAdd xxx
" <Leader>vA                                "    Like vV, but add to existing list   :GrepAdd xxx!
" <Leader>vr                                "    Perform a global search search on the word under the cursor and prompt for a pattern with which to replace it. :Replace [target] [replacement] :ReplaceUndo
" <Leader>vo                                "    Select the files to search in and set grep options
"                                           " :GrepOptions [arg] 新开窗口来设置grep选项.
"}}
"{{                                         " vim-expand-region https://github.com/terryma/vim-expand-region
"                                           " + 扩展选择, - 缩小选择

"}}
"{{                                         " mru.vim的设定 https://github.com/vim-scripts/mru.vim
"                                           " :MRU
"let MRU_File = '\myhome\_vim_mru_files' " 指定缓存地址.
let MRU_Max_Entries = 1000
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix  /windows '^c:\\temp\\.*'
" let MRU_Include_Files = '\.c$\|\.h$'      " 指定类型的最近打开
let MRU_Add_Menu = 1                        " 增加到菜单.
let MRU_Max_Menu_Entries = 20 
let MRU_Max_Submenu_Entries = 15 
"}}
"{{                                         " Multisearch.vim的设定 matchit.vim  https://github.com/vim-scripts/multisearch.vim
"                                           " :help Msearch, :Msearch <command>
"}}
"{{                                         " vim-multiple-cursors 插件.多重选择 https://github.com/terryma/vim-multiple-cursors
"                                           " v选中后, ctrl-n select next, c modify the content, <esc> exit;
let g:multi_cursor_next_key='<C-n>'         "    next 
let g:multi_cursor_prev_key='<C-d>'         "    prev
let g:multi_cursor_skip_key='<C-x>'         "    skip the next.
"}}
"{{                                         " mark.vba.gz的设定(mark.vim) https://github.com/dimasg/vim-mark
"                                           " :Mark regexp   to mark a regular expression 
"                                           " :Mark regexp   with exactly the same regexp to unmark it 
"                                           " :Mark          to clear all marks , :Marks, show all mark color
"                                           " ,m mark关键词,,n 取消关键词, ,r输入想要高亮的   / 已经替换成了,
"                                           "      解压后,用vim打开  :so %
"                                           "      颜色值 'extended'18色 'maximum' 77色
"                                           "      <Leader>/m ,/m  mark or unmark the word under (or before) the cursor
"                                           "      <Leader>/r ,/r manually input a regular expression. 用于搜索.
"                                           "      <Leader>/n ,/n clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
"                                           "      <Leader>/* ,/* 把光标向前切换到当前被Mark的MarkWords中的下一个MarkWord.
"                                           "      <Leader>/# ,/# 把光标向后切换到当前被Mark的MarkWords中的上一个MarkWord.
"                                           "      <Leader>// ,// 把光标向前切换到所有被Mark的MarkWords中的下一个MarkWord.
"                                           "      <Leader>/? ,/? 把光标向后切换到所有被Mark的MarkWords中的上一个MarkWord.
let g:mwDefaultHighlightingPalette = 'extended'
"}}
"{{                                         " dyng/ctrlsf.vim git@github.com:dyng/ctrlsf.vim.git
"                                           " :CtrlSF [keywords], t 在tab中打开,T 在tab打开但光标在搜索结果, q quit CtrlSF mode
"}}
"{{                                         " vimcdoc https://github.com/asins/vimcdoc
"
"}}
"{{                                         " css-highlight https://github.com/lilydjwg/colorizer
"}}
"{{                                         " calendar.vim https://github.com/itchyny/calendar.vim
"                                           " :Calendar, :Calendar 2016 04 19, :Calendar -view=year, 
"                                           " :Calendar -view=year -split=vertical -width=27
"                                           " :Calendar -view=year -split=horizontal -position=below -height=12
"                                           " :Calendar -first_day=monday
"                                           " :Calendar -view=clock
let g:calendar_frame = 'default'
"}}
"{{                                         " indent.guides的设定 https://github.com/nathanaelkane/vim-indent-guides 
"                                           "      自动缩进,<Leader>ig 唤出, /usr/share/vim , ~/.vim
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesEven ctermbg=darkgrey
hi IndentGuidesOdd  ctermbg=black
"}}
"{{                                         " indentLine.vim 另外一个对齐线.https://github.com/Yggdroot/indentLine
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#3E3F40'
let g:indentLine_char = '|'
"}}
"{{                                         " vim-fugitive https://github.com/tpope/vim-fugitive
"                                           " :Gedit, :Gsplit, :Gvsplit, :Gtabedit, :Gdiff, :Gcommit,
"                                           " :Gblame, :Gmove, :Ggrep, :Glog, :Gread=git checkout --filename
"                                           " :Gstatus , press - to add/reset, p to add/reset --patch
"                                           " :Gwrite, :Gbrowse, :Git
autocmd QuickFixCmdPost *grep* cwindow
"}}
"{{                                         " vim-gitgutter https://github.com/airblade/vim-gitgutter
"                                           "   ,hn跳转下一个修改,hp前跳修改,ht关闭开启该插件,hh高亮轮换
"                                           "   :GitGutterDisable/Enable/Toggle 禁用/启用/轮换 该插件
"                                           "   :GitGutterLineHighlightsEnable/Disable/Toggle 高亮修改行,default off
"                                           "   ☺ ☻ ♻ ✗ ✚ ✪ ✯ ➜ ❀ ☢ ✖️ 
"                                           "   关闭占用vim左侧列
let g:gitgutter_enabled = 0                 " close gitgutter
let g:gitgutter_sign_column_always = 0
let g:gitgutter_max_signs = 500 
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>ht :GitGutterToggle<CR>
nmap <Leader>hh :GitGutterLineHighlightsToggle<CR>
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✗'
let g:gitgutter_sign_removed = '✖️'
let g:gitgutter_sign_removed_first_line = '♻'
let g:gitgutter_sign_modified_removed = '☢'

"}}
"{{                                         " lightline https://github.com/itchyny/lightline.vim
"                                           " install powerline font
"                                           " https://github.com/eugeii/consolas-powerline-vim, copy to /usr/share/fonts
"                                           " mkfontscale,mkfontdir,fc-cache -vf,:PowerlineClearCache
let g:Powerline_symbols = 'fancy'
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:-      " vim的窗口分割线,分别设置垂直,上下,折叠,差异的填充字符
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
"}}
"{{                                         " YouCompleteMe https://github.com/Valloric/YouCompleteMe
"                                           "   need apt-get install build-essential, cmake, python-dev, python3-dev,
"                                           "   git submodule update --init --recursive
"                                           "   go YouCompleteMe Directory: ./install.sh --clang-completer
"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"let g:ycm_complete_in_comments = 1          "   在注释输入中也能补全
"let g:ycm_complete_in_strings = 1           "   在字符串输入中也能补全
"let g:ycm_use_ultisnips_completer = 1       "   提示UltiSnips
"let g:ycm_cache_omnifunc = 0                "   禁止缓存匹配项,每次都重新生成匹配项
"let g:ycm_collect_identifiers_from_comments_and_strings = 0   "注释和字符串中的文字也会被收入补全
"let g:ycm_seed_identifiers_with_syntax = 0              "语言关键字补全, 不过python关键字都很短,所以,需要的自己打开
""let g:ycm_collect_identifiers_from_tags_files = 1      "会导致一直更新标签,python2 占用内存80%以上
""let g:ycm_key_invoke_completion = '<C-Space>'          " 直接触发自动补全
"let g:ycm_goto_buffer_command = 'horizontal-split'      " 跳转到定义处, 分屏打开
"let g:ycm_semantic_triggers = {}            " 不让C的时候只有在 ./-> 时才会弹出补全菜单
"let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']
"" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"                                            " 黑名单,不启用
"let g:ycm_filetype_blacklist = {
"     \ 'tagbar' : 1,
"     \ 'gitcommit' : 1,
"     \}
""}}
"{{                                         " syntastic https://github.com/scrooloose/syntastic
let g:syntastic_error_symbol = '✗'          "set error or warning signs
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快,pip install pyflakes
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_enable_balloons = 1        " whether to show balloons
highlight SyntasticErrorSign guifg=white guibg=black
"}}
"{{                                         " zencoding.vim 的设定 https://github.com/vim-scripts/Emmet.vim
"                                           "      html:xxs>div#header+div#container>ul>li.class_$#id_$*2
"                                           "      按下 <ctrl+y> 然后 点 , 逗号
"                                           "      ul>li*
"                                           "      移动到网址上,<C-y>a 加入a标签
"                                           "      移动到一个整体标签上<C-y>/加入html注释,<C-y>/再按取消
"                                           "      ul>li*
"                                           "      ul>li*
"                                           "      html:xt <c+y> ,
"}}
"                                           " MarcWeber/vim-addon-mw-utils https://github.com/MarcWeber/vim-addon-mw-utils'
"                                           " tomtom/tlib_vim              https://github.com/tomtom/tlib_vim'
"{{                                         " vim-snippets https://github.com/honza/vim-snippets
"
"{{                                         " snipmate https://github.com/msanders/snipmate.vim
" :h SnipMate-mappings
"}}
"                                           " garbas/vim-snipmate          https://github.com/garbas/vim-snipmate'
"                                           " rainysia/vim-snippets        https://github.com/rainysia/vim-snippets'
let g:snips_author=g:vimrc_author
let g:snips_copyright=g:vimrc_copyright
let g:snips_license=g:vimrc_license
let g:snips_email=g:vimrc_email
let g:snips_site =g:vimrc_link
let g:snips_link=g:vimrc_link
"let g:snips_php_version=g:vimrc_lang_version
"}}
"{{                                         " ultisnips https://github.com/SirVer/ultisnips
"                                           " Trigger configuration, will conflict with YouCompleteMe
"let g:UltiSnipsExpandTrigger="<Leader><tab>"
"let g:UltiSnipsJumpForwardTrigger="<Leader><tab>"
"let g:UltiSnipsJumpBackwardTrigger="<Leader><s-tab>"
"let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
"let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
"
"if finddir(g:UltiSnipsSnippetsDir) == ''
"    silent call mkdir(g:UltiSnipsSnippetsDir)
"endif

"                                           " :UltiSnipsEdit to split your window.
"map <Leader>us :UltiSnipsEdit<CR>
"let g:UltiSnipsEditSplit="vertical"
""                                          " ctrl+j/k 进行选择
"func! g:JInYCM()
"    if pumvisible()
"        return "\<C-n>"
"    else
"        return "\<c-j>"
"    endif
"endfunction
"
"func! g:KInYCM()
"    if pumvisible()
"        return "\<C-p>"
"    else
"        return "\<c-k>"
"    endif
"endfunction
"inoremap <c-j> <c-r>=g:JInYCM()<cr>
"au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwordTrigger . " <C-R>=g:KInYCM()<cr>"
"let g:UltiSnipsJumpBackwordTrigger = "<c-k>"
"}}
"}}
"{{                                         " L9 library for autocomplpop https://github.com/vim-scripts/L9
"}}
"{{                                         " autocomplpop 插件,自动完成提示. https://github.com/othree/vim-autocomplpop
"}}
"{{                                         " phpqa.vim的设定 https://github.com/joonty/vim-phpqa
"                                           " debian apt-get install php-codesniffer, pear install PHP_CodeSniffer
"let g:phpqa_codesniffer_args = "--standard=Zend"
let g:phpqa_codesniffer_args = "--standard=Zend"
let g:phpqa_codesniffer_args = " --encoding=utf-8"
let g:phpqa_codesniffer_cmd  = '/usr/bin/phpcs'
let g:phpqa_codesniffer_autorun = 1         "  default =1 on save
"                                           " :return NULL Void Boolean Float String Array Object Resource Callback
let g:phpqa_messdetector_ruleset = ''
let g:phpqa_messdetector_cmd = '/usr/bin/phpmd'
let g:phpqa_messdetector_autorun = 0
"                                           " :php  --check for syntax errors
"                                           " :phpcs--run code sniffer
"                                           " :phpmd--run mess detector(要XML rule)
"                                           " :phpcc--show code coverage
"}}
"{{                                         " quickfix模式
"                                           " :cc 显示详细错误信息 ( :help :cc )
"                                           " :cp 跳到上一个错误 ( :help :cp )
"                                           " :cn 跳到下一个错误 ( :help :cn )
"                                           " :cl 列出所有错误 ( :help :cl )
"                                           " :cw 如果有错误列表,则打开quickfix窗口 ( :help :cw )
"                                           " :col到前一个旧的错误列表 ( :help :col )
"                                           " :cnew 到后一个较新的错误列表 ( :help :cnew ) 
"}}
"{{                                         " php code sniffer ,php md模式
"                                           " :!phpcs :!phpmd
"}}
"{{                                         " Surround.vim 针对包含在文字外的括号,引号,XML 标签做快速的修改 https://github.com/tpope/vim-surround
"                                           " cs"' 修改双引号为单引号 cs'<q> 修改单引号为<q>包围的.
"                                           " ds"  删除包围的符号
"                                           " cs"<q> 修改双引号为<q></q>包围
"                                           " ys"  add a surrouding
"                                           " yS"  add a surrouding and place the Surrounded text on a new line + indent it
"                                           " yss" add a surrounding to the whole line.
"                                           " ySs" add a surrounding to the whole line and place it on a new line + indent it.
"                                           " ySS" same as ySs", try ysw,yswb",yas')
"                                           " ysw' 为字符串开始处加上单引号
"                                           " ysiw' 为光标下的单词包围
"                                           " 可视模式下,选中,S"  可插入包裹的
"}}
"{{                                         " flake8插件 https://github.com/andviro/flake8-vim
"                                           " command
"                                               :PyFlakeToggle  "Disable/enable automatic checking of current file
"                                               :PyFlake        "Run checks for current file
"                                               :PyFlakeAuto    "Auto-fix pep8 errors for current file
"                                           " Bind F6 to auto fix,F5 to check
"map <F6> :PyFlakeAuto<CR>
"map <F5> :PyFlake<CR>
let g:PyFlakeOnWrite = 0                    " Auto-check file for errors on write:
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes' "List of checkers used:
let g:PyFlakeDefaultComplexity=10           " Default maximum complexity for mccabe:
let g:PyFlakeDisabledMessages = 'E501'      " List of disabled pep8 warnings and errors:
let g:PyFlakeCWindow = 6                    " Default height of quickfix window:
let g:PyFlakeSigns = 1                      " Whether to place signs or not:
let g:PyFlakeMaxLineLength = 100            " Maximum line length for PyFlakeAuto command
let g:PyFlakeRangeCommand = 'Q'             " Visual-mode key command for PyFlakeAuto
"}}
"{{                                         " auto-pairs https://github.com/jiangmiao/auto-pairs
"}}
"{{                                         " A better JSON for Vim https://github.com/elzr/vim-json
let g:vim_json_syntax_conceal = 0           "   disable json quote concealing, 0=Null, 1='', 2=\"\"
"let g:indentLine_noConcealCursor=""
"
"}}
"{{                                         " closetag.vim https://github.com/vim-scripts/closetag.vim
"                                           " <C-_> to get hit
"}}
"{{                                         " a.vim https://github.com/vim-scripts/a.vim
"                                           " :A switches to the header file corresponding to the current file being edited (or vise versa)
"                                           " :AS splits and switches
"                                           " :AV vertical splits and switches
"                                           " :AT new tab and switches
"                                           " :AN cycles through matches
"                                           " :IH switches to file under cursor
"                                           " :IHS splits and switches
"                                           " :IHV vertical splits and switches
"                                           " :IHT new tab and switches
"                                           " :IHN cycles through matches
"                                           " <Leader>ih switches to file under cursor
"                                           " <Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
"                                           " <Leader>ihn cycles through matches
"}}
"{{                                         " OmniCppComplete https://github.com/vim-scripts/OmniCppComplete
"                                           " :ctags -R -f ~/.vim/systags --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q /usr/include /usr/local/include
let OmniCpp_MayCompleteDot = 1              " autocomplete with .
let OmniCpp_MayCompleteArrow = 1            " autocomplete with ->
let OmniCpp_MayCompleteScope = 1            " autocomplete with ::
let OmniCpp_SelectFirstItem = 2             " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2             " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1         " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1             " enable the global scope search
let OmniCpp_DisplayMode=1                   " Class scope completion mode: always show all members
"let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1               " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1 
"}}
"{{                                         " php-indent https://github.com/2072/PHP-Indenting-for-VIm
"                                           " php-syntax https://github.com/2072/vim-syntax-for-PHP
"}}
"{{                                         " phpcomplete https://github.com/shawncplus/phpcomplete.vim
"}}
"{{                                         " vim-scala https://github.com/derekwyatt/vim-scala
"}}
"{{                                         " scala.vim https://github.com/vim-scripts/scala.vim
"}}
"{{                                         " xolox/vim-lua-ftplugin https://github.com/xolox/vim-lua-ftplugin
"}}
"{{                                         " xolox/vim-misc https://github.com/xolox/vim-misc
"let g:lua_compiler_name = '/usr/local/bin/luac'
let g:lua_complete_omni = 1
let g:lua_check_syntax = 0
let g:lua_check_globals = 0
let g:lua_define_completefunc = 1
let g:lua_define_omnifunc = 1
"                                           " :LuaCheckSyntax, :LuaCheckGlobals
"}}
"{{                                         " vim-go https://github.com/fatih/vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
"au FileType go nmap <leader>t <Plug>(go-test)
"au FileType go nmap <leader>c <Plug>(go-coverage)
"}}
"{{                                         " vim-easy-align https://github.com/junegunn/vim-easy-align
"                                           "    <Space>, =, :, ., |, &, #, and ,.
"                                           "   visual mode (vipga=)
xmap ga <Plug>(EasyAlign)
"                                           "   motion/text object (gaip=)
nmap ga <Plug>(EasyAlign)
"                                           " :EasyAlign *=      gaip*=
"                                           " :EasyAlign =      gaip=
"                                           " :EasyAlign 2=      gaip2=
"                                           " :EasyAlign **=      gaip**=
"}}
"{{                                         " Dockerfile https://github.com/ekalinin/Dockerfile.vim
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  7 => Function {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                           " F5编译和运行C程序,F6编译和运行C++程序
"                                           " 请注意,下述代码在windows下使用会报错
"                                           " 需要去掉./这两个字符
"{{                                         " C的编译和运行
"map <F7> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"exec "w"
"exec "!gcc % -o %<"
"exec "! ./%<"
"endfunc
"}}
"{{                                         " C++的编译和运行
"map <F6> :call CompileRunGpp()<CR>
"func! CompileRunGpp()
"exec "w"
"exec "!g++ % -o %<"
"exec "! ./%<"
"endfunc
"}}
"{{                                         " 显示.NFO文件
set encoding=utf-8
function! SetFileEncodings(encodings)
    let b:myfileencodingsbak=&fileencodings
    let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
    let &fileencodings=b:myfileencodingsbak
    unlet b:myfileencodingsbak
endfunction
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()
"                                           " count selected words 
let s:prevcountcache=[[], 0]
function! ShowCount()
    let key=[@/, b:changedtick]
    if s:prevcountcache[0]==#key
        return s:prevcountcache[1]
    endif
    let s:prevcountcache[0]=key
    let s:prevcountcache[1]=0
    let pos=getpos('.')
    try
        redir => subscount
        silent %s///gne
        redir END
        let result=matchstr(subscount, '\d\+')
        let s:prevcountcache[1]=result
        return result
    finally
        call setpos('.', pos)
    endtry
endfunction
let &statusline='%{ShowCount()} %<%f %h%m%r%=%-14.(%l,%c%V%) %P'
"                                           " use alt+<N> to switch tab
function! TabPos_ActivateBuffer(num)
    let s:count = a:num
    exe "tabfirst"
    exe "tabnext" s:count
endfunction
 
function! TabPos_Initialize()
for i in range(1, 9)
        exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"
endfunction
 
autocmd VimEnter * call TabPos_Initialize()
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  8 => Original _vimrc {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
"{{
set diffexpr=MyDiff()
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"}}
"{{
" 高亮当前光标列.
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction
"}}
"{{
" vim 打开不存在的文件夹下的文件时自动创建文件夹
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  9 => End {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                           " .vimrc修改后不需重启生效
autocmd! bufwritepost _vimrc source %
"                                           " 每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.s,*.asm,*.h,*.c,*.cpp,*.cc,*.java,*.cs,*.erl,*.hs,*.sh,*.lua,*.pl,*.pm,*.php,*.py,*.rb,*.erb,*.vim,*.js,*.css,*.xml,*.html,*.xhtml 2match Underlined /.\%81v/
"{{                                         " work in windows ,not work in linux
"if has("gui_running")
"    au GUIEnter * simalt ~x                " 窗口启动时自动最大化
    "set guioptions-=m                      " 隐藏菜单栏
    "set guioptions-=T                      " 隐藏工具栏
    "set guioptions-=L                      " 隐藏左侧滚动条
    "set guioptions-=r                      " 隐藏右侧滚动条
    "set guioptions-=b                      " 隐藏底部滚动条
    "set showtabline=0                      " 隐藏Tab栏
"endif
"}}
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  10 => Color Configure "{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                           " term 黑白终端 cterm 彩色终端 ctermfg彩色终端前景色 ctermbg 彩色终端背景色
"                                           " gui GUI版本属性 guifg GUI版本的前景色 guibg GUI版本的背景色
if has("gui_running")
    "GUI
    "======================================================================================================================="
    hi        Cursor         guifg=#FBFDFC          guibg=#000201           gui=NONE        "光标所在的字符 #64574e
    hi        CursorColumn                          guibg=#3E3F40           gui=NONE        "光标所在的屏幕列
    hi        CursorLine                            guibg=#3E3E3E           gui=NONE        "光标所在的屏幕行 #666666
    hi        ColorColumn    guifg=#5c5c5c          guibg=#f2f2f2           gui=NONE        "高亮光标所在列.
    hi        Directory      guifg=#FF3F3F          guibg=#1C1D1F           gui=NONE        "目录名
    hi        DiffAdd        guifg=#FFFFCD          guibg=#306D30           gui=NONE        "diff: 增加的行#FFFFFF #7F7F00
    hi        DiffChange     guifg=#BFBFBF          guibg=#1C1D1F           gui=NONE        "diff: 改变的行#FFFFFF #7F007F #306B8F
    hi        DiffDelete     guifg=#FFFFCD          guibg=#6D3030           gui=NONE        "diff: 删除的行#FFFFFF #007F7F
    hi        DiffText       guifg=#FFFFCD          guibg=#4A2A4A           gui=NONE        "diff: 改变行里的改动文本#007F00 #1C1D1F
    hi        ErrorMsg       guifg=#FF3F3F          guibg=#1C1D1F           gui=NONE        "命令行上的错误信息
    hi        VertSplit      guifg=#FF3F3F          guibg=#3F3FFF           gui=NONE        "分离垂直分割窗口的列
    hi        Folded         guifg=#DDEEFE          guibg=#20BAAA           gui=NONE        "用于关闭的折叠的行
    hi        IncSearch      guifg=#FF0000          guibg=#DDA0DD           gui=NONE        "'incsearch' 高亮
    hi        LineNr         guifg=#4D4D4B          guibg=#000000           gui=NONE        "置位number选项时的行号
    hi        MatchParen     guifg=#FFD6EB          guibg=#FF5CAF           gui=NONE        "配对的括号
    hi        ModeMsg        guifg=#FF7F00          guibg=#1C1D1F           gui=NONE        "showmode 消息(INSERT)
    hi        MoreMsg        guifg=#BFBF3F          guibg=#1C1D1F           gui=NONE        "|more-prompt|
    hi        NonText        guifg=#007FFF          guibg=#1C1D1F           gui=NONE        "窗口尾部的'~'和 '@'
    hi        Normal         guifg=#BFBFBF          guibg=#1C1D1F           gui=NONE        "正常内容
    hi        Pmenu          guifg=#FFFFFF          guibg=#7373CF           gui=NONE        "弹出菜单普通项目
    hi        PmenuSel       guifg=#DDEEFF          guibg=#FF3F3F           gui=NONE        "弹出菜单选中项目
    hi        PmenuSbar      guifg=#3F3FFF          guibg=#FFF43F           gui=NONE        "弹出菜单滚动条.
    hi        PmenuThumb     guifg=#FFF43F          guibg=#757473           gui=NONE        "弹出菜单滚动条的拇指
    hi        Question       guifg=#7F7F7F          guibg=#1C1D1F           gui=NONE        "提示和yes/no 问题
    hi        Search         guifg=#E10000          guibg=#ffffff           gui=NONE        "最近搜索模式的高亮
    hi        SpecialKey     guifg=#4c4c4c          guibg=#1C1D1F           gui=NONE        "特殊键,字符和'listchars'
    hi        SpellBad       guifg=#FF0000          guibg=#1C1D1F           gui=NONE        "拼写检查器不能识别的单词
    hi        SpellCap       guifg=#BF0000          guibg=#1C1D1F           gui=NONE        "应该大写字母开头的单词
    hi        SpellLocal     guifg=#FF00FF          guibg=#1C1D1F           gui=NONE        "只在其它区域使用的单词
    hi        SpellRare      guifg=#FF7FFF          guibg=#1C1D1F           gui=NONE        "很少使用的单词
    "   hi        StatusLine     guifg=#D8BFD8          guibg=#696969           gui=NONE        "当前窗口的状态行
    "   hi        StatusLineNC   guifg=#FFFFFF          guibg=#3F3F3F           gui=NONE        "非当前窗口的状态行
    hi        TabLine        guifg=#1C1D1F          guibg=#BFBFBF           gui=NONE        "非活动标签页标签
    hi        TabLineFill    guifg=#1C1D1F          guibg=#FFFFFF           gui=NONE        "没有标签的地方
    hi        TabLineSel     guifg=#FFFF00          guibg=#0000FF           gui=NONE        "活动标签页标签
    hi        Title          guifg=#007FBF          guibg=#1C1D1F           gui=NONE        ":set all 等输出的标题
    hi        Visual         guifg=#2F4F4F          guibg=#ADD8E6           gui=NONE        "可视模式的选择区
    hi        WarningMsg     guifg=#FF003F          guibg=#1C1D1F           gui=NONE        "警告消息
    hi        WildMenu       guifg=#FF7F00          guibg=#0000FF           gui=NONE        "wildmenu补全的当前匹配
    "======================================================================================================================="
    "GUI group-name
    "======================================================================================================================="
    hi        Comment        guifg=#87CEEB          guibg=#1C1D1F           gui=NONE        "任何注释 #747474 #87CEEB
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Constant       guifg=#BF007F          guibg=#1C1D1F           gui=NONE        "任何常数 #96CBFE #BF007F
    hi        String         guifg=#A3BCBC          guibg=#1C1D1F           gui=NONE        "一个字符串常数: "字符串" #A8FF60 #A3BCBC
    hi        Character      guifg=#FF3F3F          guibg=#1C1D1F           gui=NONE        "一个字符常数: 'c','\n'
    hi        Number         guifg=#FF7F3F          guibg=#1C1D1F           gui=NONE        "一个数字常数: 234,0xff
    hi        Float          guifg=#FF7F3F          guibg=#1C1D1F           gui=NONE        "一个浮点常数: 2.3e10
    hi        Boolean        guifg=#FF0000          guibg=#1C1D1F           gui=NONE        "一个布尔型常数: TRUE,false
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Identifier     guifg=#007FBF          guibg=#1C1D1F           gui=NONE        "任何变量名
    hi        Function       guifg=#00BFBF          guibg=#1C1D1F           gui=NONE        "函数名 (也包括: 类的方法名) #FFD2A7 #00BFBF
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Statement      guifg=#B8B1D3          guibg=#1C1D1F           gui=NONE        "任何语句
    hi        Conditional    guifg=#FFFF33          guibg=#1C1D1F           gui=NONE        "if,then,else,endif,switch
    hi        Repeat         guifg=#FFBF00          guibg=#1C1D1F           gui=NONE        "for,do,while 等
    hi        Label          guifg=#1E90FF          guibg=#1C1D1F           gui=NONE        "case,default 等
    hi        Operator       guifg=#BFFF00          guibg=#1C1D1F           gui=NONE        ""sizeof","+","*" 等
    hi        Keyword        guifg=#BFBF00          guibg=#1C1D1F           gui=NONE        "任何其它关键字
    hi        Exception      guifg=#BF7F00          guibg=#1C1D1F           gui=NONE        "try,catch,throw
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        PreProc        guifg=#FF63FF          guibg=#1C1D1F           gui=NONE        "通用预处理命令 #C71585 #FF63FF
    hi        Include        guifg=#FF00FF          guibg=#1C1D1F           gui=NONE        "预处理命令 #include
    hi        Define         guifg=#BF3FBF          guibg=#1C1D1F           gui=NONE        "预处理命令 #define #96CBEF #BF3FBF
    hi        Macro          guifg=#FFFFFF          guibg=#1C1D1F           gui=NONE        "等同于 Define #7F00BF
    hi        PreCondit      guifg=#FF007F          guibg=#1C1D1F           gui=NONE        "预处理命令 #if,#else,#endif
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Type           guifg=#96CBFE          guibg=#1C1D1F           gui=NONE        "int,long,char 等 #96CBFE #00C000
    hi        StorageClass   guifg=#B6B7EB          guibg=#1C1D1F           gui=NONE        "static,register,volatile 等 #7FFF00 #B6B7EB
    hi        Structure      guifg=#00FF7F          guibg=#1C1D1F           gui=NONE        "struct,union,enum 等
    hi        Typedef        guifg=#3FFF3F          guibg=#1C1D1F           gui=NONE        "一个typedef
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Special        guifg=#BFBF3F          guibg=#1C1D1F           gui=NONE        "任何特殊符号
    hi        SpecialChar    guifg=#FFBF3F          guibg=#1C1D1F           gui=NONE        "常数中的特殊字符
    hi        Tag            guifg=#BFFF3F          guibg=#1C1D1F           gui=NONE        "这里可以使用 CTRL-]
    hi        Delimiter      guifg=#FF3F00          guibg=#1C1D1F           gui=NONE        "需要注意的字符
    hi        SpecialComment guifg=#FF00BF          guibg=#1C1D1F           gui=NONE        "注释里的特殊字符 #FF00BF
    hi        Debug          guifg=#BF00FF          guibg=#1C1D1F           gui=NONE        "调试语句
    "-----------------------------------------------------------------------------------------------------------------------"
    hi        Underlined     guifg=#3F3FFF          guibg=#1C1D1F           gui=UNDERLINE   "需要突出的文本,HTML 链接
    hi        Ignore         guifg=#7F7F7F          guibg=#1C1D1F           gui=NONE        "留空,被隐藏
    hi        Error          guifg=#CFCFCF          guibg=#CF6C6C           gui=NONE        "任何有错的构造
    hi        Todo           guifg=#FFFFFF          guibg=#0000FF           gui=NONE        "任何需要特殊注意的部分
    "-----------------------------------------------------------------------------------------------------------------------"
    "   hi        HtmlTagN       guifg=#7F7F7F          guibg=#1C1D1F           gui=NONE        "HtmlTagN
    "   hi        cssStyle       guifg=#008B8B          guibg=#1C1D1F           gui=NONE        "cssStyle
    "   hi        phpLabel       guifg=#008B8B          guibg=#1C1D1F           gui=NONE        "phpLabel
    "======================================================================================================================="
    "   html,css,php highlight
    "   hi        cssAttributeSelector    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        cssDefinition    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        cssFontDescriptorBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        cssLength    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        cssMediaBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        cssMediaComma  guifg=#008B8B          guibg=#1C1D1F           gui=NONE        "css逗号
    hi        cssPseudoClass guifg=#008B8B          guibg=#1C1D1F           gui=NONE        "css伪类符号
    hi        cssSpecialCharQ    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        cssSpecialCharQQ    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        cssString    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        cssStringQ    guifg=#F4E3DC    guibg=#808080    gui=NONE                      "css 字体单引号扩起来,src单引号
    hi        cssStringQQ    guifg=#F4E3DC    guibg=#808080    gui=NONE                     "css 字体双引号扩起来,src双引号
    "   hi        cssStyle    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        cssURL         guifg=#BAB5C9          guibg=#1C1D1F           gui=NONE        "css url color
    "   hi        htmlBold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlBoldItalic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlBoldItalicUnderline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlBoldUnderline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlBoldUnderlineItalic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlItalic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlItalicBold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlItalicBoldUnderline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlItalicUnderline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlItalicUnderlineBold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlPreAttr    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    hi        htmlString     guifg=#D7CDE4          guibg=#1C1D1F           gui=NONE        "HTML string,html的属性,""里面的
    "   hi        htmlStyleArg    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlTagN    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlUnderline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlUnderlineBold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlUnderlineBoldItalic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlUnderlineItalic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlUnderlineItalicBold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        htmlValue    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptCommentSkip    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptNumber    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptParens    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptRegexpString    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptStringD    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptStringS    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        javaScriptValue    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpArrayComma    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpArrayRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpArrayRegionSimple    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpBacktick    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpBlockRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpBracketRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpCaseRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpCatchBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpCatchRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpClassBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpClassStart    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpConstructRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineClassBlockCommentOneline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineClassImplementsComma    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineClassImplementsCommentOneLine    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineClassImplementsName    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineClassName    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineFuncBlockCommentOneline    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineFuncName    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineFuncProto    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineInterfaceName    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDefineMethodName    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDoBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpDoWhileConstructRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpEchoRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpErraticBracketRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldCatch    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldClass    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldFunction    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldHtmlInside    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldInterface    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFoldTry    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpForRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpForeachRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpFuncBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpHereDoc    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpIdentifierComplex    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpIdentifierInString    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpIdentifierInStringComplex    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpIdentifierInStringErratic    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpLabel    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpListComma    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpListRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpMemberHere    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpMethodHere    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpMethodsVar    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGArrayComma    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGArrayOpenParent    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGArrayRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGArrayStringDouble    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGArrayStringSingle    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGOpenParentMulti    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGRegionMulti    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGStringDouble    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGStringSingle    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPREGStringStarter    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpParentRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPropertyHere    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpPropertyInString    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpProtoArray    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpQuoteDouble    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpQuoteSingle    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpRegionAsp    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpRegionSc    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpRegionSync    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSpecialCharfold    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStatementRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStaticAccess    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStaticCall    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStaticUsage    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStaticVariable    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStringDouble    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStringDoubleConstant    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStringRegular    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStringSingle    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpStructureHere    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSwitchBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSwitchConstructRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSyncComment    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSyncStartOfFile    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpSyncString    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpTernaryRegion    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        phpTryBlock    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregClassEscapeDouble2    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregClassEscapeMainQuote    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregConcat    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregEscapeMainQuote    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregNonSpecial    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregNonSpecialEscape    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregNonSpecial_D    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregNonSpecial_S    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregPattern    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregPattern_D    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        pregPattern_S    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        sqlString    guifg=#800000    guibg=#00FF00    gui=NONE
    "   hi        vbString    guifg=#800000    guibg=#00FF00    gui=NONE
elseif &t_Co == 256
    "Console xterm 256
    "   =======================================================================================================================
    hi        Cursor         ctermfg=black            ctermbg=lightyellow       cterm=BOLD        "光标所在的字符
    hi        CursorColumn   ctermfg=black            ctermbg=darkgrey          cterm=BOLD        "光标所在的屏幕列
    hi        CursorLine     ctermfg=black            ctermbg=lightblue          cterm=NONE        "光标所在的屏幕行
    hi        CursorLineNr   ctermfg=white            ctermfg=red               cterm=BOLD        "光标所在的行号
    hi        ColorColumn    ctermfg=lightgrey        ctermbg=white             cterm=BOLD        "高亮光标所在列.
    hi        Directory      ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "目录名
    hi        DiffAdd        ctermfg=grey             ctermbg=lightblue         cterm=BOLD        "diff: 增加的行
    hi        DiffChange     ctermfg=darkgrey         ctermbg=lightcyan         cterm=BOLD        "diff: 改变的行
    hi        DiffDelete     ctermfg=grey             ctermbg=lightred          cterm=BOLD        "diff: 删除的行
    hi        DiffText       ctermfg=red              ctermbg=black             cterm=BOLD        "diff: 改变行里的改动文本
    hi        ErrorMsg       ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "命令行上的错误信息
    hi        VertSplit      ctermfg=darkcyan         ctermbg=lightblue         cterm=BOLD        "分离垂直分割窗口的列
    hi        Folded         ctermfg=lightgrey        ctermbg=darkgreen        cterm=BOLD        "用于关闭的折叠的行
    hi        IncSearch      ctermfg=darkred          ctermbg=lightgrey         cterm=BOLD        "'incsearch' 高亮
    hi        LineNr         ctermfg=darkgrey         ctermbg=black             cterm=BOLD        "置位 number 选项时的行号
    hi        MatchParen     ctermfg=lightred         ctermbg=black             cterm=BOLD        "配对的括号
    hi        MatchParen     ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "配对的括号
    hi        ModeMsg        ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "showmode 消息(INSERT)
    hi        MoreMsg        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "|more-prompt|
    hi        NonText        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "窗口尾部的'~'和 '@'
    hi        Normal         ctermfg=lightgrey        ctermbg=black             cterm=none        "正常内容
    hi        Pmenu          ctermfg=darkgrey         ctermbg=lightgrey         cterm=BOLD        "弹出菜单普通项目
    hi        PmenuSel       ctermfg=lightcyan        ctermbg=lightred          cterm=BOLD        "弹出菜单选中项目
    hi        PmenuSbar      ctermfg=lightblue        ctermbg=lightyellow       cterm=BOLD        "弹出菜单滚动条.
    hi        PmenuThumb     ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "弹出菜单滚动条的拇指
    hi        Question       ctermfg=yellow           ctermbg=black             cterm=BOLD        "提示和 yes/no 问题
    hi        Search         ctermfg=red              ctermbg=white             cterm=BOLD        "最近搜索模式的高亮
    hi        SpecialKey     ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "特殊键,字符和'listchars'
    hi        SpellBad       ctermfg=lightred         ctermbg=black             cterm=BOLD        "拼写检查器不能识别的单词
    hi        SpellCap       ctermfg=lightred         ctermbg=black             cterm=BOLD        "应该大写字母开头的单词
    hi        SpellLocal     ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "只在其它区域使用的单词
    hi        SpellRare      ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "很少使用的单词
    "hi        StatusLine     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "当前窗口的状态行
    "hi        StatusLineNC   ctermfg=yellow           ctermbg=black             cterm=BOLD        "非当前窗口的状态行
    hi        TabLine        ctermfg=black            ctermbg=black             cterm=BOLD        "非活动标签页标签
    hi        TabLineFill    ctermfg=black            ctermbg=lightgrey         cterm=BOLD        "没有标签的地方
    hi        TabLineSel     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "活动标签页标签
    hi        Title          ctermfg=darkcyan         ctermbg=black             cterm=BOLD        ":set all 等输出的标题
    hi        Visual         ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "可视模式的选择区
    hi        WarningMsg     ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "警告消息
    hi        WildMenu       ctermfg=lightgreen       ctermbg=lightblue         cterm=BOLD        "wildmenu补全的当前匹配
    "   =======================================================================================================================
    "   "Console group-name
    "   =======================================================================================================================
    hi        Comment        ctermfg=darkgrey         ctermbg=black             cterm=BOLD        "任何注释
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Constant       ctermfg=brown            ctermbg=black             cterm=NONE        "任何常数
    hi        String         ctermfg=grey             ctermbg=black             cterm=NONE        "一个字符串常数:字符串
    hi        Character      ctermfg=grey             ctermbg=black             cterm=NONE        "一个字符常数: 'c','\n'
    hi        Number         ctermfg=lightblue        ctermbg=black             cterm=NONE        "一个数字常数: 234,0xff
    hi        Float          ctermfg=lightblue        ctermbg=black             cterm=NONE        "一个浮点常数: 2.3e10
    hi        Boolean        ctermfg=grey             ctermbg=black             cterm=NONE        "一个布尔型常数: TRUE,false
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Identifier     ctermfg=lightgreen       ctermbg=black             cterm=NONE        "任何变量名
    hi        Function       ctermfg=lightcyan        ctermbg=black             cterm=NONE        "函数名 (也包括: 类的方法名)
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Statement      ctermfg=yellow           ctermbg=black             cterm=NONE        "任何语句
    hi        Conditional    ctermfg=yellow           ctermbg=black             cterm=NONE        "if,then,else,endif,switch
    hi        Repeat         ctermfg=yellow           ctermbg=black             cterm=NONE        "for,do,while 等
    hi        Label          ctermfg=yellow           ctermbg=black             cterm=NONE        "case,default 等
    hi        Operator       ctermfg=yellow           ctermbg=black             cterm=NONE        ""sizeof","+","*" 等
    hi        Keyword        ctermfg=yellow           ctermbg=black             cterm=NONE        "任何其它关键字
    hi        Exception      ctermfg=lightred         ctermbg=black             cterm=NONE        "try,catch,throw
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        PreProc        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "通用预处理命令
    hi        Include        ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "预处理命令 #include
    hi        Define         ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "预处理命令 #define
    hi        Macro          ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "等同于 Define
    hi        PreCondit      ctermfg=lightred         ctermbg=black             cterm=BOLD        "预处理命令 #if,#else,#endif
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Type           ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "int,long,char 等
    hi        StorageClass   ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "static,register,volatile 等
    hi        Structure      ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "struct,union,enum 等
    hi        Typedef        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "一个 typedef
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Special        ctermfg=brown            ctermbg=black             cterm=BOLD        "任何特殊符号
    hi        SpecialChar    ctermfg=brown            ctermbg=black             cterm=BOLD        "常数中的特殊字符
    hi        Tag            ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "这里可以使用 CTRL-]
    hi        Delimiter      ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "需要注意的字符
    hi        SpecialComment ctermfg=lightred         ctermbg=black             cterm=BOLD        "注释里的特殊字符
    hi        Debug          ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "调试语句
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Underlined     ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "需要突出的文本,HTML 链接
    hi        Ignore         ctermfg=darkgrey         ctermbg=black             cterm=NONE        "留空,被隐藏
    hi        Error          ctermfg=yellow           ctermbg=lightred          cterm=BOLD        "任何有错的构造
    hi        Todo           ctermfg=lightgrey        ctermbg=lightblue         cterm=BOLD        "任何需要特殊注意的部分
    "   =======================================================================================================================
else
    "Console xterm 8
    hi        Cursor         ctermfg=black            ctermbg=lightyellow       cterm=BOLD        "光标所在的字符
    hi        CursorColumn   ctermfg=black            ctermbg=darkgrey          cterm=BOLD        "光标所在的屏幕列
    hi        CursorLine     ctermfg=black            ctermbg=lightblue          cterm=NONE        "光标所在的屏幕行
    hi        CursorLineNr   ctermfg=white            ctermfg=red               cterm=BOLD        "光标所在的行号
    hi        ColorColumn    ctermfg=lightgrey        ctermbg=white             cterm=BOLD        "高亮光标所在列.
    hi        Directory      ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "目录名
    hi        DiffAdd        ctermfg=grey             ctermbg=lightblue         cterm=BOLD        "diff: 增加的行
    hi        DiffChange     ctermfg=darkgrey         ctermbg=lightcyan         cterm=BOLD        "diff: 改变的行
    hi        DiffDelete     ctermfg=grey             ctermbg=lightred          cterm=BOLD        "diff: 删除的行
    hi        DiffText       ctermfg=red              ctermbg=black             cterm=BOLD        "diff: 改变行里的改动文本
    hi        ErrorMsg       ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "命令行上的错误信息
    hi        VertSplit      ctermfg=darkcyan         ctermbg=lightblue         cterm=BOLD        "分离垂直分割窗口的列
    hi        Folded         ctermfg=lightgrey        ctermbg=lightgreen        cterm=BOLD        "用于关闭的折叠的行
    hi        IncSearch      ctermfg=darkred          ctermbg=lightgrey         cterm=BOLD        "'incsearch' 高亮
    hi        LineNr         ctermfg=darkgrey         ctermbg=black             cterm=BOLD        "置位 number 选项时的行号
    hi        MatchParen     ctermfg=lightred         ctermbg=black             cterm=BOLD        "配对的括号
    hi        MatchParen     ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "配对的括号
    hi        ModeMsg        ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "showmode 消息(INSERT)
    hi        MoreMsg        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "|more-prompt|
    hi        NonText        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "窗口尾部的'~'和 '@'
    hi        Normal         ctermfg=lightgrey        ctermbg=black             cterm=NONE        "正常内容
    hi        Pmenu          ctermfg=darkgrey         ctermbg=lightgrey         cterm=BOLD        "弹出菜单普通项目
    hi        PmenuSel       ctermfg=lightcyan        ctermbg=lightred          cterm=BOLD        "弹出菜单选中项目
    hi        PmenuSbar      ctermfg=lightblue        ctermbg=lightyellow       cterm=BOLD        "弹出菜单滚动条.
    hi        PmenuThumb     ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "弹出菜单滚动条的拇指
    hi        Question       ctermfg=yellow           ctermbg=black             cterm=BOLD        "提示和 yes/no 问题
    hi        Search         ctermfg=red              ctermbg=white             cterm=BOLD        "最近搜索模式的高亮
    hi        SpecialKey     ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "特殊键,字符和'listchars'
    hi        SpellBad       ctermfg=lightred         ctermbg=black             cterm=BOLD        "拼写检查器不能识别的单词
    hi        SpellCap       ctermfg=lightred         ctermbg=black             cterm=BOLD        "应该大写字母开头的单词
    hi        SpellLocal     ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "只在其它区域使用的单词
    hi        SpellRare      ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "很少使用的单词
    "hi        StatusLine     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "当前窗口的状态行
    "hi        StatusLineNC   ctermfg=yellow           ctermbg=black             cterm=BOLD        "非当前窗口的状态行
    hi        TabLine        ctermfg=black            ctermbg=black             cterm=BOLD        "非活动标签页标签
    hi        TabLineFill    ctermfg=black            ctermbg=lightgrey         cterm=BOLD        "没有标签的地方
    hi        TabLineSel     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "活动标签页标签
    hi        Title          ctermfg=darkcyan         ctermbg=black             cterm=BOLD        ":set all 等输出的标题
    hi        Visual         ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "可视模式的选择区
    hi        WarningMsg     ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "警告消息
    hi        WildMenu       ctermfg=lightgreen       ctermbg=lightblue         cterm=BOLD        "wildmenu补全的当前匹配
    "   =======================================================================================================================
    "   "Console group-name
    "   =======================================================================================================================
    hi        Comment        ctermfg=darkgrey         ctermbg=black             cterm=BOLD        "任何注释
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Constant       ctermfg=brown            ctermbg=black             cterm=NONE        "任何常数
    hi        String         ctermfg=grey             ctermbg=black             cterm=NONE        "一个字符串常数:字符串
    hi        Character      ctermfg=grey             ctermbg=black             cterm=NONE        "一个字符常数: 'c','\n'
    hi        Number         ctermfg=lightblue        ctermbg=black             cterm=NONE        "一个数字常数: 234,0xff
    hi        Float          ctermfg=lightblue        ctermbg=black             cterm=NONE        "一个浮点常数: 2.3e10
    hi        Boolean        ctermfg=grey             ctermbg=black             cterm=NONE        "一个布尔型常数: TRUE,false
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Identifier     ctermfg=lightgreen       ctermbg=black             cterm=NONE        "任何变量名
    hi        Function       ctermfg=lightcyan        ctermbg=black             cterm=NONE        "函数名 (也包括: 类的方法名)
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Statement      ctermfg=yellow           ctermbg=black             cterm=NONE        "任何语句
    hi        Conditional    ctermfg=yellow           ctermbg=black             cterm=NONE        "if,then,else,endif,switch
    hi        Repeat         ctermfg=yellow           ctermbg=black             cterm=NONE        "for,do,while 等
    hi        Label          ctermfg=yellow           ctermbg=black             cterm=NONE        "case,default 等
    hi        Operator       ctermfg=yellow           ctermbg=black             cterm=NONE        ""sizeof","+","*" 等
    hi        Keyword        ctermfg=yellow           ctermbg=black             cterm=NONE        "任何其它关键字
    hi        Exception      ctermfg=lightred         ctermbg=black             cterm=NONE        "try,catch,throw
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        PreProc        ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "通用预处理命令
    hi        Include        ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "预处理命令 #include
    hi        Define         ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "预处理命令 #define
    hi        Macro          ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "等同于 Define
    hi        PreCondit      ctermfg=lightred         ctermbg=black             cterm=BOLD        "预处理命令 #if,#else,#endif
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Type           ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "int,long,char 等
    hi        StorageClass   ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "static,register,volatile 等
    hi        Structure      ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "struct,union,enum 等
    hi        Typedef        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "一个 typedef
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Special        ctermfg=brown            ctermbg=black             cterm=BOLD        "任何特殊符号
    hi        SpecialChar    ctermfg=brown            ctermbg=black             cterm=BOLD        "常数中的特殊字符
    hi        Tag            ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "这里可以使用 CTRL-]
    hi        Delimiter      ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "需要注意的字符
    hi        SpecialComment ctermfg=lightred         ctermbg=black             cterm=BOLD        "注释里的特殊字符
    hi        Debug          ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "调试语句
    "   -----------------------------------------------------------------------------------------------------------------------
    hi        Underlined     ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "需要突出的文本,HTML 链接
    hi        Ignore         ctermfg=darkgrey         ctermbg=black             cterm=NONE        "留空,被隐藏
    hi        Error          ctermfg=yellow           ctermbg=lightred          cterm=BOLD        "任何有错的构造
    hi        Todo           ctermfg=lightgrey        ctermbg=lightblue         cterm=BOLD        "任何需要特殊注意的部分
    "   =======================================================================================================================
endif
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  11 => Key Shortcuts {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{                                         " all shortcuts
" :s/^/#                                    " 用'#'注释当前行
" :2,50s/^ /#                               " 在2~50行首添加'#'注释
" :2,50s/$/#                                " 在2~50末加'#'
" :.,+3s/^/#                                " 用'#'注释当前行和当前行后面的三行
" :%s/^/#                                   " 用'#'注释所有行
" :n1,n2s/^/#/g                             " 用'#'注释n1~n2行,下面为删除
" :n1,n2s/#/^/g                             " :n1,n2s/^/#/g   :n1,n2s/#^//g
" :n1,n2s/\\$//g                            " 删除行末 \ 
" :n1,n2s/^/\/\//g                          " 用//注释n1~n2
" :n1,n2s/\/\///g                           " 删除//的注释
" :g/keywords/d                             " 删除所有含有keywords的行
" :v/error\|warn\|fail/d                    " 删除不含有error,warn,fail的行, v=g!, :%g!/error\|warn\|fail/d
" :n1,n2s/^I/','/g                          " 把tab替换成','
" :%s/^\s\+//g                              " 删除行首空格
" :%s/\s\+$//g                              " 删除行末空格 要转义斜杠等, 用\,而+ |转义用\\
" :g/^$/d                                   " 删除没有内容的空行
" :g/^\s*$/d                                " 删除有空格组成的空格
" :%s///g                                 " 删除行末^M的符号
" :%s/^\n\+/\r/                             " 压缩多行空行为一行 2013-11-26 15:42:58
" :%s/keywords//n                           " 统计关键字出现的次数
" :                                         " 把正则用\( \) 扩起来后, 后面替换的时候可以用\1 \2来引用对应的正则
" : 将 Doe, John 修改为 John Doe   :%s/\(\w\+\), \(\w\+\)/\2 \1/
" :s/替换字符串/\=函数式                    " 函数式可以有多个,返回值可以用字符串连接符.连接起来,如line('.') 返回匹配行号(:help line()  ),submatch(n)可以引用\1,\2的内容,其中submatch(0)引用匹配的整个内容;
"                                           " 函数式也可以是字符串常量,用双引号引起来.函数式也可以是任意表达式,需要用小括号引起来,如(3+2*6);
"                                           " 函数式还可以是寄存器中的内容,通过'@寄存器名'访问,如@a(不需要加引号,但是还是需要用.来连接)
":%s/\(.*\) \(.*\)/\1+\2/                   " 把行尾的空格替换成+号
" :noh                                      " 取消搜索高亮
" :%!nl -ba                                 " 对包含空行的所有行进行编号.
" gf                                        " 在鼠标下打开当前路径的文件
" <c-w>f                                    " open in a new window
" <c-w>gf                                   " open in a new tab
" :n1,n2 co n3                              " copy n1~n2 to under the n3
" :n1,n2 m n3                               " move n1~n2 to under the n3
" :n1,n2 w filename                         " save n1~n2 to filename
" n+   n-                                   " 光标移动多少行
" n$                                        " 光标移至第n行尾
" 0 $                                       " 光标移至当前行首 当前行尾
" H M L                                     " 光标移至 屏幕顶行 中间行 屏幕最后行
" ctrl+u ctrl+d                             " 向文件首(尾) 翻半屏
" ctrl+f ctrl+b                             " 向文件首(尾) 翻一屏
" nz                                        " 将第n行滚至屏幕顶部,不指定n时将当前行滚至屏幕顶
" :g/^/exe ":s/^/".line(".")                " 每行插入行号
" :g/<input|<form/p                         " 显示含<input或<form的行
" :bufdo /searchstr                         " 在多个buff中搜索
" :argdo /searchstr
" xp   ddp                                  " 交换前后两个字符的位置 上下两行的位置交换
" `,<C-O> <C-I>                             " 跳转足迹 回跳(从最近的一次开始) 向前跳
" :gg=G                                     " 格式化, ggVG =
"reg                                        " /d      digit                   [0-9]
"reg                                        " /D      non-digit               [^0-9]
"reg                                        " /x      hex digit               [0-9a-fA-F]
"reg                                        " /X      non-hex digit           [^0-9a-fA-F]
"reg                                        " /s      white space             [       ]     (<Tab> and <Space>)
"reg                                        " /S      non-white characters    [^      ]     (not <Tab> and <Space>)
"reg                                        " /l      lowercase alpha         [a-z]
"reg                                        " /L      non-lowercase alpha     [^a-z]
"reg                                        " /u      uppercase alpha         [A-Z]
"reg                                        " /U      non-uppercase alpha     [^A-Z]
" m a   (MARK)                              " 把这个地方标示成a    a can replace from (a~z)
" 'a    (quote character)                   " jump to aaa
" ''    (press ' twice)                     " 移动光标到上一个标记
" {                                         " jump to  跳到上一段的开头
" }                                         " jump to  跳到下一段的的开头.
" (                                         " 移到这个句子的开头
" )                                         " 移到下一个句子的开头
" [[                                        " 跳往上一个函式, [{ Jump to block start.
" ]]                                        " 跳往下一个函式
" `.                                        " 移动光标到上一次的修改点
" '.                                        " 移动光标到上一次的修改行
" <shift-c>                                 " 删除到行末并直接进入插入模式
" %                                         " 跳到匹配的左/右括号上
" zz                                        " 移动当前行到屏幕中央
" zt                                        " 移动当前行到屏幕顶部
" zb                                        " 移动当前行到屏幕底部
" <shift- ↓/↑>                            " 整屏翻,光标位置在屏幕位置不变
" *                                         " 读取光标处的字符串,并且移动光标到它再次出现的地方, n下一个匹配,N反方向
" #                                         " 和上面的类似,但是是往反方向寻找
" g*(g#)                                    " 此命令与上条命令相似, 只不过它不完全匹配光标所在处的单词, 而是匹配包含该单词的所有字符串
" guu                                       " 行小写
" gUU                                       " 行大写
" g~~                                       " 行翻转(大小写)
" guw gUw g~w                               " 字*写
" ]p                                        " 类似p, 但是会自动调整被粘贴的文本适应缩进
" gd                                        " 到达光标所在处函数或者变量的定义处
" \'.                                       " 跳到最后修改的那一行
" `.                                        " 跳到最后修改的那一行,定位到修改点
" :ju(mps)                                  " 列出跳转足迹
" !!date                                    " 读取date的输出 (但是会替换当前行的内容) :r!date 输出系统时间. :r!date \+\%F\ \%T 格式化输出
" :bn                                       " 跳转到下一个buffer
" :bp                                       " 跳转到上一个buffer
" :wn                                       " 存盘当前文件并跳转到下一个
" :wp                                       " 存盘当前文件并跳转到上一个
" :bd                                       " 把这个文件从buffer列表中做掉
" :b 3                                      " 跳到第3个buffer
" :b main                                   " 跳到一个名字中包含main的buffer,例如main.c
" :sav php.html                             " 把当前文件存为php.html并打开php.html
" :sav! %<.bak                              " 换一个后缀保存
" :e!                                       " 返回到修改之前的文件(修改之后没有存盘)
" :w !sudo tee > /dev/null %                " save as root
" :w /path/%                                " 把文件存到一个地儿
" :rew                                      " 回到第一个可编辑的文件
" :brew                                     " 回到第一个buffer
" :ls                                       " 显示所有buffer :help :buffers
" buffer其他                                " :bdelete filename 删除指定buffer;  有:b 和:sb 组合first,rewind,next,prvious,Next,last 例如:bfirst,:sbfirst
"                                           "     还可以组合all, unhide, modified, bdelete
"                                           " :bwipeout 清除所有buffer
" gvim -o file1 file2                       " 以分割窗口打开两个文件\r\n# 指出打开之后执行的命令
" gvim -d file1 file2                       " vimdiff (比较不同)
"                                           "    ]c 跳转下一个差异点 :diffget 把另外一个文件的差异点的内容复制过来  :diffput 把当前差异点的内容复制过去. :diffupdate 更多比较文件
"                                           "    前面加行号表示多少行开始  :2,30diffget 把2~30行的差异取过来
" c{ motion }                               " 删除motion命令跨过的,并且进入插入 c$删到行尾的并进入插入,ct! 删除从光标位到下一个!位置
" dp                                        " 把光标处的不同放到另一个文件
" do                                        " 在光标处从另一个文件取得不同
" diw                                       " 删除光标上的单词 (不包括空白字符)
" daw                                       " 删除光标上的单词 (包括空白字符)
" dl                                        " delete character (alias: x)
" diw                                       " delete inner word
" daw                                       " delete a word
" diW                                       " delete inner WORD (see |WORD|)
" daW                                       " delete a WORD (see |WORD|会删除掉单词和其后的空格)
" dd                                        " delete one line
" dis                                       " delete inner sentence
" das                                       " delete a sentence
" dib                                       " delete inner '(' ')'
" dab                                       " delete a '(' ')'
" dip                                       " delete inner paragraph
" dap                                       " delete a paragraph  p是段落
" diB                                       " delete inner '{' '}'
" daB                                       " delete a '{' '}'
" d ↓                                      " delete 完整的一个语句
" di[ di( di大括号 di< di' di" di`          " 删除一对()[]大括号 '' "" ``的内容
" ci[ ci( ci大括号 ci< ci' ci" ci`          " 删除并插入一对()[]大括号 '' "" ``的内容
" vi[ vi( vi大括号 vi< vi' vi" vi`          " 编辑一对()[]大括号 '' "" ``的内容
" :1,20s/^/#/g                              " 添加注释  :1,20s/^/\/\//g
" 0                                         " 至本行第一个字符=<Home>
" ^                                         " 至本行第一个非空白字符
" N $                                       " 至本行最后一个字符
" gm                                        " 至屏幕行中点(当前行中点)
" N |                                       " 至第 N 列 (缺省: 1)
" N  f{char}                                " 至右边第 N 次出现 {char} 之处 (find)
" N  F{char}                                " 至左边第 N 次出现 {char} 之处 (Find)
" N  t{char}                                " 至右边第 N 次出现 {char} 之前 (till)
" N  T{char}                                " 至左边第 N 次出现 {char} 之前 (Till)
" N  ;                                      " 重复上次 f,F,t 或 T 命令 N 次
" N  ,                                      " 以相反方向重复上次 f,F,T 或 t 命令 N
" N  -                                      " 上移 N 行,至第一个非空白字符
" N  +                                      " 下移 N 行,至第一个非空白字符 (亦: CTRL-M 和 <CR>)
" N  _                                      " 下移 N - 1 行,至第一个非空白字符
" N  G                                      " 至第 N 行 (缺省: 末行) 第一个非空白字符
" N  gg                                     " 至第 N 行 (缺省: 首行) 第一个非空白字符
" N  %                                      " 至全文件行数百分之 N 处;必须给出 N,否则是 |%| 命令
" N  gk                                     " 上移 N 屏幕行 (回绕行时不同于 k)
" N  gj                                     " 下移 N 屏幕行 (回绕行时不同于 j)
" N  w                                      " 向前 (正向,下同) N 个单词(word)
" N  W                                      " 向前 N 个空白隔开的字串 |WORD|            (WORD)
" N  e                                      " 向后至第 N 个单词词尾/ ge是前跳词尾                     (end)
" N  E                                      " 向前至第 N 个空白隔开的字串 |WORD| 的词尾 (End)
" N  b                                      " 向后 (反向,下同) N 个单词                (backward)
" N  B                                      " 向后至第 N 个空白隔开的字串 |WORD| 的词尾 (Backward)
" N  ge                                     " 向后至第 N 个单词词尾
" N  gE                                     " 向后至第 N 个空白隔开的字串 |WORD| 的词尾
" N  )                                      " 向前 N 个句子
" N  (                                      " 向后 N 个句子
" N  }                                      " 向前 N 个段落
" N  {                                      " 向后 N 个段落
" N  ]]                                     " 向前 N 个小节,置于小节的开始
" N  [[                                     " 向后 N 个小节,置于小节的开始
" N  ][                                     " 向前 N 个小节,置于小节的末尾
" N  []                                     " 向后 N 个小节,置于小节的末尾
" N  [(                                     " 向后至第 N 个未闭合的 '('
" N  [{                                     " 向后至第 N 个未闭合的 '{'
" N  [m                                     " 向后至第 N 个方法 (method) 的开始 (用于 Java)
" N  [M                                     " 向后至第 N 个方法的结束 (Method)  (用于 Java)
" N  ])                                     " 向前至第 N 个未闭合的 ')'
" N  ]}                                     " 向前至第 N 个未闭合的 '}'
" N  ]m                                     " 向前至第 N 个方法 (method) 的开始 (用于 Java)
" N  ]M                                     " 向前至第 N 个方法的结束 (Method)  (用于 Java)
" N  [#                                     " 向后至第 N 个未闭合的 #if 或 #else
" N  ]#                                     " 向前至第 N 个未闭合的 #else 或 #endif
" N  [*                                     " 向后至第 N 个注释的开始 /*
" N  ]*                                     " 向前至第 N 个注释的结束 */
" a
" N  ]*                                     " 向前至第 N 个注释的结束 */
" .                                         " 匹配任意单个字符
" ^                                         " 匹配行首
" $                                         " 匹配<EOL>
" \<                                        " 匹配单词开始 /\<aaa/ 只匹配aaa开头的,
" \>                                        " 匹配单词结束 /\<aaa\>/ 只匹配aaa开头,结尾的.
" [a-z]  \[a-z]                             " 匹配单个设定范围的字符
" [^a-z] \[^a-z]                            " 同上..不匹配
" \s                                        " 匹配一个空白字符
" \S                                        " 匹配一个非空字符
" \e                                        " 匹配<Esc>
" \t                                        " 匹配<Tab>
" \r                                        " 匹配<CR>
" \b                                        " 匹配<BS> backspace
" * \*                                      " 匹配0或者多个前面的匹配原
" \+                                        " 匹配1或者多个前面的匹配原
" \=                                        " 匹配0或者1个前面的匹配原
" \{2,5}                                    " 匹配2至5个前面的匹配原
" \|                                        " 隔开两种可替换的匹配
" \(\)                                      " 组合模式为当匹配原
" ;{search-command}                         " 接着执行 {search-command} 查找命令
" m{a-zA-Z}                                 " 用标记 {a-zA-Z} 记录当前位置
" `{a-z}                                    " 至当前文件中的标记 {a-z}
" `{A-Z}                                    " 至任何文件中的标记 {A-Z}
" `{0-9}                                    " 至 Vim 上次退出的位置
" ``                                        " 至上次跳转之前的位置
" `"                                        " 至上次编辑此文件的位置
" `[                                        " 至上次被操作或放置的文本的开始
" `]                                        " 至上次被操作或放置的文本的结尾
" `<                                        " 至 (前次) 可视区域的开始
" `>                                        " 至 (前次) 可视区域的结尾
" `.                                        " 至当前文件最后被改动的位置
" '{a-zA-Z0-9[]'"<>.}                       " 同 `,但同时移动至该行的第一个非空白字符
" :marks                                    " 列出活动的标记
" N  ctrl+O                                 " 跳转到跳转表中第 N 个较早的位置
" N  ctrl+I                                 " 跳转到跳转表中第 N 个较晚的位置
" :ju[mps]                                  " 列出跳转表
" R                                         " 覆盖插入.批量.
" r                                         " 单次覆盖插入,gr
" i ctrl+E                                  " 插入光标下方的字符
" i ctrl+Y                                  " 插入光标上方的字符
" i ctrl+A                                  " 插入上次插入的文本
" i ctrl+@                                  " 插入上次插入的文本并结束插入模式
" i ctrl+R {0-9a-z%#:.-="}                  " 插入寄存器的内容
" i ctrl+N                                  " 将下一个匹配的标识符插入光标前
" i ctrl+P                                  " 将上一个匹配的标识符插入光标前
" i ctrl+H                                  " 删除光标前的一个字符 = <BS>
" i <Del>                                   " 删除光标下的一个字符
" i ctrl+W                                  " 删除光标前的一个单词
" i ctrl+U                                  " 删除当前行的所有字符
" i ctrl+T                                  " 在当前行首插入一个移位宽度的缩进
" i ctrl+D                                  " 在当前行首删除一个移位宽度的缩进
" i 0 ctrl+D                                " 删除当前行的所有缩进
" i ^ ctrl+D                                " 删除当前行的所有缩进,恢复下一行的缩进
" :dig                                      " 显示当前二合字母列表
" i ctrl+k {char1} {char2}                  " 键入二合字母
" N D                                       " 删除至行尾
" N J                                       " 连接N-1行
" N gJ                                      " 同J,但不插入空格
" N ~                                       " 翻转N个字符的大小写并前进光标
" N ctrk+A                                  " 将光标之上或之后的数值增加 N
" N ctrl+X                                  " 将光标之上或之后的数值减少 N
" v o                                       " 交换高亮区域(可视)的开始处的光标位置
" N  aw                                     " 选择 一个单词
" N  iw                                     " 选择 内含单词
" N  aW                                     " 选择 一个字串
" N  iW                                     " 选择 内含字串
" :ciw                                      " 修改一个单词
" N  as                                     " 选择 一个句子
" N  is                                     " 选择 内含句子
" N  ap                                     " 选择 一个段落
" N  ip                                     " 选择 内含段落
" N  ab                                     " 选择 一个块 (从 [( 至 ]))
" N  ib                                     " 选择 内含块 (从 [( 到 ]))
" N  aB                                     " 选择 一个大块 (从 [{ 到 ]})
" N  iB                                     " 选择 内含大块 (从 [{ 到 ]})
" N  a>                                     " 选择 一个 <> 块
" N  i>                                     " 选择 内含 <> 块
" N  at                                     " 选择 一个标签块 (从 <aaa> 到 </aaa>)
" N  it                                     " 选择 内含标签块 (从 <aaa> 到 </aaa>)
" N  a'                                     " 选择 一个单引号字符串
" N  i'                                     " 选择 内含单引号字符串
" N  a"                                     " 选择 一个双引号字符串
" N  i"                                     " 选择 内含双引号字符串
" N  a`                                     " 选择 一个反引号字符串
" N  i`                                     " 选择 内含反引号字符串
" N .                                       " 重复最近一次改动
" q{a-z}                                    " 记录键入的字符,存入寄存器{a-z}
" q{A-Z}                                    " 记录键入的字符,添加进寄存器{a-z}
" q                                         " 终止记录
" N @{a-z}                                  " 执行寄存器{a-z}的内容N次
" N @@                                      " 重复上次的@{a-z}的操作N次
" N gs                                      " 睡N秒
" sl[eep][sec]                              " 在[sec]秒任何事都不做
" :%!xxd                                    " 转换成十六进制
" :%!xxd -r                                 " 转回来
" ga                                        " 以十进制,十六进制,八进制显示当前光标下的字符的ASCII值
" g8                                        " 对 utf-8 编码: 显示光标所在字符的十六进制字节序列
" g CTRL-G                                  " 显示当前光标的列,行,以及字符位置
" g;                                        " 在修改记录中向后选择
" g,                                        " 在修改记录中向前选择
" :ve[rsion]                                " 显示版本信息
" :vimgrep /test/ *                         " 查找当前目录下所有包含test关键字  ** 代表的是递归查找大于100层目录
" :vimgrep /test/ **                        " 递归查找当前目录下所有包含test关键字
" :vimgrep /\<test\>/ **                    " 递归查找当前目录下所有包含只有test关键字,不包括testabc,abctest,abctestabc等等,如果一行有多个test的话,只搜索一个test结果
" :vimgrep /\<test\>/g **                   " 递归查找当前目录下所有包含只有test关键字,不包括testabc,abctest,abctestabc等等,如果一行有多个test的话,搜索多个test结果
" :vimgrep /\<test\>/ *.html                " 查找当前目录下所有的html文件包含只有test关键字,不包括testabc,abctest,abctestabc等等,如果一行有多个test的话,搜索多个test结果
"                                           "  :cnext (:cn) 当前页下一个结果
"                                           "  :cprevious (:cp) 当前页上一个结果
"                                           "  :clist (:cl) 打开quickfix窗口,列出所有结果,不能直接用鼠标点击打开,只能看
"                                           "  :copen (:cope) 打开quickfix窗口,列出所有结果,可以直接用鼠标点击打开
"                                           "  :ccl[ose] 关闭 quickfix 窗口
"                                           "   ctrl + ww 切换编辑窗口和quickfix窗口,在quickfix里面和编辑窗口一样jk表示上下移动,回车选中进入编辑窗口
" vim启动参数
"     -v                                    " vi模式
"     -d                                    " diff模式
"     -b                                    " 二进制模式
"     -l                                    " lisp模式
"     -A                                    " 阿拉伯模式
"     -F                                    " 波斯模式
"     -H                                    " 希伯来模式
"     --noplugin                            " 不加载,无插件模式
"     --startuptime {fname}                 " 启动时把计时信息写入文件 {fname}.可用于分析载入 .vimrc,插件和打开首个文件的过程中时哪一步最耗时
"     -V9debugVimLog                        " 启动时加入debug信息, 可以跟踪vim crash, 
"     :messages                             "  show all crash log, 
"     :echo                                 "  errmsg print recent msg 
" /\Cxxx                                    " 大小写敏感 /\cxxx 搜索xxx不敏感
" vsp                                       " 垂直分割窗口
" sp                                        " 竖向分割窗口
" ctrl w +                                  " 扩大分割窗口
" ctrl w -                                  " 缩小分割窗口
" res no                                    " 让分割的窗口只显示多少行
" ctrl-v I ESC                              " 列插入,选列,I,输入要插入的内容,ESC
" :%norm jkdd                               " 删除基数行 或用global命令 :g/^/d|m
" :%norm jdd                                " 删除偶数行 或:g/^/+1 d
" :%s/0/=eval(line(".")-1)/g                " 生成连续的数字
" :e ++enc=utf-8 filename.txt               " 以指定编码打开文本.
" 其他                                      " :r!pwd 插入当前文本路径 :Ex 开启目录浏览 :ls 显示当前buffer :ju 列出跳转足迹 :his c 命令行历史 :his s 搜索历史 q/ 搜索历史窗口 q:命令历史窗口 :<C-F>历史命令窗口
" ,m                                        " mark
"                                           "  :%!sort -u 使用sort程序排序整个文件  qq录制到q,输入指令,q再次按q停止录制,@q执行q存储的指令,@@重复执行.
"                                           " 修改register  \"ap 把register a的内容粘贴到当前位置,然后修改它, \"add 删除并且重新存入register a, @a 执行寄存器a的指令.
"                                           " \"a5yy 复制5行到register a中, \"A5yy 再添加5行到a中.
"                                           " [I 显示光标处的关键字匹配的行 :g/^/pu 把文中空行扩1倍 :g/^/m0 按行翻转文章 :g/关键字/t$ 拷贝行,从关键字到文件末尾
"                                           " :let @a=@_ 清除寄存器a :let @*=@a 寄存器赋值 :scriptnames 列出所有加载的插件,_vimrcs :verbose set history 显示设置history值并指出设置文件的位置
"                                           " :verbose map<Tab> 可以查看tab键是绑定到什么动作上的, 
"                                           "  Command     Normal      Visual  Operator    Insert      Command_Line
"                                           "  映射命令    常规模式    可视化  运算符模式  插入模式    命令行
"                                           "  :map        y           y       y
"                                           "  :nmap       y
"                                           "  :vmap                   y
"                                           "  :omap                           y
"                                           "  :map!                                       y           y
"                                           "  :imap                                       y
"                                           "  :cmap                                                   y
"                                           "  查看键盘符号:h key-notation
"                                           "  <Esc>=Escape, <CR>=Enter, <S-F1>=Shift+F1,<C>=<Ctrl> Mac:<D>=Command, <M-key>=<A-key>=Alt
"                                           "  :map 查看所有, 第一列内容显示如下, 取消:umap, 取消所有:mapclear
"                                           "      <space> 常规模式,可视化模式,运算符模式
"                                           "      n       常规模式
"                                           "      v       可视化模式
"                                           "      o       运算符模式
"                                           "      !       插入模式,命令行模式
"                                           "      i       插入模式
"                                           "      c       命令模式
"                                           " i<c-r>/ 把最后一个搜索指令贴到当前位置 i<c-r>把最后一个命令贴到当前位置 :X 加密文件
" advanced tips                             " vit 选中a标签里面的文本,高亮选中标签内部的内容.visually select inside the tag
"                                           " A 当前行尾插入,=$a  ;   C是删除当前行尾并插入,=$c    .是重复上一次插入的所有操作
"                                           " s 删除当前字符串并进入插入,=cl; S删除该行有内容的内容,=^c; I=^i;o=A<CR> O=ko
"                                           " 在符号前后加空格 f+ 搜索+号,s<space>+<spance><Esc>这里完成一次添加, ;查找下一次f查找的符号, .重复, ;.重复   ,反查f的符号
"                                           " 修改时, 重复. 回退u ;  行内查找f/t/F/T 重复;回退, ; /?<CR>文档查找 重复n 回退N;  :s/pattern/replacement 执行替换 重复& 回退u ; 执行一系列修改qx{}q
"                                           " <C-a><C-x>对数字执行加和减操作.比如光标在5上,执行10<C-a> 会变成15.如果改行光标不在数字上,直接输入数字<C-a/x>会自动跳在第一个数字上进行对应加减操作.
"                                           "    上面的加减以0开头的数字会默认以八进制来计算,如果需要以十进制,需要set nrformats=    如果要查找设置的参数值,用set xxx?来获取设置值 set xxx&为设置为默认值
"                                           "  插入模式下 <C-h>删除前一个字符(等于退格键);<C-w>删除前一个单词;<C-u>删至行首; 该命令也可在bash中使用.
"                                           "  Esc退出等于<C-[>  ; <C-o> 切换到插入-普通模式.
"                                           "    所以在插入的时候可以执行普通模式的命令并且返回插入模式.比如插入后<C-o>zz可以执行后回到插入模式.让屏幕居中.
"                                           " gv 重选上次的高亮选区, 包括v,V,<C-v> ; <C-g>可以在可视模式和选择模式切换.要退出高亮选择,用Esc 或者<C-[>; o是在高亮选择后来切换高亮选区的活动端(前后位置)
"                                           " gU 是U的等效命令,it是文本对象,gUit就是操作文本对象大写.
"                                           " gv 重选后,r| 用管道符替换选区内的字符; Vr-用连字符替换该行的所有字
"                                           " $ 移到模块选择的行尾,A在行尾添加内容,并且进入插入模式,输入内容,Esc保证修改的内容会扩散到其余选中的行上. (I 是行首.i是字符前,a是字符后.)
"                                           " <C-r> 在插入的时候按<C-r>= 后面跟需要运算的内容<CR>会执行这个计算.<C-r>=10%2<CR>
"                                           " 插入非常用字符.插入模式下<C-v>{code} 例:<C-v>065 插入十进制,可以指定字符集<C-v>u{1234}插入十六进制,  ga显示光标处的字符的编码.(十进制,十六进制)
"                                           "        :h i_CTRL-V-digit ,<C-v>跟非数字会插入按键本身的字符, <C-v><TAB>会插入真正的制表符而忽略expandtab是否开启.
"                                           "        <C-k>{char1}{char2}插入二合字母表示的字符. :h digraph-table
"                                           " :h vi-differences 查看vi 和vim差异.
"                                           " ex命令 
"                                           " :[range]delete [x]          删除指定范围内的行.[到寄存器x中]
"                                           " :[range]yank [x]            复制指定范围内的行.[到寄存器x中]
"                                           " :[range]put [x]             在指定行后粘贴寄存器x中的内容
"                                           " :[range]copy {address}      把指定范围内的行copy到地址所指定的行之下
"                                           " :[range]move {address}      把指定范围内的行move到地址所指定的行之下
"                                           " :[range]join               连接指定范围的行.
"                                           " :[range]normal {commands}   对指定范围中的每一行执行普通模式命令{commands}
"                                           " :[range]substitute/{pattern}/{string}/[flags]  把指定范围内出现{pattern}的地方替换为{string} 
"                                           " :[range]global/{pattern}/[cmd]     对指定范围内匹配{pattern}的所有行,在其上执行ex命令{cmd}
"                                           " :$: 等于gg 跳到文件末尾    .代表当前行的地址  %代表当前文件的所有行.
"                                           " :.,$p 打印当前行到文件末尾行的所有.
"                                           " 2G VG 会选中一个选区,按: 进入ex模式,命令行上会预先填充:'<,>'  其中'<代表高亮选取的首行位置标记 '>最后一行. 这个标记会在退出可视模式后一直存在.
"                                           " :/<html>/,/<\/html>/p  ex接受模式地址.还可以接受偏移量{address}    :/<html>/+1,/<\/html>/-1p
"                                           " ex 的地址  1文件第一行 $文件最后一行   0虚拟行,位于文件第一行上方  .光标所在行 'm包含位置标记m的行 '<高亮选区的起始行 >'高亮选区的结束行 %整个文件(:1,$的简写形式)
"}}
"{{                                         " 更新日志
" 4.8.15                                    " 4.8.15 从版本升级到4.9.1 查找了Ctrl-x在user下闪现问题,致使万能补全不能在user下使用.没有找到原因,使用长按ctrl+x ctrl+o来代替
" 4.9.2                                     " 修改了./vimfiles/after/syntax/css.vim 万能补全恢复
" 4.9.3                                     " add reg explaination !
" 4.9.4                                     " add reg explaination more !
" 4.9.5                                     " change line color in #592
" 4.9.6                                     " add NERD_commenter 的多行依次注释
" 4.9.7                                     " add set=textwidth=100
" 4.9.8                                     " delete cterm theme ,replace the default cterm theme
" 4.9.9                                     " 增加了matchit.vim 和multisearch.vim  2012-11-20 12:34:31
" 4.11.1                                    " add and some ustage 2012-11-20 15:24:16
" 4.12.1                                    " add easymotion.vim in autoload,doc.plugin 2012-12-04 10:12:22
" 4.12.26                                   " dt< 删除<></>括号内的内容 2012-12-26 12:13:43
" 5.02.06                                   " add gg=G 2013-02-06 11:44:24
" 5.02.07                                   " add some usage 2013-02-19 15:27:10
" 5.02.08                                   " add some usage 2013-02-20 13:45:16
" 5.02.09                                   " fix some usage 2013-02-25 14:27:20
" 5.03.01                                   " add some usage 2013-03-06 17:15:50
" 5.03.07                                   " add some usage 2013-03-07 17:01:21
" 5.03.14                                   " 修改超出背景bg#A36666->#1C1D1E fg->#DCDCDC 终端bg由lightred->darkgray fg lightgrey->lightblue 2013-03-14 15:38:09
" 5.04.01                                   " add diW manual etc.
" 5.04.02                                   " pear install PHP_CodeSniffer,pear channel-discover pear.phpmd.org,pear channel-discover pear.pdepend.org,pear isntall --alldeps phpmd/PHP_PMD 
"                                           " apt-get install php5-imagick imagemagick phpqa.vim
" 5.04.03                                   " 增加vim for php ,css ,html 变量等色彩配置 2013-04-11 15:22:09
" 5.05.01                                   " 修改了diff 4个颜色的配置 2013-05-13 18:00:00
" 5.06.01                                   " 修改了css font的颜色配置 2013-06-25 14:12:40
" 5.07.01                                   " 增加了xxd 十六进制 2013-07-17 12:31:49
" 5.09.01                                   " 增加了大小写敏感 2013-09-04 18:28:17
" 5.09.02                                   " 增加了分割的操作 2013-09-11 10:20:58
" 5.09.03                                   " 增加了ctags -R 操作 2013-09-11 16:50:00
" 5.10.01                                   " 增加.c .h .sh .java 头文件自动添加,其它 2013-10-08 10:25:36 
" 5.10.02                                   " 修改set noexpandtab为expandtab用空格来代替制表符,保证代码和staff的兼容.2013-10-18 15:54:50
" 5.10.03                                   " 增加CodeSniffer效验    2013-10-31 15:35:01
" 5.11.02                                   " 增加CodeSniffer效验,return type    2013-11-01 17:47:01
" 5.11.03                                   " 增加fuzzyfinder in root. 2013-11-05 10:55:00
" 5.11.04                                   " 增加d ↓注释. 2013-11-13 10:36:48
" 5.11.05                                   " 增加插件auto complpop  2013-11-21 11:17:40
" 5.11.06                                   " 增加快捷语法 2013-11-21 11:40:39
" 5.11.07                                   " 增加ctags 2013-11-26 10:28:48
" 5.11.08                                   " 增加some tips 2013-11-26 16:06:32
" 5.11.09                                   " 修改终端下代码提示 2013-11-26 16:51:38
" 5.12.01                                   " fix bug 2013-12-26 16:29:01
" 6.01.01                                   " add Surround.vim 2014-01-14 14:14:26
" 6.01.02                                   " add indentLine.vim  2014-01-14 14:51:57
" 6.01.03                                   " add R  2014-01-16 15:01:48
" 6.01.04                                   " add F2
" 6.02.01                                   " add 列插入 2014-02-07 11:34:17
" 6.02.02                                   " delte rainbow_parentheses.vim 2014-02-10 16:13:21
" 6.02.03-04                                " add tips批量添加行尾符号.2014-02-27 10:55:34
" 6.03.01                                   " 修复终端的一些颜色. 2014-03-01 02:51:11
" 6.03.02                                   " 修复一些配置,比如tlist_php_settings生效. 2014-03-05 10:24:30
" 6.03.03                                   " add colorv.vim 2014-03-14 11:48:37
" 6.03.04                                   " add xterm 256 色配置 2014-03-17 16:15:51
" 6.03.05                                   " add advanced tips 2014-03-19 12:14:49
" 6.04.01                                   " add listchar 2014-04-02 09:40:06
" 6.04.02                                   " add \( \) 来对正则引用 2014-04-11 09:45:18
" 6.04.03                                   " add vimgrep 2014-04-16 13:24:19
" 6.04.04                                   " add vim plugin ctrlp in,delete fuf.vim l9.vim # 2014-04-21 16:01:52
" 6.04.05                                   " add EasyGrep.vim MRU.vim  2014-04-21 18:04:34
" 6.05.01                                   " add some search tips 2014-05-07 15:49:48
" 6.05.02                                   " add advanced usage tips 2014-05-14 22:50:20
" 6.05.03                                   " add :e ++enc 2014-05-23 10:44:03
" 6.05.04                                   " add ex tips 2014-05-27 11:05:33
" 6.05.05                                   " modify indent, add set cc, highlight cursorline,hi ColorColumn 2014-05-29 23:42:21
" 6.06.01                                   " add vim-multiple-cursor 2014-06-24 14:09:32
" 6.07.01                                   " add Shift+F8/ F8 for !ctags -R 2014-07-14 12:28:55
" 6.07.02                                   " add Surround.vim manual. 2014-07-17 10:24:05
" 6.08.01                                   " add引用替换
" 6.09.01                                   " add ,m mark
" 6.11.01                                   " add new C-x C-N 2014-11-17 14:01:15
" 7.01.01                                   " add new vimdiff color 2015-02-04 11:22:49
" 7.04.01                                   " add foldenable zf 2015-04-17 17:59:15
" 7.06.01                                   " change terminal fg/bg color 2015-06-16 15:30:59
" 7.07.01                                   " add flake8=pyflake+pep8 2015-07-06 14:39:19
" 7.09.01                                   " add set iskeyword 2015-09-11 17:03:59
" 7.09.02                                   " add vundle 2016-04-18 17:12:52
" 7.09.03                                   " add others plugin 2016-04-20 00:55:32
" 7.09.04                                   " add lua,scala 2016-05-06 11:16:41
" 7.09.05                                   " add fast search 2016-06-28 14:13:48
" 7.09.06                                   " add expand and gitgutter plugin 2016-07-11 10:33:25
" 7.09.07                                   " fix c,cpp omniComplete,refine tags 2016-07-26 04:45:01
" 7.09.08                                   " add vim-json for disable json concealing quotes 2016-08-09 02:28:27
"}}
"}}}