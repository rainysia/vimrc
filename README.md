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

        >   For ctags windows版 直接复制ctags.exe到/vim73下
               http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip/download
               set tags=tags;
            "这里tags="后面可以跟上路径比如我的F:/php/www/tags; 然后在vim里面:!ctags -R 编译www下的ctags文件.建议移走不相关的代码,只保留项目源码
               set autochdir 

        >   For linux 下直接把ctags-5.8这个tar.gz文件 tar -zxvf 解压了.然后进去 ./configure make &&make install


Contact
---------------------------------
Follow me @[rainy_sia](https://twitter.com/rainy_sia) in twitter, [@rainysia](http://weibo.com/rainysia) in weibo, mail me at rainysia@gmail.com 

License
---------------------------------
Copyright by rainy.sia, 2010 Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php)

Updates
---------------------------------
2014-04-10 12:21:50 add /home/tom/.vim/ files as user_vim files. <br />
2014-05-30 00:56:04 add /usr/share/vim/ files as usr_share_vim files.  <br />
                    add /usr/share/php/PHP/CodeSniffer/ as usr_share_php_PHP_CodeSniffer/ <br />
                    add /usr/share/php/PHP/CodeSniffer.php as usr_share_php_PHP_CodeSniffer.php <br />