vimrc
=====

It's a vim configuration file,has some custom color for vim-code,lots of tips for vim.
we map the <Leader> as , 
    so you can use ,ig for indentLine  ,cc for comments, ,ch for highligh ColorColumn etc.
    There are full vim files in here.

Usage && Installation.
---------------------------------
you can separate the files with _  and copy the files into your Debian OS filepath.
The vimrc file contains many usage for vim and the plugins. you can read it.

### Screenshot
![gvim](https://cloud.githubusercontent.com/assets/1259324/14772527/f963df04-0ad1-11e6-9f35-8dd2dbb0ff9e.png)
![gvim 2](https://cloud.githubusercontent.com/assets/1259324/14772526/f96138ee-0ad1-11e6-8dd8-1d2f501c850f.png)
![terminal](https://cloud.githubusercontent.com/assets/1259324/14772525/f9468bf2-0ad1-11e6-8e41-4ec15ca9fa84.png)
![css](https://cloud.githubusercontent.com/assets/1259324/14772524/f9183db0-0ad1-11e6-8477-b4907e44c14e.png)

### Plugin list
```
Bundle 'VundleVim/Vundle.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'rainysia/authorinfo_php'
Bundle 'vim-scripts/The-NERD-Commenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'vim-scripts/winmanager'
Bundle 'yegappan/grep'
Bundle 'dkprice/vim-easygrep'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/multisearch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'dimasg/vim-mark'
Bundle 'lilydjwg/colorizer'
Bundle 'itchyny/calendar.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Yggdroot/indentLine'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-fugitive'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/Emmet.vim'
Bundle 'rainysia/snipmate.vim'
"Bundle 'SirVer/ultisnips'
"Bundle 'honza/vim-snippets'
"Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/L9'
Bundle 'othree/vim-autocomplpop'
Bundle 'joonty/vim-phpqa'
Bundle 'tpope/vim-surround'
Bundle 'rkulla/pydiction'
Bundle 'andviro/flake8-vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'vim-scripts/a.vim'
Bundle '2072/PHP-Indenting-for-VIm'
Bundle '2072/vim-syntax-for-PHP'
Bundle 'junegunn/vim-easy-align'
```

### Details.
    Use `:BundleInstall` plugins.
    Unpack the consolas-powerline-vim.tar.gz fonts into your fonts folder.
    You may need to install python pip package, also some python packages.


### vim needs ctags for index func,class and so on, so you need to install ctags like this:

        >   For ctags windows:
                cp ctags.exe into /vim74
                    The ctags URL: http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip/download
                    Add configuration into your _vimrc: set tags=tags;
                    The tags="$path" means your can modify the $path as your project path, then run :!ctags -R in vim.
        >   For linux:
                Download ctags-5.8.tar.gz and  tar -zxvf it,cd ctags-5.8,
                and run ./configure make &&make install in shell.
                Make sure you have permission make it.
                Need cmake for YouCompleteMe plugins



Contact
---------------------------------
Follow me @[rainy_sia](https://twitter.com/rainy_sia) in twitter, [@rainysia](http://weibo.com/rainysia) in weibo, mail me at rainysia@gmail.com 

License
---------------------------------
Copyright by rainy.sia, 2010 Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php)

Updates
---------------------------------
```
2014-04-10 12:21:50 add /home/tom/.vim/ files as user_vim files. <br />
2014-05-30 00:56:04 add /usr/share/vim/ files as usr_share_vim files.  <br />
                    add /usr/share/php/PHP/CodeSniffer/ as usr_share_php_PHP_CodeSniffer/ <br />
                    add /usr/share/php/PHP/CodeSniffer.php as usr_share_php_PHP_CodeSniffer.php <br />
2014-06-24 14:08:32 add vim plugins vim-multiple-cursors in /usr/share/vim/ <br />
2014-07-14 12:29:40 add vim new map F8/S-F8 for !ctags -R<br />
2016-02-15 10:20:30 make vim configuration simple<br />
2016-04-25 10:26:22 mae new vimrc for 2016<br />
```