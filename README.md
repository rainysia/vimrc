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

### Details.
        1.  for user_vim,
                cp it to your user home files, if your user_name is tom, cp all of it to /home/tom/.vim/
                and then change the owner use #chown tom:tom -R .vim , make sure the filepath is 755.
        2.  for usr_share_vim,
                cp it to your /usr/share/vim/ which is your vim installed path.
        3.  for usr_share_php_PHP_CodeSniffer, 
                cp it to your /usr/share/php/PHP/ , it will help you format php code standardly.
        4.  for usr_share_php_PHP_CodeSniffer.php,
                 cp it to /usr/share/php/PHP/CodeSniffer.php
        5.  for vimrc, it's the basic configuration. 
                cp it and cover your /etc/vim/vimrc before kept a backup of your vimrc.

### vim needs ctags for index func,class and so on, so you need to install ctags like this:

        >   For ctags windows:
                cp ctags.exe into /vim73
                    The ctags URL: http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip/download
                    Add configuration into your _vimrc: set tags=tags;
                    The tags="$path" means your can modify the $path as your project path, then run :!ctags -R in vim.
        >   For linux:
                Download ctags-5.8.tar.gz and  tar -zxvf it,cd ctags-5.8,
                and run ./configure make &&make install in shell.
                Make sure you have permission make it.


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
```