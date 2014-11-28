# PHP代码编写规范检测工具
* 该文档描述了一种在公司内部约定的代码规范标准.
* 希望我们在新启动的项目中都能按照这个规范来进行开发,在老项目中也逐步推进代码规范.
* 这个代码规范支持的PHP版本是5.3.0及以上的版本.
* 这个检测的规范是按照[YII项目编码规范]作为标准来执行的.

#安装
1. 通过PEAR安装PHP_CodeSniffer([安装指南](http://pear.php.net/manual/en/installation.php)).
2. 进入PHP_CodeSniffer的安装目录下的Standards目录:
	> cd /path/to/php/CodeSniffer/Standards
3. 从仓库克隆.
    > git clone https://github.com/rainysia/vimrc.git 
4. 设置phpcs执行文件到默认PATH:

	> For Mac & Linux: ln -s /path/to/php/runtime/dir/bin /usr/local/bin
	
	> For Windows: 

	一、我选择的是用pear安装phpcs所以我们要先下载[go-pear.phar](http://pear.php.net/go-pear.phar) 。
	
	二、将你php.exe所在的路径设在系统的path中（环境变量）。

	三、进入你php.exe所在目录运行php go-pear.phar。

	四、如果你是Windows7用户当你看到如(system|local) [system] :提示时，你可以选择local，但是你也可以通过设置权限选择system，程序员以安全为主你懂的。

	五、接下来你看到提示你只用选择Yes或是Y，我没有试过Pear个性化安装，你可以试一下，我们可以讨论一下。

	六、如果你已经安装成功Pear了，你可以运行pear install PHP_CodeSniffer.

	七、如果你顺利安成了以上几步，恭喜你，你已经成功安装了PHP_CodeSniffer，你可以用phpcs --help查看帮助，也可以用phpcs --config-show查看配置文件。

	八、进入E:\pear\PHP\CodeSniffer\Standards(视你安装目录而定)。

	九、git clone https://github.com/rainysia/vimrc.git

5. 配置phpcs的运行规则,在命令行下运行:

	> phpcs --config-set encoding utf-8
	
	> phpcs --config-set default_standard Btroot
	
#在hg项目中加入检测hook
## For Mac & Linux
1. 进入项目根目录,并执行添加hook的脚本.
	
	> cd /path/to/your/project/root
	
	> /path/to/php/CodeSniffer/Standards/Btroot/add-hook.sh

2. 检查配置是否正确.
	
	> grep 'precommit.phpcs' .hg/hgrc

## For Windows
1. 因为我的hooks是用python写的，所以你要先找一个目录把以下代码保存上，如下.

<pre><code style="python">
#coding: utf8
import sys
import os
import platform

def phpcs(ui, repo, hooktype, node=None, source=None, **kwargs):
    cmd = 'hg status -n'
    stFileList = ''
    stFileCount = 0
    for item in os.popen(cmd).readlines():
        itemList = item.strip().split(".")
        if (itemList[len(itemList)-1]).strip().lower() == 'php' :
            if stFileCount == 0 :
                stFileList = item
            else :
                stFileList = stFileList + " " + item
            stFileCount = stFileCount + 1
    if stFileCount > 0 :
        #argsPHPCS = "-n -p -s"
        argsPHPCS = ""
        cmdPHPCS = "phpcs %s %s" % (argsPHPCS , stFileList)
        errorMsg = os.popen(cmdPHPCS).read().strip()
        if errorMsg != '':
            ui.warn(errorMsg)
            return True        
    return False
</code></pre>

2. 把以代码保存为一个文件如我保存的就是pre-commit.py，然后在你的仓库里面找到.hg/hgrc(当然你也可以加全局)，在里面加入.
	
	> [hooks]

	> precommit.phpcs = python:E:\web\test\pre-commit.py:phpcs 
	
	> 中间的目录你自己定哈，我是保存在E:\web\test\中的，前面的python只是申明这是一个python代码，后面的phpcs就是python中的方法。

#设置忽略
在hg项目中将要忽略的目录和文件的路径写入到.csignore中即可在提交的时候忽略指定目录和文件的检查.

	忽略目录: Test/*
	忽略文件: ThirtyPart/Xxx.php

#注意事项
这个检查工具不能检测模板文件的语法,请忽略模板文件的错误.

#与编辑器或IDE集成
1. Sublime请参考: https://github.com/benmatselby/sublime-phpcs
2. For Vim: 复制vimrc, CodeSniffer即可用

#独立运行文件或目录检测
1. 单个文件检测,在命令行中执行:phpcs /path/to/your/files
2. 目录检测,在命令行中执行:phpcs /path/to/your/directory/\*.注意最后的\*是通配符.
