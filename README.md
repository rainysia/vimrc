vimrc
=====
It's a vim configuration file,has some custom color for vim-code,lots of tips for vim.
we map the <Leader> as , 
    so you can use ,ig for indentLine  ,cc for comments, ,ch for highligh ColorColumn etc.
    There are full vim files in here.

#### Usage && Installation.
---------------------------------
1. Copy the vimrc into your Debian OS filepath or server vimrc path mostly in /etc/vim.
2. `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim` in different user.
3. For different user like `user` and `root`, Just run `:BundleInstall` in different user in vim.
4. Unpack the consolas-powerline-vim.tar.gz fonts into your fonts folder.
5. You may need to install python pip package, also some python packages.

#### Screenshot
---------------------------------
![gvim](https://cloud.githubusercontent.com/assets/1259324/14772527/f963df04-0ad1-11e6-9f35-8dd2dbb0ff9e.png)

![gvim 2](https://cloud.githubusercontent.com/assets/1259324/14772526/f96138ee-0ad1-11e6-8dd8-1d2f501c850f.png)

![terminal](https://cloud.githubusercontent.com/assets/1259324/14772525/f9468bf2-0ad1-11e6-8e41-4ec15ca9fa84.png)

![css](https://cloud.githubusercontent.com/assets/1259324/14772524/f9183db0-0ad1-11e6-8477-b4907e44c14e.png)

#### Plugin list
---------------------------------
```
Bundle 'VundleVim/Vundle.vim'
"" 快速文件查找
Bundle 'kien/ctrlp.vim'
"" ctrlp 函数查找
Bundle 'tacahiroy/ctrlp-funky'
"" ack 更快的搜索
Bundle 'mileszs/ack.vim'
"" 大纲查看
Bundle 'majutsushi/tagbar'
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
"" 最近使用文件浏览
Bundle 'vim-scripts/mru.vim'
"" 显示多次搜索结果
Bundle 'vim-scripts/multisearch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'dimasg/vim-mark'
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

"" (x)html close tag
Bundle 'vim-scripts/closetag.vim'

"" Switch in c to h
Bundle 'vim-scripts/a.vim'

"" php indent and syntax
Bundle '2072/PHP-Indenting-for-VIm'
Bundle '2072/vim-syntax-for-PHP'

"" scala
Bundle 'derekwyatt/vim-scala'
Bundle 'vim-scripts/scala.vim'

"" lua
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-lua-ftplugin'

"" format
Bundle 'junegunn/vim-easy-align'

```

#### Some others components
---------------------------------
1. For ctags windows:
```
cp ctags.exe into /vim74
The ctags URL: http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip/download
Add configuration into your _vimrc: set tags=tags;
The tags="$path" means your can modify the $path as your project path, then run :!ctags -R in vim.
```

2. For linux:
```
Download ctags-5.8.tar.gz and  tar -zxvf ctags-5.8.tar.gz,cd ctags-5.8,
and run ./configure make &&make install in shell.
Make sure you have permission make it.
```

3. Others
```
Need cmake for [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) plugins
Need [consolas-powerline-vim](https://github.com/rainysia/vimrc/blob/master/consolas-powerline-vim.tar.gz) font for git branch status.
```

#### Contact
---------------------------------
Follow me @[rainy_sia](https://twitter.com/rainy_sia) in twitter, [@rainysia](http://weibo.com/rainysia) in weibo, mail me at rainysia#gmail.com 

#### License
---------------------------------
Copyright by rainy.sia, 2010 Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php)

#### Updates
---------------------------------
```
2008-04-20 15:27:58 Initial<br />
2014-04-10 12:21:50 add /home/tom/.vim/ files as user_vim files. <br />
2014-05-30 00:56:04 add /usr/share/vim/ files as usr_share_vim files.  <br />
                    add /usr/share/php/PHP/CodeSniffer/ as usr_share_php_PHP_CodeSniffer/ <br />
                    add /usr/share/php/PHP/CodeSniffer.php as usr_share_php_PHP_CodeSniffer.php <br />
2014-06-24 14:08:32 add vim plugins vim-multiple-cursors in /usr/share/vim/ <br />
2014-07-14 12:29:40 add vim new map F8/S-F8 for !ctags -R<br />
2016-02-15 10:20:30 make vim configuration simple<br />
2016-04-25 10:26:22 make new vimrc for 2016<br />
```