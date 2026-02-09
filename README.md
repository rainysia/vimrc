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

![git status](https://cloud.githubusercontent.com/assets/1259324/16680190/776c7b4a-451f-11e6-8e6f-423bdd29f6aa.png)

#### Plugin list
---------------------------------
```
Bundle 'VundleVim/Vundle.vim'
"" Fast search in current directory
Bundle 'kien/ctrlp.vim'
"" Fast search function in current directory
Bundle 'tacahiroy/ctrlp-funky'
"" ack  linux ack
Bundle 'mileszs/ack.vim'
"" display tag 
Bundle 'vim-scripts/taglist.vim'
"" add author info
Bundle 'rainysia/authorinfo_php'
"" comment code
Bundle 'vim-scripts/The-NERD-Commenter'
"" list files and directory
Bundle 'scrooloose/nerdtree'
"" add git status for nerdtree
Bundle 'Xuyuanp/nerdtree-git-plugin'
"" minibuffer list
Bundle 'fholgado/minibufexpl.vim'
"" multiple window 
Bundle 'vim-scripts/winmanager'
"" like ack
Bundle 'yegappan/grep'
"" easygrep
Bundle 'dkprice/vim-easygrep'
"" Expand V-selected region
Bundle 'terryma/vim-expand-region'
"" recently files
Bundle 'vim-scripts/mru.vim'
"" display recent files search
Bundle 'vim-scripts/multisearch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'dimasg/vim-mark'
"" Chinese vim document
Bundle 'asins/vimcdoc'

"" display color for code code 
Bundle 'lilydjwg/colorizer'

"" calendar
Bundle 'itchyny/calendar.vim'

"" indent
Bundle 'nathanaelkane/vim-indent-guides'
"" indentLine
Bundle 'Yggdroot/indentLine'
"" lightline statusline
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

"" zencoding for generate code
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
Need cmake for [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) plugin.
Need Install ack(debian:apt-get install ack-grep, redhat:yum install ack) for [ack.vim](https://github.com/mileszs/ack) plugin.
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
2016-07-08 15:44:47 add vim plugin vim-gitgutter, vim-expand-region plugin. <br />
2016-07-26 05:22:57 fix c,cpp,py ctags filetype and support omnicomplete. <br />
```