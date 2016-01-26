Shell Notes
============

1.录制屏幕操作
```
script -t 2> time.log -a output.session
time.log描述每个命令在何时运行 output.session存储命令输出
-t 将数序数据导入stderr 2> 将stderr重定向到time.log
scriptreplay time.log output.session 按照播放命令序列输出
```

2.在第二个终端演示操作
```
terminal_1
    mkfifo scriptfifo
terminal_2
    car scriptfifo
terminal_1
    script -f scriptfifo
    command;
    exit;
```

3.显示行号 移除空白行
```
cat -n file.txt | tr -s '\n'
创建多级目录树
    mkdir -p /path1/path2/path3
    mkdir -p /home/user/{test1,test2,test3}
    mkdir filenames && chown tommy:tommy -R !$ 创建目录并且授权.
打印访问时间超过7分钟的所有文件 atime 访问时间 mtime 修改时间 ctime 变化时间 分钟amin mmin cmin 后面参数 用+ -来控制大于还是小于 这个时间参数
    find . -type f -amin +7 -print 打印访问时间超过7分钟的所有文件
    find . -type f -newer file.txt -print 找出比file.txt更新的文件
    find . -type f -size +2k 找出大于2KB的文件 b块 c字节 w字 k千字节M兆字节G吉字节
    find . -type f -name "*.swp" -delete 删除找到的swp 文件
    find . -type f -perm 644 -print 找出特定权限的所有文件
    find . -type f -name "*.php" ! -perm 644 -print 找出没有设置644权限的php文件
    find . -type f -user slynux -print 找出用户slynux拥有的所有文件 -user跟用户名或UID
    find . -type f -user root -exec chown tom {} \; 用-exec执行找到的文件的后续操作 {}特殊的字符串,
        配合-exec 使用.对于每个匹配的文件{}会被替换成相应的文件名
    find . -type f -name "*.c" -exec cat {} \;>all_c_files.txt 把所有的c文件合并到一个文件.
    find . -type f -mtime +10 -name "*.txt" -exec cp {} OLD \; 把10天前的txt文件复制到OLD目录中.
        -exec 只能直接使用单个命令,可以 -exec ./commands.sh {} \; 来把多个命令写到sh里面去
跳过含有.git目录的 \( -name ".git" -prune \) 排除.git目录
    find devel/source_path \( -name ".git" -prune \) -o \( -type f -print \)
\( -type f -print \) 然后 -o匹配多个条件中的1个
    find ./etc -name "*.php" | xargs grep -n "需要匹配的文字" >>/home/www    (在grep 后跟-A num
            来指定后面几行,-b是前几行.)
    cat test.txt | xargs 把多行输入转换成单行输出
    cat test.txt | xargs -n 3 把单行输入转换成多行输出 每行n个参数(根据空格来划分参数)
    find . -name 'core' -type f -exec rm {} /;
    find . -name 'core' -type f | xargs rm
        第一种,-exec,相当于把前面find的结果替换到{} /;的位置去进行rm操作.
        第二种,|xargs 是相当于把管道前面的find结果替换到管道后面的末尾(默认是末尾)去执行rm操作.
        -exec的方式只开启了一个rm进程去删除文件,而xargs因为是分批处理,所以会开启多个进程处理,效率自然稍微低一点,但为什么有时候还要用它呢？
        因为一次性替换find到的结果,如果结果过多,会出现参数过长的错误,这时候就需要用到xargs来分批处理了
    touch 1 2 3
    find . -type f -exec mv {} {}.bak \;
    ls
    1.bak 2.bak  3.bak
    rm -f *
    touch 1 2 3
    find . -type f|xargs -i mv {} {}.bak
    ls
    1.bak 2.bak  3.bak
    find . -type f|xargs -I [] mv [] [].tmp
    ls
    1.bak.tmp 2.bak.tmp  3.bak.tmp
怎么才能知道系统最大支持多少个命令参数呢？
    getconf ARG_MAX
    2621440
就是说,如果在我的系统find结果不超过2621440个文件的话,就不用担心参数超长问题了.

统计某个文件夹下所有文件的行数
    find ./proj_name/ -name '*.*' | xargs wc -l
    find . -name "*.py" | xargs cat | wc -l 统计所有行数,包含空格
    find . -name "*.py" | xargs cat|grep -v ^$|wc -l  去除空行
    find . -name "*.py" | xargs cat | grep -v -e  ^$ -e ^\s*\/\/.*$|wc -l 去除空行和注释
    find . -name "*.py" | sed '/^$/d; /\/\//d' | wc -l

apt-get install cloc
cloc ./ --3 来代码统计, 可以按照语言排序
```

4.echp 输出
```
echo "efwkfjwfjewklfjweklfjeklwjfwe4tjrklegnmer12312j3kljklfwe" | xargs -d X 
    -d用来指定采定界符 这里用的X分开
echo "efjwkfjewklfjewklfjweklfjekwfjlekw" | xargs -d k -n 2 
    把输入划分成2行,以k为定界符
echo -ne 'aaa\nbbb\nccc\n'>>1.txt -n不显示换行-e解释反斜杠 \n新行
echo file.txt | tr -d '[set1]' 删除file.txt 含有[set1] 并打印剩余的
echo file.txt | tr -d -c '[set2]' 删除除了 -c 补集以外的所有内容
echo "string. string" | tr -s '' 用tr -s 压缩空白字符
cat sum.txt | echo $(tr '\n' '+') 0 ] 
    sum.txt 为 1 2 3 4 5 6
用tr把 \n 替换为+ ,这样变成了1+2+3+4+5+6+,追加0,$[] 执行算数运算,变成了
echo $(1+2+3+4+5+6+0)
    读取文件的首行并赋值给变量
        read -r line < file  line是变量 或 $line=$(head -l file)
    依次读入文件每一行
        $while read -r line;do
            #do something with $line
        done < file
    随机读取一行并赋值给变量
        read -r random_line << (shuf file)
    保存文件的大小到变量
        $size =$(wc-c < file)
    从文件路径中获取文件名
        $filename=$(path##*/)
    从文件路径中获取目录名
        $dirname=$(path%/*)
    快速copy文件
        cp /path/to/file{,_copy} 等价cp /path/to/file /path/to/file_copy  mv也可以类似
    生成a~z字母
        echo {a..z}
        printf "%c" {a..z} 不包含空格
        printf "%c\n" {a..z} 每行一个字母
        echo {00..09}  00~09的数字
        echo {w,t,}h{e{n{,ce{,forth}},re{,in,fore,with{,al}}},ither,at} 随机生成30个英文单词
        echo {a,b,c}{1,2,3} 生成a1 a2 a3 b1 b2...
        
    重复输出10次字符串
        echo foo{,,,,,,,,,,} 
    拼接字符串
        echo "$x$y"
    替换字符串中的foo为bar
        echo ${str/foo/bar}
    计算字符串长度
        echo ${#str}
    提取字符串的子串
        $str="hello world"
        echo ${str:6}  提取到world ${var:offset:length}
    转换成大写,小写
        declare -u var
        declare -l var
```

5.校检文件
```
md5sum sha1summ
md5sum filename > filename.md5 把产生的md5码重定向到.md5
获取文本的md5值: echo -n "text" | md5sum
    echo -n "text" | md5sum| cut -d ' ' -f1
```

6.排序
```
sort -n file.txt 按照数字排序
sort -r file.txt 按照逆序进行排序
sort -M months.txt 按照月份时间排序
sort -m sorted1 sorted2 合并两个拍过序的文件,并且不需要对合并后的文件再进行排序.
cat data.txt
    1 mac 2000
    2 winxp 4000
    3 bsd 1000
    4 linux 1000
sort -nrk 1 data.txt 按照键排列 -k指定排序按照哪个键key排序, 键指的是列号, -r 表示逆序-n数字排序
    4 linux 1000
    3 bas 1000
    2 winxp 4000
    1 mac 2000
ort -k 2 data.txt
    3 bsd 1000
    4 linux 1000
    1 mac 2000
    2 winxp 4000
-k 可以是一个范围,当字符串没有用空格隔开时, #$sork -nk 2,4 data.txt
用第一个字符作为键 #$sork -nk 1,1 data.txt
uniq 从文本stdin中提取单一的行,并且去掉重复的行
cat sorted_file.txt | uniq>uniq_lines.txt 找出已排序文件中不重复的行
sort unsorted.txt | uniq 排序并且去掉重复行 等于 #$sort -u unsorted.txt
sort unsorted.txt | uniq -d 找出文件中重复的行
sort unsorted.txt | uniq -c 统计各行出现的次数
-s 跳过前N个字符 -w 指定用于比较的最大字符数

du -s path | sort -rn 按字节排序
du -sh path | sort -rn 按照M 大小排序
du -s path | sort -rn | head 选出排前10个的
du -s path | sort -rn | tail ...尾

find /etc -name "*" | xargs grep "hello abcserver" > ./cqtest.txt
grep 后-n 可以显示行号
uniq 消除重复内容, 只能用于排过序的数据输入,找出单一的行
cat 1.txt
    aaa
    cca
    ccb
    aab
    aac
    bbb
    ccc
    bbb
    aaa
    bbb
    ccc
    ddd
sort 1.txt | uniq 排序并且去掉重复的行 (单一行,重复的行只打印出一次)
和 sort -u 1.txt 一个意思 #$sort 1.txt | uniq -u 
sort 1.txt | uniq -c 统计各行出现的次数
sort 1.txt | uniq -d 找出重复的行
ls -s | sort -k 1 -n 对当前目录下文件按照大小排序.
```


7.排序末尾和开头
```
tail head -n num filename 打印后 前 多少行
tail -f /log -f随着数据的更新实时打印更新的内容 和#$dmesg | tail -f
tail -f /log –pid $PID 跟踪进程PID来实时
tail -f /tmp/log | sed -u 's/^/key=791f28\&content=/' | sed -u 's/"/-@-/g' | sed -u 's/.*/"&"/' | xargs -I {} curl -d {} http://115.29.161.122/webtail/chunk
把tail的加载到浏览器中 tail >> file >> web

列出目录 目录的文件类型字符是d, ^是行首标记
    ls -d */ 
    ls -F | grep "/$"
    ls -l | grep "^d"
```

8.pushd popd 快速定位
```
pushd 把路径压入栈, 依次压入 popd 依次栈目录删除路径 dirs 查看栈内容
    pushd /home/www
    pushd /usr/share
    pushd /usr/src
    dirs
        ~ /usr/src /usr/share /home/www
        0 1 2 3
切换路径pushd +3 会切换到/home/www 并且改变栈地址(栈翻转) popd pushd +no o从左到邮 从0-n计数
```

9.统计文件
wc统计文件的行数,单词数,字符数 (word count) 直接wc file 会打印出文件的行数 单词数 字符数
```
    wc -l file 统计行数
    cat file | wc -1 将stdin作为输入 
    wc -w file 统计单词数
    cat file | wc -w 
    wc -c file 统计字符数
    cat file | wc -c
    echo -n 12345 | wc -c 统计文本的字符数 -n避免echo添加额外的换行符
    wc file -L 打印最长行的长度
```

10.打印文件目录
```
tree 以图形化的树状结构打印文件和目录 
aptitude install tree
tree path =P pattern 重点标记出匹配某种样式的文件.
tree PATH -p "*.sh"
tree path -I pattern 重点标记出除符合某种样式之外的那些文件
tree -h PATH同时打印出文件和目录的大小
tree path -H http://localhost -o out.html 用tree打印出html输出
```

11.shell正则
```
^ 行起始标记 
$ 行尾标记 所以^$就匹配空行
. 匹配任意一个字符
[] 匹配包含之中的任意一个字符 coo[kl] 匹配cook 或cool
[^] 匹配 除了 指定范围内的任意一个字符 9[^01] 匹配92 93 不匹配90 91
[-] 匹配指定范围内的任意一个字符 [1-5] 匹配1~5的任意一个数字
\<\> 精确匹配
? 匹配之前的项 一次或0次 colou?r 匹配color 或colour 不匹配colouur
+ 匹配之前的项 一次或多次 rollno-9+ 匹配rollno-99 rollno-9 不匹配rollno-
* 匹配之前的项 0次或多次 co*l 匹配 cl col coool 等 包括1次
() 创建一个用于匹配的子串 ma(tri)?x 匹配max 或者maxtrix 
{n} 匹配之前的项n次 [0-9]{3}匹配任意一个三位数 [0-9]{3} =[0-9][0-9][0-9]
\{n\} 同上 精确匹配
{n,} 之前的项至少需要匹配n次 [0-9]{2,} 匹配任意一个两位数字或者更多位的数字
\{n,\} 精确匹配
{n,m} 指定之前的项所必须匹配的最小次数和最大次数 [0-9]{2,5}匹配从两位数到五位数之间的任意一个数字
\{n,m\} 精确匹配
| 交替 匹配|两边的任意一项 Oct (1st | 2nd) 匹配Oct 1st 或Oct 2nd
\ 转义符将上面的特殊符号进行转义 a\.b 匹配a.b 不能匹配ajb

perl的元字符
\b 单词边界 \bcool\b 匹配 cool 不匹配coolant
\B 非单词边界 cool\B 匹配coolant ,不匹配cool
\d 单个数字字符 b\db 匹配b2b 不匹配bcb
\D 单个非数字字符 b\Db 匹配bcb 不匹配b2b
\w 单个单词字符(字母,数字,_) \w匹配1或a 不匹配&
\W 单个非单词字符 匹配& 不匹配1或a
\n 换行符 \n匹配一个新行
\s 单个空白字符 x\sx匹配x x,不匹配xx
\S 单个非空白字符 \x\S\x 匹配xkx,不匹配xx
\r 回车
```

12.grep详解
```
grep 搜索文本
grep "match_text" file1 file2 file3 … 搜索多个文件
grep wold filename –color=auto 重点标记出匹配到的单词
grep -E "正则表达式" 或者用egrep "正则表达式" 
echo "match_text" | grep -o -E "[a-z]+\." 只输出文件中匹配到的文本部分,用-o
grep -v "match_pattern" file 打印除包含match_pattern的行之外的所有行 -v将结果反转
grep -c "match_pattern" file 统计文本或者文本中包含匹配字符串的行数,不是匹配的次数
    统计文件中匹配项的数量,
echo -e "1 2 3 4\nhello\n5 6" | egrep -o "[0-9]" | wc -l 
grep -n 打印出包含匹配字符串的行数
grep -b 打印字符偏移值 一般是配合-b -o
grep -l 搜索所个文件并找出匹配文本位于哪一个文件中 -L 返回一个不匹配的文件列表
grep "match_text" . -R -n 多级目录递归
grep -i 不考虑字符的大小写
grep -e "pattern1" -e "pattern2" 匹配多个样式 
或者是先指定多个pattern 然后用-f 执行grep #$echo hello this is cool | grep -f patfile
grep "main()" . -r –include *.{c.cpp} 在目录中递归搜索所有的.c 和.cpp文件
grep "main()" . -r -exclude "readme" 排除所有readme文件 
排除目录—exclude-dir 从文件中读取所许排除的文件列表 –exclude-from file
grep -A 3匹配某个结果之后的3行 -B 3 匹配结果之前的3行 -C 3匹配结果之前和之后的3行
echo -e "a\nb\nc\na\nb\nc" | grep a -A 1 多个匹配,以一行 – 作为各匹配之前的定界符
grep "keyword1\|keyword2" 用 | 来分割来, 需要转义, 来多个匹配

egrep=grep -E   利用此命令可以使用扩展的正则表达式对文本进行搜索,并把符合用户需求的字符串打印出来.
fgrep=grep -F   它利用固定的字符串来对文本进行搜索,但不支持正则表达式的引用,所以此命令的执行速度也最快.

ls | egrep -E "*\.[0-9]" | xargs rm 删除/var/log下面的数字备份文件, 支持1级
find ./ -type f | grep -E "[a-z]+\.[0-9]+" | xargs rm, 支持多级
```

13.cut切分文件
```
cut 切分文件
cut -f field_list filename 提取第一个字段或者列,field_list用逗号分割
cut -f 2,3 filename 显示第2,3列
cut -f1 filename cut -s 不打印制表符
cat student_data.txt
    No Name Mark Percent
    1 Sara 45 90
    2 Alex 49 98
    3 Anu 45 90
cut -f1 student_data.txt
    No
    1
    2
    3
cut -f2,4 student_data.txt
    Name Percent
    Sara 90
    Alex 98
    Anu 90
cut –cimplement 补集
cut -f3 –complement student_data.txt 分割除了第3列的其他列
    No Name Percent
    1 Sara 90
    2 Alex 98
    3 Anu 90
cat delimited_data.txt 指定字段的定界符 使用-d选项
cut delimited_data.txt
    No;Name;Mark;Percent
    1;Sara;45;90
    2;Alex;49;98
    3;Anu;45;90
cut -f2 -d";" delimited_data.txt
    Name
    Sara
    Alex
    Anu
cut 指定字段的字符或者字节范围
    N- 从第N个字节,字符或者字段到行尾
    N-M 在N~M的范围内
    -M 从第一个字节,字符,字段到第M个(包括M)个字节,字符或者字节.
cat range_fields.txt
    abcdefghijklmopqrstuvwxyz
    abcdefghijklmopqrstuvwxyz
    abcdefghijklmopqrstuvwxyz
    abcdefghijklmopqrstuvwxy
cut -c1-5 range_fields.txt 显示c后5个字符
    abcde
    abcde
    abcde
    abcde
cut range_fields.txt -c-2 显示c前两个字符,
    将-c 替换成-b,可以用字节作为计数单位 在使用-c ,-f ,-b 时可以指定输出定界符
    --output-delimiter "delimiter string"
    当用-b或者-c提取多个字段时,必须使用—output-delimiter
cut range_fields.txt -c1-3,6-9 –output-delimiter ","
    abc,fghi
    abc,fghi
    abc,fghi
    abc,fghi
```

14.统计词频
sed stream editor流编辑器
```
sed 's/pattern/replace_string/' file
cat file | sed 's/pattern/replace_string/' file
sed -i 's/text/replace/' file 使用-i选项,可以将替换结果应用于源文件
sed 's/pattern/replace_string/g' file 替换所有内容
echo this thisthisthis | sed 's/this/THIS/2g'
    this THISTHISTHIS
echo this thisthisthis | sed 's/this/THIS/3g'
    thisthisTHISTHIS
echo this thisthisthis | sed 's/this/THIS/4g'
    thisthisthisTHIS
从第N处匹配开始替换时,可以用/Ng
字符/ 在sed中作为定界符使用,也可以使用其他任意的定界符
sed 's:text:replace:g'
sed 's|text|replace|g' 如果定界符出现在样式内部,需要\转义
sed 's|te\|xt|replace|g'

sed '/^$/d' file 移除空白行
sed 用&标记匹配样式的字符串
echo this is an example | sed 's/\w\+/[&]/g' 正则表达式匹配单词\w\+ ,替换[&]
    [this] [is] [an] [example]
echo this is digit 8 in a number | sed 's/digit \([0-9]\)/\1/'
    this is 7 in a number
echo seven EIGHT | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
    EIGHT seven
([a-z]\+\) 匹配第一个单词 ([A-Z]\+\) 匹配第二个单词 \1 \2 引用它们,这种引用叫向后引用
```

15.awk 操作数据流的列和行
```
awk ' BEGIN{ print "start" } pattern { commands } END{ print "end" }
    file awk由三部分组成,BEGIN,END语句块和使用模式匹配的通用语句块 是可选的,脚本包含在单引号或者双引号中
awk 'BEGIN { i=0 } { i++ } END{ print i}' filename 或者
awk "BEGIN { i=0 } { i++ } END{ print i}" filename

echo -e "line1\nline2" | awk 'BEGIN{ print "start" } { print } END{ print "end" }
    start
    line1
    line2
    end
当不指定pattern时,默认就是打印.print的参数是以逗号进行分割时,参数打印时则以空格作为定界符,在awk的print语句中,双引号是被作为凭借操作符(concatenation opeartor) 使用的
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3 ; }'
    v1 v2 v3
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"-"var2"-"var3 ;}'
    v1-v2-v3
awk 的特殊变量 NR 记录数量,在执行过程中对应于当前行号, NF 字段数量,在执行过程中对应于当前行的字段数 $0 包含执行过程中当前行的文本内容
    $1 包含第一个字段的文本内容
    $2 包含第二个字段的文本内容
awk '{ print $3,$2 }' file 打印每一行的第2和第3个字段
awk 'END{ print NR }' file 统计文件中的行数
    -v 将外部值传递给awk
var=10000
echo | awk -v variable=$var'{ print variable }'
getline 读取一行的var内容 getline var
awk 'NR < 5'        行号小于5的行
awk 'NR==1,NR==4'   行号在1到5之间的行,(从0开始的)
awk '/linux/'       包含样式linux的行
awk '!/linux/'      不包含样式linux的行
设置字段定界符 默认是空格 用-F "delimiter" 指定
awk -F: '{ print $NF }' /etc/passwd 或者
awk 'BEGIN { FS=":" } { print $NF }' /etc/passwd 在begin语句块中用OFS="delimiter" 设置输出字段的定界符
查看系统所有用户 cut -d: -f1 /etc/passwd
查看系统所有组   cut -d: -f1 /etc/group

awk中使用循环 for(i=0;i<10;i++){ print $i; } 或者
for (I in array ){ print array[i];}

awk内建的字符串控制函数 
length(string) 返回字符串的长度
index(string,search_string) 返回search_string在字符串中出现的位置
split(string,array,delimiter) 用定界符生成一个字符串列表,并将该列表存入数组
substr(string,start-position,end-position) 在字符串中用字符起止偏移量生成子串,并返回该子串
sub(regex,replacement_str,string) 将正则表达式匹配到的第一处内容替换成repalcement_str
gsub(regex,replacement_str,string) 和sub类似,不过会替换正则表达式匹配到的所有内容
match(regex,string) 检查正则表达式是否能够匹配字符串,返回非0值. 否则返回0 ,有两个特殊的变量,
    RSTART和RLENGTH 表示包含正则表达式所匹配内容的起始位置和包含正则表达式所匹配内容的长度

每行后面增加一行空行
    awk '1;{print ""}'
    awk 'BEGIN{ORS="\n\n"};1'
每行后面增加一行空行.输出文件不会包含连续的两个或两个以上的空行
注意：在Unix系统, DOS行包括的 CRLF (\r\n) 通常会被作为非空行对待
因此 'NF' 将会返回TRUE.
    awk 'NF{print $0 "\n"}'
每行后面增加两行空行
    awk '1;{print "\n"}'
编号和计算：
以文件为单位,在每句行前加上编号 (左对齐).
使用制表符 (\t) 来代替空格可以有效保护页变的空白.
    awk '{print FNR "\t" $0}' files*
用制表符 (\t) 给所有文件加上连贯的编号.
    awk '{print NR "\t" $0}' files*
number each line of a file (number on left, right-aligned)
Double the percent signs if typing from the DOS command prompt.
    awk '{printf("%5d : %s\n", NR,$0)}'
给非空白行的行加上编号
记得Unix对于 \r 的处理的特殊之处.(上面已经提到)
    awk 'NF{$0=++a " :" $0};{print}'
    awk '{print (NF? ++a " :" :"") $0}'
计算行数 (模拟 "wc -l")
    awk 'END{print NR}'
计算每行每个区域之和
    awk '{s=0; for (i=1; i<=NF; i++) s=s+$i; print s}'
计算所有行所有区域的总和
    awk '{for (i=1; i<=NF; i++) s=s+$i}; END{print s}'
打印每行每区域的绝对值
    awk '{for (i=1; i<=NF; i++) if ($i < 0) $i = -$i; print }'
    awk '{for (i=1; i<=NF; i++) $i = ($i < 0) ? -$i : $i; print }'
计算所有行所有区域(词)的个数
    awk '{ total = total + NF }; END {print total}' file
打印包含 "Beth" 的行数
    awk '/Beth/{n++}; END {print n+0}' file
打印第一列最大的行
并且在行前打印出这个最大的数
    awk '$1 > max {max=$1; maxline=$0}; END{ print max, maxline}'
打印每行的列数,并在后面跟上此行内容
    awk '{ print NF ":" $0 } '
打印每行的最后一列
    awk '{ print $NF }'
打印最后一行的最后一列
    awk '{ field = $NF }; END{ print field }'
打印列数超过4的行
    awk 'NF > 4'
打印最后一列大于4的行
    awk '$NF > 4'
文本转换和替代：
在Unix环境：转换DOS新行 (CR/LF) 为Unix格式
    awk '{sub(/\r$/,"");print}' 假设每行都以Ctrl-M结尾
在Unix环境：转换Unix新行 (LF) 为DOS格式
    awk '{sub(/$/,"\r");print}
在DOS环境：转换Unix新行 (LF) 为DOS格式
    awk 1
在DOS环境：转换DOS新行 (CR/LF) 为Unix格式
DOS版本的awk不能运行, 只能用gawk:
    gawk -v BINMODE="w" '1' infile >outfile
用 "tr" 替代的方法.
    tr -d \r <infile >outfile GNU tr 版本为 1.22 或者更高
删除每行前的空白(包括空格符和制表符)
使所有文本左对齐
    awk '{sub(/^[ \t]+/, ""); print}'
删除每行结尾的空白(包括空格符和制表符)
    awk '{sub(/[ \t]+$/, "");print}'
删除每行开头和结尾的所有空白(包括空格符和制表符)
    awk '{gsub(/^[ \t]+|[ \t]+$/,"");print}'
    awk '{$1=$1;print}' 每列之间的空白也被删除
在每一行开头处插入5个空格 (做整页的左位移)
    awk '{sub(/^/, " ");print}'
用79个字符为宽度,将全部文本右对齐
    awk '{printf "%79s\n", $0}' file*
用79个字符为宽度,将全部文本居中对齐
    awk '{l=length();s=int((79-l)/2); printf "%"(s+l)"s\n",$0}' file*
每行用 "bar" 查找替换 "foo"
    awk '{sub(/foo/,"bar");print}' 仅仅替换第一个找到的"foo"
    awk '{$0=gensub(/foo/,"bar",4);print}' 仅仅替换第四个找到的"foo"
    awk '{gsub(/foo/,"bar");print}' 全部替换
在包含 "baz" 的行里,将 "foo" 替换为 "bar"
    awk '/baz/{gsub(/foo/, "bar")};{print}'
在不包含 "baz" 的行里,将 "foo" 替换为 "bar"
    awk '!/baz/{gsub(/foo/, "bar")};{print}'
将 "scarlet" 或者 "ruby" 或者 "puce" 替换为 "red"
    awk '{gsub(/scarlet|ruby|puce/, "red"); print}'
倒排文本 (模拟 "tac")
    awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' file*
如果一行结尾为反斜线符,将下一行接到这行后面
(如果有连续多行后面带反斜线符,将会失败)
    awk '/\\$/ {sub(/\\$/,""); getline t; print $0 t; next}; 1' file*
排序并打印所有登录用户的姓名
    awk -F ":" '{ print $1 | "sort" }' /etc/passwd
以相反的顺序打印出每行的前两列
    awk '{print $2, $1}' file
调换前两列的位置
    awk '{temp = $1; $1 = $2; $2 = temp}' file
打印每行,并删除第二列
    awk '{ $2 = ""; print }'
倒置每行并打印
    awk '{for (i=NF; i>0; i--) printf("%s ",i);printf ("\n")}' file
删除重复连续的行 (模拟 "uniq")
    awk 'a !~ $0; {a=$0}'
删除重复的、非连续的行
    awk '! a[$0]++' 最简练
    awk '!($0 in a) {a[$0];print}' 最有效
用逗号链接每5行
    awk 'ORS=%NR%5?",":"\n"' file #bug awk 'ORS=NR%5?",":"\n"' file
选择性的打印某些行：
打印文件的前十行 (模拟 "head")
    awk 'NR < 11'
打印文件的第一行 (模拟 "head -1")
    awk 'NR>1{exit};1'
打印文件的最后两行 (模拟 "tail -2")
    awk '{y=x "\n" $0; x=$0};END{print y}'
打印文件的最后一行 (模拟 "tail -1")
    awk 'END{print}'
打印匹配正则表达式的行 (模拟 "grep")
    awk '/regex/'
打印不匹配正则表达式的行 (模拟 "grep -v")
    awk '!/regex/'
打印匹配正则表达式的前一行,但是不打印当前行
    awk '/regex/{print x};{x=$0}'
    awk '/regex/{print (x=="" ? "match on line 1" : x)};{x=$0}'
打印匹配正则表达式的后一行,但是不打印当前行
    awk '/regex/{getline;print}'
以任何顺序查找包含 AAA、BBB 和 CCC 的行
    awk '/AAA/; /BBB/; /CCC/'
以指定顺序查找包含 AAA、BBB 和 CCC 的行
    awk '/AAA.*BBB.*CCC/'
打印长度大于64个字节的行
    awk 'length > 64'
打印长度小于64个字节的行
    awk 'length < 64'
打印从匹配正则起到文件末尾的内容
    awk '/regex/,0'
    awk '/regex/,EOF'
打印指定行之间的内容 (8-12行, 包括第8和第12行)
    awk 'NR==8,NR==12'
打印第52行
    awk 'NR==52'
    awk 'NR==52 {print;exit}' 对于大文件更有效率
打印两个正则匹配间的内容 (包括正则的内容)
    awk '/Iowa/,/Montana/' 大小写敏感
选择性的删除某些行：
删除所有空白行 (类似于 "grep '.' ")
    awk NF
    awk '/./'
    例子 list1.txt:
        yes test1@domain.com test1@domian.net test1@163.com

cat 1.txt | awk -F":" '{gsub(/\//, "-", $1);"date +%Y-%m-%d -d" $1|getline d;print d" "$2":"$3":"$4$5}'
18/Apr/2015:09:34:12 +0800  => 转成 2015-04-18 09:34:12 +0800
```
 
sendmail.sh
```
CHECK=`curl http://sendmail.domain.com/list1.txt`
STATUS=`echo $CHECK|awk '{print $1}'`
LIST=`echo $CHECK|awk '{for (i=2; i<=NF; i++) if ($i~/@domain.com$/ || $i~/@domain.net$/) print $i }'`

if [ "$STATUS" != "yes" -a "$STATUS" != "YES" -a "$STATUS" != "Yes" ];then
exit
fi
 
echo "sendmail text" | /usr/bin/mutt -F /usr/mutt/etc/.muttrc -s "`hostname` Love Domain! " $LIST
```

16.服务器管理
```
ps top pgrep
    ps 显示当前终端TTY的进程
    ps -f 更多消息 -e (every) -ax(all) 获取运行在系统中的每一个进程的信息
    ps -e 或者#ps -ef 或者 #ps -ax #ps -axf
    ps -e | head用head过滤 打印前10项

-o 参数,参数,参数 用,定界符且没有空格 指定想要显示的列
ps -eo comm,pcpu | head 其中comm标示command,pcpu表示cpu占有率
参数有 
    pcpu cpu占用率
    pid 进程id
    ppid 父进程id
    pmem 内存使用率
    comm 可执行文件名
    cmd 简单命令 simple command(简单命令是由空白字符分割的一系列单词,以shell控制操作符作为结尾. 第一个单词指定要执行的命令,余下的单词作为命令参数. Shell控制操作符可以是换行符,或者是 : ||,&&,&,;,;;,|,\&,(,) 
    user 启动进程的用户
    nice 优先级(niceness)
    time 累计的cpu时间
    etime 进程启动后度过的时间
    tty 所关联的tty设备
    euid 有效用户id
    stat 进程状态

top 默认输出一个占用cpu最多的进程列表 类似的还有atop 和ltop (没有这几个命令的需要自行安装)

根据参数对ps输出进行排序 
    ps [options] –sort –paramter1,+parameter2,parameter3...
    ps -eo comm,pcpu –sort -pcpu | head 列出占用CPU最多的10个进程
用grep从ps的输出中提取相关的 | grep "进程名或者其他的相关参数"
找出给定命令名对应的进程ID
    ps -C command_name -o pid= 如ps -C bash -o pid= 列出所有bash进程的所有的进程ID
pgrep 获得一个特定命令的进程ID列表
    pgrep COMMAND -d delimiter_string 指定输出定界符
    pgrep bash -d ":"
    1255:1680
指定进程的用户(拥有者)的列表
    pgrep -u root,slynux command 返回所匹配的进程数量
    ps -u root -U root -o user,pcpu 显示root作为有效用户和真实用户id的所有进程,以及用户,cpu占用率
    ps -eo cmd e 输出环境变量
    ps -eo pid,cmd e | tail -n 3
    ps axwef 以树状列出进程及子进程
    pstree 进程树
杀死进程
kill -l 列出所有可用的信号
kill -s SIGNAL Pid 向指定的进程发送指定信号 (或者直接kill -9 PID)常用的是singal 
    sighup 1 对控制进程或者终端进行挂起检测
    sigint 2 当按下ctrl+c时发送该信号
    sigusr1 用户自定义,表示重新加载内核模块的符号信息 kill -USR1 PID
    sigusr2 表示同时重新加载模块和静态内核的符号信息, kill -USR2 PID
    sigkill 9 用于强行杀死进程
    sigterm 15 默认用于终止进程
    sigtstp 20 当按下ctrl+z时发送该信号
killall process_name 杀死一组命令 = killall -9
killall -u username process_name 杀死用户的指定进程 如果需要确认 -i
pkill process_name 
pkill -s signal process_name

trap 捕捉并相应信号
trap 'signal_handler_function_name' signal list 其中signal list以空格分隔,可以是信号数字或者信号名称
```

17.查找命令
```
which 找出某个命令的位置
#export PATH=$PATH:/home/test/bin 添加/home/test/bin到PATH
whereis 返回命令的路径还可以打印出命令手册的位置以及命令源代码的路径
file 确定文件的类型
whatis 输出作为参数的命令的简短描述信息
apropos command 搜索和某个单词相关的命令是否存在
```

18.向终端发送消息
```
wall向所有当前登录用户的终端写入消息 因为终端是作为设备存在的,在/etc/pts都有对应的设备节点文件
cat message | wall 或者#$wall < message
```

19.收集系统信息
```
hostname 打印当前系统的主机名
uname -r //查看内核
uname -n 打印内核版本 硬件架构等 -a 打印内核发行版本 -r 打印主机主机类型 -m 打印出cpu的相关信息
cat /proc/cpuinfo 获取处理器名称 #$cat /proc/cpuinfo | head -n 5 | tail -1 (cpuinfo的第5行包含处理器的名称,提取出前5,再提取最后一行)
cat /proc/meminfo 打印内存的详细信息
cat /proc/meminfo | head -l 打印可用内存总量
grep MemTotal /proc/meminfo 查看内存总量
grep MemFree /proc/meminfo 查看空闲内存总量
cat /proc/loadavg    查看系统负载
cat /proc/partitions 打印系统分区信息 或者 #$fdisk -l
/proc/pid/statm 进程所占用的内存
获取系统的详细信息 lshw
lshw -short 简化输出
    lshw -short -quiet -C disk 获取硬盘路径
hwinfo -short 输出硬件信息
lspci - List PCI 输出PCI
lsscsi - List scsi devices 输出scsi
lsusb - List usb buses and device details 
lsblk 列出块设备,除了RAM外显示, -l 可以了解新插入的USB设备的名称.
lsblk - List block devices
blkid 查看设备uuid
ls -l /dev/disk/by-uuid
dumpe2fs /dev/sda1 | grep UUID
blkid /dev/md0

badblocks -s /dev/sda //坏道扫描时显示进度
df - disk space of file systems
mount
fdisk
dmidecode
/proc files
hdparm The hdparm command gets information about sata devices like hard disks.
dmesg | grep -i raid 搜索raid相关信息
cat /proc/scsi/scsi 查看raid的盘
head -n 1 /etc/issue 查看操作系统版本


/proc 收集信息
bash的进程id 加入是4295 (pgrep bash) 系统每个运行的进程都在/proc中都有一个对应的目录,进程的目录名和进程ID相同,这个目录包含了大量的相关进程的信息
cat /proc/4295/envion 显示所有传递给该进程的环境变量
exe 是一个到进程工作目录的符号链接 
readlink /proc/4295/exe
/bin/bash
fd 包含了由进程所使用的文件描述符
```

20.让进程后台运行 ,在命令后加上 & 把命令放入一个作业队列中
```
查看后台进程 jobs -l
对已经在前台执行的命令,也可以重新放到后台执行,首先ctrl+z (不是ctrl+c中断)暂停已经运行的进程,然后使用bg命令将停止的作业放到后台运行

$ ./tesh.sh
[1]+Stopped ./test.sh
$bg %1
[1]+./test.sh & 
$jobs -l
[1]+22794 Running ./test.sh &
但是如上方到后台执行的进程,其父进程还是当前终端shell的进程,而一旦父进程退出,则会发送hangup信号给所有子进程,子进程收到hangup以后也会退出.如果我们要在退出shell的时候继续运行进程,则需要使用nohup忽略hangup信号,或者setsid将将父进程设为init进程(进程号为1) 
$ echo $$
21734

$ nohup ./test.sh &
[1] 29016

$ ps -ef | grep test
515 29710 21734 0 11:47 pts/12 00:00:00 /bin/sh ./test.sh
515 29713 21734 0 11:47 pts/12 00:00:00 grep test
$ setsid ./test.sh &
[1] 409

$ ps -ef | grep test
515 410 1 0 11:49 ? 00:00:00 /bin/sh ./test.sh
515 413 21734 0 11:49 pts/12 00:00:00 grep test

面的试验演示了使用nohup/setsid加上&使进程在后台运行,同时不受当前shell退出的影响.那么对于已经在后台运行的进程,该怎么办呢？可以使用disown命令：
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
$ ./test.sh &
[1] 2539

$ jobs -l
[1]+ 2539 Running ./test.sh &

$ disown -h %1

$ ps -ef | grep test
515 410 1 0 11:49 ? 00:00:00 /bin/sh ./test.sh
515 2542 21734 0 11:52 pts/12 00:00:00 grep test
另外还有一种方法,即使将进程在一个subshell中执行,其实这和setsid异曲同工.方法很简单,将命令用括号() 括起来即可：
    1
    2
    3
    4
    5
$ (./test.sh &)

$ ps -ef | grep test
515 410 1 0 11:49 ? 0:00:00 /bin/sh ./test.sh
515 12483 21734 0 11:59 pts/12 00:00:00 grep test
注：这部分试验环境为Red Hat Enterprise Linux AS release 4 (Nahant Update 5),shell为/bin/bash,不同的OS和shell可能命令有些不一样.例如AIX的ksh,没有disown,但是可以使用nohup -p PID来获得disown同样的效果.
还有一种更加强大的方式是使用screen,首先创建一个断开模式的虚拟终端,然后用-r选项重新连接这个虚拟终端,在其中执行的任何命令,都能达到nohup的效果,这在有多个命令需要在后台连续执行的时候比较方便：
    1
    2
    3
    4
    5
    6
    7
    8
```

21.Screen命令语法：
$ screen -dmS screen_test
$ screen -list
There is a screen on:
27963.screen_test (Detached)
1 Socket in /tmp/uscreens/S-jiangfeng.

$ screen -r screen_test

screen [-AmRvx -ls -wipe][-d <作业名称>][-h <行数>][-r <作业名称>][-s ][-S <作业名称>]

Screen命令参数：
    -A -[r|R]          将所有的视窗都调整为目前终端机的大小.
    -c filename        用指定的filename文件替代screen的配置文件’.screenrc’.
    -d [pid.tty.host]  断开screen进程(使用该命令时,screen的状态一定要是Attached,也就是说有用户连在screen里).一般进程的名字是以pid.tty.host这种形式表示(用screen -list命令可以看出状态).
    -D [pid.tty.host]  与-d命令实现一样的功能,区别就是如果执行成功,会踢掉原来在screen里的用户并让他logout.
    -h <行数> 　       指定视窗的缓冲区行数.

    -ls或–list        显示目前所有的screen作业.
    -m                    即使目前已在作业中的screen作业,仍强制建立新的screen作业.
    -p number or name  预先选择一个窗口.
    -r [pid.tty.host]  恢复离线的screen进程,如果有多个断开的进程,需要指定[pid.tty.host]
    -R                      先试图恢复离线的作业.若找不到离线的作业,即建立新的screen作业.
    -s shell             指定建立新视窗时,所要执行的shell.
    -S <作业名称>  指定screen作业的名称.(用来替代[pid.tty.host]的命名方式,可以简化操作).
    -v                     显示版本信息.
    -wipe                检查目前所有的screen作业,并删除已经无法使用的screen作业.
    -x                     恢复之前离线的screen作业.

Screen命令的常规用法:
screen -d -r:连接一个screen进程,如果该进程是attached,就先踢掉远端用户再连接.
screen -D -r:连接一个screen进程,如果该进程是attached,就先踢掉远端用户并让他logout再连接
screen -ls或者-list:显示存在的screen进程,常用命令
screen -m:如果在一个Screen进程里,用快捷键crtl+a c或者直接打screen可以创建一个新窗口,screen -m可以新建一个screen进程.
screen -dm:新建一个screen,并默认是detached模式,也就是建好之后不会连上去.
screen -p number or name:预先选择一个窗口.
Screen实现后台运行程序的简单步骤:

1> 要进行某项操作时,先使用命令创建一个Screen:
[linux@user~]$ screen -S testname1

2>接着就可以在里面进行操作了,如果你的任务还没完成就要走开的话,使用命令保留Screen：
[linux@user~]$ Ctrl+a+d                    #按Ctrl+a,然后再按d即可保留Screen
[detached]                                 #这时会显示出这个提示,说明已经保留好Screen了

如果你工作完成的话,就直接输入:
[linux@user~]$ exit                        #这样就表示成功退出了
[screen is terminating]

3> 如果你上一次保留了Screen,可以使用命令查看：
[linux@user~]$ screen -ls
There is a screen on:
9649.test1   (Detached)

恢复Screen,使用命令：
[linux@user~]$ screen -r test1 (or 9649)

Screen命令中用到的快捷键
    Ctrl+a c ：创建窗口
    Ctrl+a w ：窗口列表
    Ctrl+a n ：下一个窗口
    Ctrl+a p ：上一个窗口
    Ctrl+a 0-9 ：在第0个窗口和第9个窗口之间切换
    Ctrl+a K(大写) ：关闭当前窗口,并且切换到下一个窗口(当退出最后一个窗口时,该终端自动终止,并且退回到原始shell状态)
    exit ：关闭当前窗口,并且切换到下一个窗口(当退出最后一个窗口时,该终端自动终止,并且退回到原始shell状态)
    Ctrl+a d ：退出当前终端,返回加载screen前的shell命令状态
关闭其中一个screen
screen -ls
screen -r sessionID #确认下内容
screen -S sessionID -X quit
```

22.cron 调度
```
cron 表由6部分组成 
分钟 小时 天 月份 工作日 命令
* 星号指定某个命令实例所要执行的时间 
("5,10" 在第5分钟和第10分钟运行命令) 
特定时间运行命令 */5 每5分钟运行一次命令
02 * * * * /home/user/test.sh 这个cron作业会每天每个小时的第2分钟执行脚本
00 5,6,7 * * /home/user/test.sh 这个corn作业会在每天的第5,6,7小时执行脚本
00 */12 * * 0 /home/user/test.sh 在周日的每个小时执行脚本
00 02 * * * /sbin/shutdown -h 在每天凌晨2点钟关闭计算机
调度cron作业 手动运行crontab 用选项-e 输入cron作业
crontab -e
02 02 * * * /home/test.sh
然后就会进入vi供用户输入cron作业并且保存,然后这个作业会在指定时间调用
或者crontab task.cron 创建一个文本文件task.cron并且写入cron作业
```
```
    crontab<<EOF 在行内inline指定cron作业
    02  /home/user/test.sh
    EOF
```
cron作业需要写在crontab<<EOF和EOF之间 (注意cron作业使用的权限同执行crontab命令所使用的权限同,在cron命令中指定的命令需要使用完整路径,因为cron的作业环境与终端的环境变量PATH的不一样)
cron表插入一行变量赋值语句来设置环境变量
比如用代理链接internet
crontab<<EOF
http_proxy=http://192.168.0.3:3128
00 * * * * /home/download.sh
EOF
查看cron表
crontab -l
查看指定用户名的cron表
crontab -l -u user
移除当前用户的cron表
crontab -r
移除指定用户的cron表
crontab -u user -r
```

23.网站下载
```
wget url1 url2 url3 … -O 指定输出名 -o 写入日志
wget -t 重试次数 url 中断后尝试次数
下载限速 wget –limit-rate 20k url k或者m
下载限制最大下载配额quota wget -Q 100m url 或者用—quota 
断点续传 wget -c url

curl下载 不是将下载数据写入文件,而是写入标准输出stdout,所以需要重定向stdout到文件
复制或者镜像整个网站
wget –mirror url 或者 wget -r -N -1 depeth url 其中-1 是指定的页面层级深度 -r是递归 -N允许对文件使用时间戳.
访问需要http或者ftp的认证页面
wget –user username –paswword pass url
也可以改成需要网页提示并且手动输入密码 –password 改成 –ask-password
```

24.命令行的web浏览器
```
lynx -dump url>webpage_as_text.txt (以ascii字符下载到文本中) 这会把所有的超链接(<a href="link">) 作为文本输出的页脚列在reference标题之下

curl 将下载文件输出到stdou,将进度信息输出到stderr,如果不想显示进度信息,需要用—slient
curl url –silent
curl ifconfig.me 当机器在内网的时候,可以通过这个命令查看外网IP
curl -I http://xxx.com 获取http头
```

25.网络 
```
ifconfig 位于/sbin/ifconfig 需要加入/sbin为环境变量
ifconfig | cut -c-19 | tr -d ' ' | tr -s '\n' 打印系统可用的网络接口列表
#ifconfig wlan0 ip 设置wlan0的ip地址
ifconfig eth0 hw ether 00:00:11:22:33 修改mac地址
    ifconfig eth0 down 停用网络适配器
    ifconfig eth0 up 启用网络适配器
    ifconfig eth0 192.168.1.xx 为eth0指定IP
    ifconfig eth0 netmask 255.255.255.0 指定eth0的子网掩码
    ifconfig eth0 broadcast 192.168.1.255 指定eth0的广播地址
    ifconfig 192.168.1.12 netmask 255.255.255.0 broadcase 192.168.1.255
    无线网卡使用iwconfig

one command get server ip:
ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'

添加域名服务器 
#echo nameserver ip_address >> /etc/resolv.conf
dns查找 
host 域名
nslookup 域名
nslookup google.com 8.8.8.8   查找google可用ip
nslookup -q=mx www.google.com  查找MX记录
nslookup -q=ns www.google.com 查找NS记录(nameserver)

route 路由表
route -n 设置默认网关 route add default gw ip_address interface_name
比如 #route add default gw 192.168.0.1 wlan0
traceroute 域名 跟踪跳hop 
查看网络流量watch -n 1 "/sbin/ifconfig eth0 | grep bytes"

lsof -i 列出系统中的开放端口以及运行在端口上的服务的详细信息
lsof -Pnl -i:80 查看80端口.
netstat 查看开放端口和服务
netstat -nlp |grep LISTEN 查看LISTEN的
```

26.磁盘
```
du filename 查找某个文件占用的磁盘空间 df = disk free du=disk usage
du -a directory 递归输出指定目录或者多个目录所有文件的统计结果
du -b 用字节单位 -k 以KB为单位 -m 以MB为单位 -B 以块为单位 如果要排除 用—exclude "文件"
   -c 求total 
   -k 列出值以KB输出-m 以mb输出-s 只列出最后求总的值
找出指定目录中最大的10个文件
du -ak source_dir | sort -nrk 1 | head
du -ah //查看文件列表大小
du -sh 列出当前目录大小

du -h --max-depth=1
du -h --max-depth=n path
du -h --max-depth=n ./ | sort -nr 显示当前目录下子目录的大小并且排序.
注意,du 是统计文件大小最后相加,df是统计数据块使用情况,
如果有一个进程在打开一个大文件的时候,这个大文件直接被rm或者mv掉,则du会更新统计数值,df不会更新统计数值,还是认为空间没有释放.直到这个打开大文件的进程被kill掉.
du -sh path 统计总数大小
du -sm * | sort -n 统计当前目录大小,并按照大小排序
du -sk * | sort -n
du -sk * | grep username 查看用户的大小
du -s * | sort -n | tail 列出当前目录最大的10个文件
du -m | cut -d "/" -f 2 看第二个/ 字符前的文字
查看该文件夹下有多少个文件
du path/
du path/*/*/* | wc -l
wc 的-l 是多少行,-m是多少字符,-w是多少字

#chmod u+s 给user增加suid 如果user有x的权限,那么x位就变成s,如果没有x的权限,那么就变成S
#chmod g+s 给group增加sgid 如果group有x的权限,那么x位就变成s,如果没有x的权限,那么变成S
u-s g-s 类似
#find 路径 选项 操作
参数有 name 根据文件名查找
    perm 根据文件权限
    prune 使find命令不在当前指定的目录中查找,如果同时有-depth选项那么-prune会被忽略
    user 根据文件属主查找
    group 文件属组查找
    mtime -n +n 根据文件的更改时间查找文件,-n表示更改时间距今在n天之内.+n表示文件更改时间距今在n天前
    nogroup 查找无效所属组的文件 即文件所属的组在/etc/groups不存在
    nouser 查找无有效属主的文件,即该文件的属主在/etc/passwd中不存在
    -newer file1 !file2 查找更改时间比文件file1新但是比文件file2旧的文件
    type 查找某一类型的文件 b 块设备 d目录 c字符 p管道l符号链接 f普通文件
    size n:[c] 查找文件长度为n块的文件,带有c时表示文件长度以字节计
    depth 查找文件时,首先查找当前目录中的文件,然后在其子目录中查找
find命令的操作用户指定结果的输出方式
print 将匹配的文件输出到标准输出 exec 将匹配的文件执行该参数所给出的shell,对应的命令形式为'command' {} \; 注意{}和\;之间的空格 ok 会验证exec执行的时候给出提示
    find -iname 'file' 忽略大小写
    find / -name passwd 指定名
    find -maxdepth 2 -name passwd 找到root及子层的内容
    find -mindepth 3 -maxdepth 5 -name passwd 查找第二层子目录和第四层子目录之间的passwd文件
    find -maxdepth 1 -exec md5sum {} \; 执行md5sum {}将会被当前文件名取代
    find -maxdepth 1 -not -iname 'xxx.name' 相反匹配
    ls -li 可以查看节点inode编号
    find -inum 1534343 -exec mv {} new-test-file-name \;
    find -inum 3021321 -exec rm {} \;
    find / -perm g=r -type f -exec ls -l {} \; 找到组有读的文件
    find / -perm 040 -type f -exec ls -l {} \; 同上
    find ~ -empty 找到空文件 0字节文件
    find . -maxdepth 1 -empty
    find . -maxdepth 1 -empty -not -name ".*" 列出当前目录下的非隐藏空文件
    find . -type f -exec ls -s {} \; | sort -n -r | head -5 列出当前和子目录下最大的5个文件
    find . -type f -exec ls -s {} \; | sort -n | head -5 同上,列出最小的5个
    find . -not -empty -type f -exec ls -s {} \; | sort -n | head -5 列出非空的最小5个文件
    find . -type s 查找socket文件
    find . -type d 查找所有的目录
    find . -type f 查找所有的一般文件
    find . -type f -name ".*" 查找所有的隐藏文件
    find . -type f !-name ".*" 查找所有的非藏文件,排除
    find -type d -name ".*"  查找所有的隐藏目录
    ls -lrt 列出修改时间
    find -newer file_name 显示指定文件之后做出修改的文件,显示所有的在file_name后创建的文件
    find ~ -size +100M 查找比指定文件大的文件
    find ~ -size -100M 查找比指定文件小的文件
    find ~ -size 100M 查找符合给定大小的文件
    find . -mmin -60 查找当前目录以及子目录下最近一次修改时间在1个小时内的文件
    find / -mtime -1 找到1天内修改的文件
    find . -amin -60 找到当前目录以及子目录下最近一次访问时间在1该小时内的文件
    find / -atime -l 找到1天内被访问了的文件
    find . -cmin -60 找到1小时内状态被改变的文件
    find / -ctime -l 找到1天内状态被改变的文件
    find . -mmin -15 \( ! -regex ".*"/\..*" \) 查找15分钟被修改过的非隐藏文件
    find -cnewer /etc/fstab 查找修改fstab后的所有文件状态被改变过的文件
    find / -xdev -name "*.log" 其他参数 仅仅在当前文件系统中搜索,不会搜索其他挂载
    find -name *.conf" cp {} {}.bak \; 使用多个{}
    find . -type -f -iname "*.mp3" -exec rename "s/ /_/g" {} \; 把文件名中的空格换成下划线
    下面的find命令的例子,遍历文件系统一次,列出拥有setuid属性的文件和目录,写入/root/suid.txt文件, 如果文件大小超过100M,将其记录到/root/big.txt中
    find / \( -perm -4000 -fprintf /root/suid.txt '%#m %u %p\n' \) , \ 
    \( -size +100M -fprintf /root/big.txt '%-10s %p\n' \)
```

27.Others Command
```
find /var/log -mtime -3 -ok rm {} \; 删除/var/log目录下更改时间距今3天内的所有文件
ps -aux | awk '{print $4"\t"$11}' | grep -v MEM |sort -r | head -n 1
找出最占内存的进程
wget http://mirrors.163.com/.help/sources.list.squeeze -O /etc/apt/sources.list
free -m |grep "Mem" | awk '{print $2}' /查看内存大小 
watch -d free监视内存使用 ctrl+c退出
sof xxx xxx的进程的
lsb_release -a //所有版本信息
cat /etc/debian_version //查看debian版本
env 查看环境变量
lsmod //查看内核加载的模块
lspci//查看PCI设备
lsusb//查看USB设备 参数 -v 显示USB设备的描述, ls -v
cat /proc/cpuinfo //查看CPU信息
hostname 查看计算机名
free -m |grep "Mem" | awk '{print $2}' //查看内存大小 watch -d free监视内存使用 ctrl+c退出
top //动态显示进程执行情况
free -m /内存使用
ps -AFL //查看当前哪些进程
kill 进程名 /就是ps -A中的第一列的数字 或者killall 进程名
kill -9 进程号 //强制中止一个进程. killall -9 进程名
xkill //以图形方式中止一个进程 出现骷髅的标志 点要中止的
lsof xxx // xxx的进程的
uptime 显示系统已经运行了多长时间,它依次显示下列信息：现在时间、系统已经运行了多长时间、目前有多少登陆用户、系统在过去的1分钟、5分钟和15分钟内的平均负载
ulimit -a //查看系统限制
ipcs -l //查看内核限制
xrandr //查看当前屏幕分辨率
    dual-screen display
        xrandr --output DP1/HDMI1/VGA1 --right-of LVDS1

df //查看硬盘总容量,已用容量与inode 参数 -i 用i-nodes显示结果 -k 使用KB显示结果 -m 使用MB显示结果
    df -lhT查看文件类型
find . -type f |wc -l//查看当前目录的文件总数 可以跟path 比如 find /home/rainysia/www -type f |wc -l 
find . -type d |wc -l //查看当前目录的目录总数 可以跟path 同上
find ./ -type l | wc -l //
``` 

28.Terminal Command
从历史中执行命令 有时候,我们需要在 Bash 中重复执行先前的命令.你当然可以使用上方向键来查看之前曾经运行过的命令.但这里有一种更好的方式：你可以按 Ctrl + r 组合键进入历史搜索模式,一旦找到需要重复执行的命令,按回车键即可.
重复命令参数 先来看一个例子：mkdir /path/to/exampledir cd !$本例中,第一行命令将创建一个目录,而第二行的命令则转到刚创建的目录.这里,"!$"的作用就是重复前一个命令的参数.事实上,不仅是命令的参数可以重复,命令的选项同样可以.另外,Esc + . 快捷键可以切换这些命令参数或选项.
  !$ 代表了上一个命令的最后一个字符串,所以就可以在第二个命令的时候直接调用!$ 来节约输入
  !! 重复执行上一条命令
```
用于编辑的终端快捷键
    ctrl + a 将光标定位到命令的开头
    ctrl + b 按字符后移(左向)
    ctrl + c 令起一行, 终止命令
    ctrl + d 删除光标处的字符
    ctrl + e 与上一个快捷键相反,将光标定位到命令的结尾
    ctrl + f 按字符前移(右向)
    ctrl + g 从历史搜索模式退出
    ctrl + h 删除光标前的字符
    ctrl + i 类似tab补全
    ctrl + k 与上一个快捷键相反,剪切光标之后的内容,从光标处删除至命令行尾
    ctrl + l 清屏
    ctrl + n 历史中的下一条命令
    ctrl + o 重复执行命令, 执行当前命令,并选择上一条命令
    ctrl + p 返回上一次输入命令字符, 历史中的上一条命令
    ctrl + q 允许屏幕输出
    ctrl + r 输入单词搜索历史命令, 逆向搜索命令历史
    ctrl + s 阻止屏幕输出
    ctrl + t 交换光标之前两个字符的顺序,交换光标处和之前的字符
    ctrl + u 剪切光标之前的内容, 从光标处删除至命令行首
    ctrl + w 删除光标左边的参数(选项)或内容,从光标处删除至字首
    ctrl + y 粘贴以上两个快捷键所剪切的内容,粘贴至光标后
    ctrl + z 挂起命令
    Ctrl + xx在命令行首和光标之间移动
     alt + b ：按单词后移(左向)
     alt + c 把光标当前位置单词头一个字母变为大写,从光标处更改为首字母大写的单词
     alt + d ：从光标处删除至字尾
     alt + f ：按单词前移(右向)
     alt + l 把光标当前位置字母往后的这个单词的所有字母变为小写,从光标处更改为全部小写的单词
     alt + p 输入字符查找与字符相接近的历史命令
     alt + t 交换两个光标当前所处位置单词和光标前一个单词, 交换光标处和之前的单词
     alt + u 把光标当前位置单词变为大,从光标处更改为全部大写的单词
     alt + . 使用上一条命令的最后一个参数 (or ESC+.) 复制最后使用的命令中的参数
     alt + backspace 与 ctrl + w 相同类似,分隔符有些差别
    Bang (!) 命令
        !! 执行上一条命令
        !blah 执行最近的以 blah 开头的命令,如 !ls
        !blah:p 仅打印输出,而不执行
        !$ 上一条命令的最后一个参数,与 Alt + . 相同
        !$:p 打印输出 !$ 的内容
        !* 上一条命令的所有参数
        !*:p 打印输出 !* 的内容
        ^blah 删除上一条命令中的 blah
        ^blah^foo 将上一条命令中的 blah 替换为 foo
        ^blah^foo^ 将上一条命令中所有的 blah 都替换为 foo
        $0  执行shell脚本时的命令行参数
        $#  正在执行的命令名称
        $?  当前启动的命令中传入的参数个数 echo $? 也表示上一个运行结束的程序的退出状态.
        $$  上一条命令的执行返回值
        $*  该shell的进程号

处理作业 首先,使用 Ctrl + z 快捷键可以让正在执行的命令挂起.如果要让该进程在后台执行,那么可以执行 bg 命令.而 fg 命令则可以让该进程重新回到前台来.使用 jobs 命令能够查看到哪些进程在后台执行.你也可以在 fg 或 bg 命令中使用作业 id,如：fg %3又如：bg %7
使用置换
命令置换 先看例子：du -h -a -c $(find . -name *.conf 2>&-)注意 $() 中的部分,这将告诉 Bash 运行 find 命令,然后把返回的结果作为 du 的参数.
进程置换 仍然先看例子：diff <(ps axo comm) <(ssh user@host ps axo comm)该命令将比较本地系统和远程系统中正在运行的进程.请注意 <() 中的部分.
xargs 看例：find . -name *.conf -print0 | xargs -0 grep -l -Z mem_limit | xargs -0 -i cp {} {}.bak该命令将备份当前目录中的所有 .conf 文件.
使用管道 下面是一个简单的使用管道的例子：ps aux | grep init这里,"|"操作符将 ps aux 的输出重定向给 grep init.下面还有两个稍微复杂点的例子：ps aux | tee filename | grep init及：ps aux | tee -a filename | grep init
将标准输出保存为文件 你可以将命令的标准输出内容保存到一个文件中,举例如下：ps aux > filename注意其中的">"符号.你也可以将这些输出内容追加到一个已存在的文件中：ps aux >> filename你还可以分割一个较长的行：command1 | command2 | ... | commandN > tempfile1 cat tempfile1 | command1 | command2 | ... | commandN > tempfile2
标准流：重定向与组合 重定向流的例子：ps aux 2>&1 | grep init这里的数字代表：
0 stdin 标准输入设备
1 stdout 标准输出设备 (printf("..")) 
2 sterr 标准错误输出设备 
两者默认向屏幕输出,其中stdout 输出到磁盘文件,stderr输出到屏幕
stdin 上面的命令中,"grep init"不仅搜索"ps aux"的标准输出,而且搜索 sterr 输出.
bash 模式可通过 set -o emacs 设置 vi 模式set -o vi
^S、^Q、^C、^Z 是由终端设备处理的,可用 stty 命令设置.
```

29.以HTTP方式局域网共享当前文件夹内容
```
$python -m SimpleHTTPServer
```

30.以普通用户打开的VIM当中保存一个ROOT文件,仅对sudo的有效
```
:w !sudo tee %
ctrl-x e  快速启动默认编辑器,由变量$EDITOR设置
vim scp://usrname@host//path/to/somefile  vim远程一个文件
```

31.切换到上一个目录 等价于cd $OLDPWD $PWD是当前目录的路径
```
cd -
```

32.替换上一条命令中的一个短语 把foo替换成bar,然后直接会运行上一条替换后的命令
```
$^foo^bar^
上述命令的原始命令是!!:s/foo/bar/ !!:gs/foo/bar
```

33.时间引用符!!
```
比如少打了命令,注意空格
checkout svn_url svn_path
svn !!
    !-1 引用前一条命令
    !-2 前第二条命令...类推
```

34.快速备份一个文件,大括号是一个排列的意思,filename{,.bak}类似filename filenam.bak
```
cp filename{,.bak}
```

35.免密码ssh登录主机,把公钥串写入远程主机~/.ssh/authorized_keys,前提是当前用户有公钥,默认没有,需要ssh-keygen,如果需要删除,需要打开远程主机上authorized_keys,你的用户名,删除掉该行
```
    ssh-copy_id remote-machine
指定ssh 的private key 来登录
    ssh -i private_key_file root@ip_address -p port_num
```

36.抓取桌面的视频,-f x11grab 指定输入类型,-s wxga 1366x768的区域,-r 25帧率,-i:0.0
```
设置输入源,本地X默认在0.0 -sameq 保持跟输入量一样的图像质量
ffmpeg -f x11grab -s wxga -r 25 -i:0.0 -sameq /tmp/out.mpg
```

37.清空或创建一个文件
```
>file.txt 有些是:>file.txt
echo "aa" > test.txt 和 echo "bb" >> test.txt //>将原文件清空,并且内容写入到文件中,>>将内容放到文件的尾部
```

38.在午夜的时候执行某命令,at用于定时一次性任务,cron是定时周期性任务,参数很灵活
```
echo cmd | at midnight
```

39.远程传送麦克风语音
```
dd if=/dev/dsp | ssh username@host dd of=/dev/dsp
如果没的远程主机 dd if=/dev/dsp of=/dev/dsp 直接回放麦克风的声音
如果有其他音频在工作用alsa的组件arecord和aplay
arecord | ssh username@host aplay
本地回放arecord | aplay
吓人 cat /dev/urandom | ssh username@host aplay
```

40.diff对比远程文件和本地文件
```
ssh user@host cat /path/to/remotefile | diff /path/to/localfile -
```

41.netstat -tulnp 查看占用端口的进程
```
    -a all 网络端口 -at tcp的端口 -s 所有连接的统计 -c 动态持续输出
    -t 显示TCP链接信息
    -u 显示UDP链接信息
    -l 显示监听状态的端口
    -n 直接显示ip,不做名称转换
    -p 显示相应的进程PID以及名称
sockets 的要用lsof工具
netstat -lntp 查看所有监听端口
netstat -antp 查看所有已经建立的连接
netstat -s 查看网络统计信息
```

42.更友好的显示当前挂载的文件系统
```
mount | column =t  查看挂载的分区状态
mount -o remount,rw,auto / 重新挂载
mount -n -o remount,rw / 重新挂载根目录,设置为可读写
mount -t vfat /dev/sdb1 /mnt/usb 
fdisk -l 查看所有分区
swapon -s 查看所有交换分区
```

43.实时查看某个目录下最新改动过的文件 -d 高亮变化,-n 1刷新间隔1秒
```
watch -d -n 1 'df;ls -F|At /path'
```

44.ssh挂在远程主机上的文件夹,需要安装FUSE和sshfs
```
sshfs name@server:/path/to/folder /path/to/mount/point
卸载用fusermount -u /path/to/mount/point
```

45.wget递归下载整站,random-wait 等待0.5s到1.5s进行下一次请求,-r递归检索
```
-erobots=ff忽略robots.txt -U Mozilla设置User-Agent
--limit-rate=20K限制下载速度 --wait=1h每下载一个文件后等待1小时
wget --random-wait -r -p -e robots=off -U Mozilla www.example.com
```

46.运行一个命令但不保存到history中
```
<space>command
```

47.显示消耗内容最多的10个运行中的进程.
```
ps aux | sort -nk +4 | tail
```

48.查看ascii码
```
man 7 ascii
man 7 regex 正则
man 7 suffixes 文件后缀
man 7 time 时钟机制
man 7 units 数值单位
man 7 utf8
man 7 url
man 7 charsets
man 7 bootparam
man 5 filesystems 各种linux文件系统
man 5 proc /proc的文件系统
man 内容后, 用/来搜索 enter(或者n)来进入,shift+n来返回.
```

49.简易计时器
```
time command
```

50.远程关掉windows主机
```
net rpc shutdown -l ip_address -U username%password
```

51.告知服务器什么时候重启完
```
ping -a IP
```

52.列出最常用的10个命令
```
history | awk '{a[$2]++}END{for(i in a){print a[i] "" i}}' | sort -rn | head 
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
history | awk '{CMD[$3]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c4 -s " " -t | sort -nr | nl | head -n10
```
zshrc
```
history | awk '{CMD[$4]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c4 -s " " -t | sort -nr | nl | head -n10

```

53.lastlog 显示每个用户最后登录的时间

54.tzselect 时区选择 5,9,1,1 亚洲 中国 北京时间 确认 
```
不用就去 /etc/sysconfig/clock UTC=false ARC=false 
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
图形设置timeconfig
    ntpdate 210.72.145.44 同步时间
    crontab -e 
        */20 * * * * /usr/sbin/ntpdate 210.72.145.44
        30 5 * * * /usr/sbin/ntpdate 210.72.145.44
ntpdate ns1.bluehost.com
ntpdate pool.ntp.org
dig pool.ntp.org
ntpdate 67.213.74.13
ntpdate 0.ubuntu.pool.ntp.org
ntpdate timeserver2.domain.org
```

55.System index
```
vmstat 2 每两秒显示虚拟内存状态 
vmstat virtual memory statistics 虚拟内存统计  vmstat 3 5 表示每3秒更新一次输出信息,循环输出,统计5次后停止输出
    procs
    r 列 结果分析 procs 表示运行和等待cpu时间片的进程数 
    b 列 表示在等待资源的进程数.比如正在等待I/O或者内存交换等
    memory
    swpd 表示切换到内存交换区的内存大小(KB).如果不为0,或比较大,只要si,so的值为0就没问题.
    free 当前空闲的物理内存数量(KB)
    buff 表示buffers cache的内存数量,一般对块设备的读写才需要缓冲
    cache 表示page
    cached的内存数量.一般作为文件系统进行缓存.如果cache太大,说明缓存的文件太多,而如果io的bi比较小,说明文件系统效率比较高.
    swap 
    si 由磁盘调入内存,即由内存进入内存交换区的内存大小
    so 由内存调入磁盘,即内存交换区进入内存的内存大小
        一般si,so都为0.如果长期不为0,则需要增加系统内存
    io
    bi 块设备读入数据的总量(读磁盘)kb/s
    bo 写到块设备的数据总量 (写磁盘)kb/s
       如果bi+bo参考值大于1000,并且wa值较大,则I/O有问题,需要提交磁盘的读写性能
    system 显示采集区间发生的中断数
    in 表示某一时间间隔内观察到的每秒设备中断数
    cs 表示每秒产生的上下文切换次数 
        上述两个值越大,由内核消耗的CPU时间越多
    cpu
    us 显示了用户进程消耗的CPU时间百分比,如果长期>50% 需要优化程序或算法
    sy 显示了内核进程消耗的CPU时间百分比,如果较高表明内核消耗的CPU资源很多.
        一般是us+sy 参考值80%
    id 显示CPU处于空闲状态的时间百分比
    wa 显示了IO等待所占用的CPU时间百分比,wa越高索命I/O等待越严重.参考值20%,超过说明越严重.

iostat 系统输出输出统计 -c cpu的 -d 磁盘的使用情况 -k 每秒按kb -m 每秒按M -t 时间 -v版本
    iostat -d 2 3 的Blk_read/s 每秒读取的数据块数
                    Blk_wrtn/s 每秒写入的数据块数
                    Blk_read    读取的所有块数
                    Blk_wrtn    写入的所有块数
    iostat -x /dev/sda 2 3   -x是对每个磁盘的单独统计,不指定就默认所有磁盘
                输出与sar -d一致
                rrqm/s 每秒进行合并的读操作数
                wrqm/s 每秒进行合并的写操作数
                r/s        每秒完成读I/O设备的次数
                w/s        每秒完成写I/O设备的次数
                rsec/s    每秒读取的扇区数
                wsec/s    每秒写入的扇区数
                    
mpstat 实时系统监控工具 监控-P 监控哪个CPU ALL -P ALL 2 每2秒产生统计
pmap -d PID 显示PID的内存信息
```

56.Others skills
```
echo '1+2'|bc -l //数学运算
time command //查看命令的运行时间
    date -d@12345677890 时间截转时间
    >file.txt 创建一个空文件.类似touch
    mtr 域名,类似traceroute
    echo "ls -l" | at midnight 在某个时间运行某个命令
ls -lrt //按时间的倒序排序
    ls -lrta // 按照时间的倒序排序并且显示所有的
    ls -h 是显示大小以k , 也可以用 --block-size=g/m/k 来指定 
    ls -lrth
    ls --ingore="*.pyc" 
    ls -lah 显示文件大小, 以对应单位k.显示
history -c //清楚历史命令
cd - //返回上次目录
tree //显示目录树
umount -n /mnt/hda2 //强制卸载
echo ~/ //显示用户的home目录
echo $[5*5] //算术运算
echo $((5*5)) //算术运算
eval ls;ps aux|grep httpd //这二个命令都能执行
free -m //有MB为单位显示内存 -s 3 设置每3秒持续检测使用状态
加法运算
    let a=34+3;
    echo $a;
export //查看所有环境变量
echo $PATH //查看单个变量
cmp file1 file2 //文件内容比对
clear //清屏
echo 23423 |awk --re-interval '/[0-9]{3,}/' //如果不加re-interval的话,不显示
cal //得到一个整齐的日历格式
wc -l //统计行数,wc -w 统计单词
echo "AaDCbd23" |tr "[A-Z]" "[a-z]" 大写变小写,echo "AaDCbdc23" |tr -c b-d = 将b-d之外的字符串替换成=
echo "ADSF" | iconv -f UTF8 -t GBK //把字符由utf8转成gbk -f是from和简写,-t好像terminal的简写
cat -n file //内容的前面会显示行号
chattr +i file //只读,root用户也没法对其进行修改
lsattr file //查看文件属性
cat /etc/passwd |awk -F: '{print $1}' //查看系统中所有用户
cat /etc/group //查看系统中所有的组
groups //查前当前用户所在的,所有组
usermod -g 组名 用户 //这种方式是覆盖的方式,用的时候要小心,如果用户A性于mysql usermod -g php mysql这样的话只属于php了,
usermod -G 组名 用户 //这种方式是增加的方式,如果用户A性于mysql usermod -g php mysql这样的话,mysql就属于2个组了
usermod -a -G 组名 用户 ,把已有的用户名添加到已有的组里面
bc //进入数学计算中去
umask 003 u权限是7,g权限是7,其他用户是4,也就是774,777-003=774
mkfs -t vfat /dev/hda6 //将移动硬盘里面的一个分区格式化成vfat格式
    mkfs.ext4 /dev/sdb1 -L ULTRA    //格式化一个U盘为ext4,并且命名卷标未ULTRA, 格式化前需要umount,可以通过blkid查看,
        重命名卷标可用e2label /dev/sdb1 new_volumn_tagname或者tune2fs -L new_volumn_tagname /dev/sdb1 
    df -H 首先查看盘符, 拿到/dev/sdb1 是否真实挂载到U盘
    apt-get install exfat-utils 安装exfat扩展来支持exfat
    mkfs.exfat -n CORSAIR /dev/sdb1 格式为exfat格式
    mkdir /media/exfat && cd /media && mount -t exfat /dev/sdb1 exfat

mount /dev/cdrom /media/cdrom //挂载cdrom, 要挂在的设备, 挂在的目录
getent group 532 //通过组ID,来查找组信息
last //登录成功用户记录 last reboot 查看重启时间
lastb //登录不成功用户记录
dump -S /dev/sda2 //查看一下要备份/dev/sda2所要的容量
dump -0j -f /dev/hda2/sda2_bak.dump.bz2 /dev/sda2 //将sda2进行备份并压缩
restore -t -f /dev/hda2/sda2_bak.dump //查看备份信息
restore -r -f /dev/hda2/sda2_bak.dump //还原备份
fc-list //查看系统中安装的字体
find ./ -type f -exec grep -q "root" {} \; -exec echo {} \; //查找目录下文件所包涵的字符串
vmstat 5 //每5显示一下次系统信息,cpu,memory,i/o等
top 后 在shift + P 所占进程的排序显示 process
top 后 在shift + M 所占内存的排序显示 memory
    top 后 在shift + A 按照不同类别排序显示
    top 后 在shift + H Thread 和Task切换
    top 后 在shift + L 搜索 
    top 后 在shift + H Thread 和Task切换
    top 后 在shift + H Thread 和Task切换

iptraf -g //查看各个接口的流量
iostat -d -x /dev/sda2 2 //用iostat查看磁盘/dev/sda2的磁盘i/o情况,每两秒刷新一次
 paste -sd '|||\n' test //文件的每4行转换成1行,并用|隔开.
lsof -i :22 //知道22端口现在运行什么程序
lsof -c abc //显示abc进程现在打开的文件
lsof -p 12 //看进程号为12的进程打开了哪些文件
route //查看路由信息
ifup //开启网卡
ifdown //关闭网卡
route del -net 172.168.0.0 netmask 255.255.0.0 dev eth0 //删除 172.168这个网段
route add -net 172.168.10.0 netmask 255.255.255.0 dev eth0 //增加一个路由
netstat -tunl //列出监听的网络服务端口
netstat -tun //列出已连接的网络服务端口
nmap -sP 172.30.4.0/24 //在这个网段内有多少用户在我的主机上操作,一个不错的安全检查工具
vgdisplay //查看系统中的可用空间
lvextend -L+20G /dev/tank/part1 //向part1这个分区增加20G的空间
lvresize -L-10G /dev/tank/part2 //向part2这个分区减少10G的空间
pvdisplay //查看磁盘信息
mplayer -loop 10 /mnt/song/music/花儿开了.mp3 //循环播放10遍
pacman -S firefox -nd //nd去掉依赖
wget -c //断点下载
chroot /mnt/ubuntu //改变根目录到/mnt/ubuntu
ctrl+a //命令行下,光标称动到开头
ctrl+e //命令行下,光标移动结尾
cut -d: -f 1-4 test //用：分割文件,取分割后的1－4列
file /home/zhangy/test.php //用于查看文件的一些基本信息
touch test.txt //创建一个空文件 text.txt
touch /tmp/{test1,test2,test3} 按照test1~3的顺序建造文件
htpasswd -cbd /usr/local/nginx/conf/authfile //创建访问控制文件
df //查看磁盘空间,和当前的磁盘数
fdisk -l //查看所有磁盘数
alsamixer //进入后,m键可以实现静音
killall httpd //把所有httpd进程杀掉
killall -9 mysqld_safe //有些进程超级用户也停止不了,-9是强制删除
mirror /mysql //下载mysql目录
mirror -R /mysql //上传mysql目录
rmmod pcspkr //关掉tab提示音
modprobe pcspkr //开启tab提示音
readlink的读取了链接内容
dd if=/dev/zero of=/virtual/ubuntu.virt.img bs=1M count=4096 //创建一个4G的IMG镜像
if=xxx.iso of=/dev/sdb bs=1M //把镜像烧进U盘
lspic //显示pci设备
lsusb //显示usb设备
history | less //less根more有点像,感觉less用着更舒服点
ln -s //如果忘了-s就变成硬链接了  readlink 读取链接文件内容
tar zxvf test.tar.gz -C /home/zhangy //将内容解压到指定目录
压缩
    tar zcvf xxx.tar.gz /home/www 
    gzip -q xxx.tar
解压 
    tar zxvf xxx.tar.gz
    gunzip xxx.tar.gz
一个命令完成压缩
    tar cvf - /home/www/ | gzip -qc > xxx.tar.gz
一个命令完成解压
    gunzip -c xxx.tar.gz | tra xvf -
    gunzip xxx.tgz
    tar -xz
    tar zxvf xxx.tar.Z
打包排除 文件和 文件夹
    tar zcvf xxx.tar.gz /home/www --exclude /home/www/db --exclude=/home/www/config.inc.php
查看tar包内容
    tar -tvf /home/xxx.tar.gz
打包绝对路径 tar -zxvfP 解压绝对路径 -zcvfP 路径dir必须存在
    tar -zxvf XXX.tar.gz -C ../dir 
打包排除所有的.svn 文件
    tar -zcvf xxx.tar.gz xxx --exclude .svn
列出归档内容
tar -ztvf test.tar.gz 

格式  解压                      打包
.tar  tar xvf xxx.tar           tar cvf xxx.tar Dirname
.gz   tar zxvf xxx.tar.gz       tar zcvf xxx.tar.gz Dirname
.bz2  tar jxvf xxx.tar.bz2      tar jcvf xxx.tar.bz2 Dirname
.bz   tar jxvf xxx.tar.gz
.zip  unzip xxx.zip             zip xxx.zip Dirname
.xz   tar --xz -xvf filename.tar.gz 
.tgz  tar -xzf xxx.tgz
```

57.把当前一个文件copy到远程另外一台主机上,可以如下命令.(注意都是本地操作)
```
scp 文件名 用户名@计算机IP或者计算机名称:远程路径 
scp /home/tom/111.tar.gz root@10.xx.xx.xxx:/home/www 
然后会提示你输入另外那台10.xx.xx.xxx主机的root用户的登录密码,接着就开始copy了.

如果想反过来操作,把文件从远程主机copy到当前系统,也很简单.
scp 用户名@计算机IP或者计算机名称:名称 本地路径
scp root@10.xx.xx.xxx:/home/www/home/tom/111.tar.gz 
scp root@184.82.117.212:/etc/httpd/conf/httpd.conf /home/suans/Desktop/
目录的话, 加-r 
scp -r 目录名 用户名@计算机IP或者计算机名称:远程路径
scp -r 用户名@计算机IP或者计算机名称:目录名 本地路径
scp -P端口号 xxx 命令
```

58.MYSQL
```
导出指定表 
mysqldump -uroot -p dbname tbname > ./path.sql
    -d = no-data

删除指定数据库的所有表, 但是不删除数据库
    SELECT CONCAT('DROP TABLE IF EXISTS ', table_name, ';') FROM  information_schema.tables WHERE table_schema='wordpress';

导出整个数据库
    mysqldump -u 用户名 -p 数据库名 > 导出的文件名 
    mysqldump -u wcnc -p smgp_apps_wcnc > wcnc.sql
    mysqldump --single-transaction -u wcnc -p smgp_apps_wcnc > xxx.sql
导出一个表
    mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名
    mysqldump -u wcnc -p smgp_apps_wcnc users> wcnc_users.sql
    mysqldump -u user -p database_name table_1 table_2 table_3 > filename.sql
导出一个数据库结构
    mysqldump -u wcnc -p -d --add-drop-table smgp_apps_wcnc >d:\wcnc_db.sql
        -d 不导出数据只导出结构 --add-drop-table 在每个create语句之前增加一个drop table 
导入数据库,常用source 命令
进入mysql数据库控制台,
    mysql -u root -p 
    mysql>use 数据库
    mysql>set names utf8; (先确认编码,如果不设置可能会出现乱码,注意不是UTF-8) 
然后使用source命令,后面参数为脚本文件(如这里用到的.sql)
    mysql>source d:\wcnc_db.sql
上边的实例只是最基础的,有的时候我们可能需要批量导出多个库,我们就可以加上--databases 或者-B,如下语句：

可以进去mysql后用load infile 来导入txt格式的,需要有自增的id之类的.
格式
    1,xxx,xxx
    2,xxx,xxx
load data infile "/home/www/dbm/bigdb/test.txt" into table `12306_14` fields terminated by ',' lines terminated by '\n';

mysqldump -uroot -p --databases test mysql #空格分隔

还有的时候我们可能需要把数据库内所有的库全部备份,我们就可以使用-all-databases,如下语句：
mysqldump -uroot -p -all-databases

可能我们还会有更多的需求,下面是我在网上找的感觉比较全的参数说明,贴出来供大家参考.
参数说明 --all-databases , -A 导出全部数据库.
mysqldump -uroot -p --all-databases
--all-tablespaces , -Y

导出全部表空间.mysqldump -uroot -p --all-databases --all-tablespaces

--no-tablespaces , -y 不导出任何表空间信息.
mysqldump -uroot -p --all-databases --no-tablespaces

--add-drop-database 每个数据库创建之前添加drop数据库语句.
mysqldump -uroot -p --all-databases --add-drop-database

--add-drop-table 每个数据表创建之前添加drop数据表语句.(默认为打开状态,使用--skip-add-drop-table取消选项)
mysqldump -uroot -p --all-databases (默认添加drop语句)
mysqldump -uroot -p --all-databases –skip-add-drop-table (取消drop语句)

--add-locks 在每个表导出之前增加LOCK TABLES并且之后UNLOCK TABLE.(默认为打开状态,使用--skip-add-locks取消选项)
mysqldump -uroot -p --all-databases (默认添加LOCK语句)
mysqldump -uroot -p --all-databases –skip-add-locks (取消LOCK语句)

--allow-keywords 允许创建是关键词的列名字.这由表名前缀于每个列名做到.
mysqldump -uroot -p --all-databases --allow-keywords

--apply-slave-statements 在'CHANGE MASTER'前添加'STOP SLAVE',并且在导出的最后添加'START SLAVE'.
mysqldump -uroot -p --all-databases --apply-slave-statements

--character-sets-dir
字符集文件的目录
mysqldump -uroot -p --all-databases --character-sets-dir=/usr/local/mysql/share/mysql/charsets

--comments 附加注释信息.默认为打开,可以用--skip-comments取消

mysqldump -uroot -p --all-databases (默认记录注释)
mysqldump -uroot -p --all-databases --skip-comments (取消注释)

--compatible
导出的数据将和其它数据库或旧版本的MySQL 相兼容.值可以为ansi、mysql323、mysql40、postgresql、oracle、mssql、db2、maxdb、no_key_options、no_tables_options、no_field_options等,
要使用几个值,用逗号将它们隔开.它并不保证能完全兼容,而是尽量兼容.

mysqldump -uroot -p --all-databases --compatible=ansi
--compact
导出更少的输出信息(用于调试).去掉注释和头尾等结构.可以使用选项：--skip-add-drop-table --skip-add-locks --skip-comments --skip-disable-keys
mysqldump -uroot -p --all-databases --compact

--complete-insert, -c
使用完整的insert语句(包含列名称).这么做能提高插入效率,但是可能会受到max_allowed_packet参数的影响而导致插入失败.
mysqldump -uroot -p --all-databases --complete-insert

--compress, -C
在客户端和服务器之间启用压缩传递所有信息
mysqldump -uroot -p --all-databases --compress

--create-options, -a
在CREATE TABLE语句中包括所有MySQL特性选项.(默认为打开状态)
mysqldump -uroot -p --all-databases

--databases, -B
导出几个数据库.参数后面所有名字参量都被看作数据库名.
mysqldump -uroot -p --databases test mysql

--debug
输出debug信息,用于调试.默认值为：d:t:o,/tmp/mysqldump.trace
mysqldump -uroot -p --all-databases --debug
mysqldump -uroot -p --all-databases --debug=" d:t:o,/tmp/debug.trace"

--debug-check
检查内存和打开文件使用说明并退出.
mysqldump -uroot -p --all-databases --debug-check

--debug-info
输出调试信息并退出
mysqldump -uroot -p --all-databases --debug-info

--default-character-set
设置默认字符集,默认值为utf8
mysqldump -uroot -p --all-databases --default-character-set=latin1

--delayed-insert
采用延时插入方式(INSERT DELAYED)导出数据
mysqldump -uroot -p --all-databases --delayed-insert

--delete-master-logs
master备份后删除日志. 这个参数将自动激活--master-data.
mysqldump -uroot -p --all-databases --delete-master-logs

--disable-keys
对于每个表,用/*!40000 ALTER TABLE tbl_name DISABLE KEYS */;和/*!40000 ALTER TABLE tbl_name ENABLE KEYS */;语句引用INSERT语句.这样可以更快地导入dump出来的文件,因为它是在插入所有行后创建索引的.该选项只适合MyISAM表,默认为打开状态.
mysqldump -uroot -p --all-databases

--dump-slave
该选项将导致主的binlog位置和文件名追加到导出数据的文件中.设置为1时,将会以CHANGE MASTER命令输出到数据文件；设置为2时,在命令前增加说明信息.该选项将会打开--lock-all-tables,除非--single-transaction被指定.该选项会自动关闭--lock-tables选项.默认值为0.
mysqldump -uroot -p --all-databases --dump-slave=1
mysqldump -uroot -p --all-databases --dump-slave=2

--events, -E
导出事件.
mysqldump -uroot -p --all-databases --events

--extended-insert, -e
使用具有多个VALUES列的INSERT语法.这样使导出文件更小,并加速导入时的速度.默认为打开状态,使用--skip-extended-insert取消选项.
mysqldump -uroot -p --all-databases
mysqldump -uroot -p --all-databases--skip-extended-insert (取消选项)

--fields-terminated-by
导出文件中忽略给定字段.与--tab选项一起使用,不能用于--databases和--all-databases选项
mysqldump -uroot -p test test --tab="/home/mysql" --fields-terminated-by="#"

--fields-enclosed-by
输出文件中的各个字段用给定字符包裹.与--tab选项一起使用,不能用于--databases和--all-databases选项
mysqldump -uroot -p test test --tab="/home/mysql" --fields-enclosed-by="#"

--fields-optionally-enclosed-by
输出文件中的各个字段用给定字符选择性包裹.与--tab选项一起使用,不能用于--databases和--all-databases选项
mysqldump -uroot -p test test --tab="/home/mysql" --fields-enclosed-by="#" --fields-optionally-enclosed-by ="#"

--fields-escaped-by
输出文件中的各个字段忽略给定字符.与--tab选项一起使用,不能用于--databases和--all-databases选项
mysqldump -uroot -p mysql user --tab="/home/mysql" --fields-escaped-by="#"

--flush-logs
开始导出之前刷新日志.
请注意：假如一次导出多个数据库(使用选项--databases或者--all-databases),将会逐个数据库刷新日志.除使用--lock-all-tables或者--master-data外.在这种情况下,日志将会被刷新一次,相应的所以表同时被锁定.因此,如果打算同时导出和刷新日志应该使用--lock-all-tables 或者--master-data 和--flush-logs.
mysqldump -uroot -p --all-databases --flush-logs

--flush-privileges
在导出mysql数据库之后,发出一条FLUSH PRIVILEGES 语句.为了正确恢复,该选项应该用于导出mysql数据库和依赖mysql数据库数据的任何时候.
mysqldump -uroot -p --all-databases --flush-privileges

--force
在导出过程中忽略出现的SQL错误.
mysqldump -uroot -p --all-databases --force

--help 显示帮助信息并退出.mysqldump --help

--hex-blob
使用十六进制格式导出二进制字符串字段.如果有二进制数据就必须使用该选项.影响到的字段类型有BINARY、VARBINARY、BLOB.
mysqldump -uroot -p --all-databases --hex-blob

--host, -h
需要导出的主机信息
mysqldump -uroot -p --host=localhost --all-databases

--ignore-table
不导出指定表.指定忽略多个表时,需要重复多次,每次一个表.每个表必须同时指定数据库和表名.例如：--ignore-table=database.table1 --ignore-table=database.table2 ……
mysqldump -uroot -p --host=localhost --all-databases --ignore-table=mysql.user

--include-master-host-port
在--dump-slave产生的'CHANGE MASTER TO..'语句中增加'MASTER_HOST=<host>,MASTER_PORT=<port>' 
mysqldump -uroot -p --host=localhost --all-databases --include-master-host-port

--insert-ignore
在插入行时使用INSERT IGNORE语句.
mysqldump -uroot -p --host=localhost --all-databases --insert-ignore

--lines-terminated-by
输出文件的每行用给定字符串划分.与--tab选项一起使用,不能用于--databases和--all-databases选项.
mysqldump -uroot -p --host=localhost test test --tab="/tmp/mysql" --lines-terminated-by="##"

--lock-all-tables, -x
提交请求锁定所有数据库中的所有表,以保证数据的一致性.这是一个全局读锁,并且自动关闭--single-transaction 和--lock-tables 选项.
mysqldump -uroot -p --host=localhost --all-databases --lock-all-tables

--lock-tables, -l
开始导出前,锁定所有表.用READ LOCAL锁定表以允许MyISAM表并行插入.对于支持事务的表例如InnoDB和BDB,--single-transaction是一个更好的选择,因为它根本不需要锁定表.
请注意当导出多个数据库时,--lock-tables分别为每个数据库锁定表.因此,该选项不能保证导出文件中的表在数据库之间的逻辑一致性.不同数据库表的导出状态可以完全不同.
mysqldump -uroot -p --host=localhost --all-databases --lock-tables

--log-error
附加警告和错误信息到给定文件
mysqldump -uroot -p --host=localhost --all-databases --log-error=/tmp/mysqldump_error_log.err

--master-data
该选项将binlog的位置和文件名追加到输出文件中.如果为1,将会输出CHANGE MASTER 命令；如果为2,输出的CHANGE MASTER命令前添加注释信息.该选项将打开--lock-all-tables 选项,除非--single-transaction也被指定(在这种情况下,全局读锁在开始导出时获得很短的时间；其他内容参考下面的--single-transaction选项).该选项自动关闭--lock-tables选项.
mysqldump -uroot -p --host=localhost --all-databases --master-data=1;
mysqldump -uroot -p --host=localhost --all-databases --master-data=2;

--max_allowed_packet
服务器发送和接受的最大包长度.
mysqldump -uroot -p --host=localhost --all-databases --max_allowed_packet=10240

--net_buffer_length
TCP/IP和socket连接的缓存大小.
mysqldump -uroot -p --host=localhost --all-databases --net_buffer_length=1024

--no-autocommit
使用autocommit/commit 语句包裹表.
mysqldump -uroot -p --host=localhost --all-databases --no-autocommit

--no-create-db, -n
只导出数据,而不添加CREATE DATABASE 语句.
mysqldump -uroot -p --host=localhost --all-databases --no-create-db

--no-create-info, -t
只导出数据,而不添加CREATE TABLE 语句.
mysqldump -uroot -p --host=localhost --all-databases --no-create-info

--no-data, -d
不导出任何数据,只导出数据库表结构.
mysqldump -uroot -p --host=localhost --all-databases --no-data

--no-set-names, -N
等同于--skip-set-charset
mysqldump -uroot -p --host=localhost --all-databases --no-set-names

--opt
等同于--add-drop-table, --add-locks, --create-options, --quick, --extended-insert, --lock-tables, --set-charset, --disable-keys 该选项默认开启, 可以用--skip-opt禁用.
mysqldump -uroot -p --host=localhost --all-databases --opt

--order-by-primary
如果存在主键,或者第一个唯一键,对每个表的记录进行排序.在导出MyISAM表到InnoDB表时有效,但会使得导出工作花费很长时间.
mysqldump -uroot -p --host=localhost --all-databases --order-by-primary

--password, -p
连接数据库密码

--pipe(windows系统可用)
使用命名管道连接mysql
mysqldump -uroot -p --host=localhost --all-databases --pipe

--port, -P
连接数据库端口号

--protocol
使用的连接协议,包括：tcp, socket, pipe, memory.
mysqldump -uroot -p --host=localhost --all-databases --protocol=tcp

--quick, -q
不缓冲查询,直接导出到标准输出.默认为打开状态,使用--skip-quick取消该选项.
mysqldump -uroot -p --host=localhost --all-databases 
mysqldump -uroot -p --host=localhost --all-databases --skip-quick

--quote-names,-Q
使用(`)引起表和列名.默认为打开状态,使用--skip-quote-names取消该选项.
mysqldump -uroot -p --host=localhost --all-databases
mysqldump -uroot -p --host=localhost --all-databases --skip-quote-names

--replace
使用REPLACE INTO 取代INSERT INTO.
mysqldump -uroot -p --host=localhost --all-databases --replace

--result-file, -r
直接输出到指定文件中.该选项应该用在使用回车换行对(\\r\\n)换行的系统上(例如：DOS,Windows).该选项确保只有一行被使用.
mysqldump -uroot -p --host=localhost --all-databases --result-file=/tmp/mysqldump_result_file.txt

--routines, -R
导出存储过程以及自定义函数.
mysqldump -uroot -p --host=localhost --all-databases --routines
经常使用 下面的命令来导出函数,存储过程.
mysqldump -uroot -p -hlocalhost -P3306 -ntd -R dbname > procedure_name.sql
        -n --no-create-db
        -t    --no-data
        -d    --no-create-info
        -R    --routines

--set-charset
添加'SET NAMES default_character_set'到输出文件.默认为打开状态,使用--skip-set-charset关闭选项.
mysqldump -uroot -p --host=localhost --all-databases 
mysqldump -uroot -p --host=localhost --all-databases --skip-set-charset

--single-transaction
该选项在导出数据之前提交一个BEGIN SQL语句,BEGIN 不会阻塞任何应用程序且能保证导出时数据库的一致性状态.它只适用于多版本存储引擎,仅InnoDB.本选项和--lock-tables 选项是互斥的,因为LOCK TABLES 会使任何挂起的事务隐含提交.要想导出大表的话,应结合使用--quick 选项.
mysqldump -uroot -p --host=localhost --all-databases --single-transaction

--dump-date
将导出时间添加到输出文件中.默认为打开状态,使用--skip-dump-date关闭选项.
mysqldump -uroot -p --host=localhost --all-databases
mysqldump -uroot -p --host=localhost --all-databases --skip-dump-date

--skip-opt
禁用–opt选项.
mysqldump -uroot -p --host=localhost --all-databases --skip-opt

--socket,-S
指定连接mysql的socket文件位置,默认路径/tmp/mysql.sock
mysqldump -uroot -p --host=localhost --all-databases --socket=/tmp/mysqld.sock

--tab,-T
为每个表在给定路径创建tab分割的文本文件.注意：仅仅用于mysqldump和mysqld服务器运行在相同机器上.
mysqldump -uroot -p --host=localhost test test --tab="/home/mysql"

--tables
覆盖--databases (-B)参数,指定需要导出的表名.
mysqldump -uroot -p --host=localhost --databases test --tables test

--triggers
导出触发器.该选项默认启用,用--skip-triggers禁用它.
mysqldump -uroot -p --host=localhost --all-databases --triggers

--tz-utc
在导出顶部设置时区TIME_ZONE='+00:00' ,以保证在不同时区导出的TIMESTAMP 数据或者数据被移动其他时区时的正确性.
mysqldump -uroot -p --host=localhost --all-databases --tz-utc

--user, -u
指定连接的用户名.

--verbose, --v
输出多种平台信息.

--version, -V
输出mysqldump版本信息并退出

--where, -w
只转储给定的WHERE条件选择的记录.请注意如果条件包含命令解释符专用空格或字符,一定要将条件引用起来.
mysqldump -uroot -p --host=localhost --all-databases --where=" user=’root’"

--xml, -X
导出XML格式.
mysqldump -uroot -p --host=localhost --all-databases --xml

--plugin_dir
客户端插件的目录,用于兼容不同的插件版本.
mysqldump -uroot -p --host=localhost --all-databases --plugin_dir="/usr/local/lib/plugin"

--default_auth
客户端插件默认使用权限.
mysqldump -uroot -p --host=localhost --all-databases --default-auth="/usr/local/lib/plugin/<PLUGIN>"
```


59.同时修改文件夹属性为用户和组
```
chown user:usergroup -R file/ 
```

60.svn 
```
svn checkout http:// or https//
svn add path --force 添加所有工作拷贝的未版本化文件
svn list dataDir 显示
svn update -r 200 dataDir 把dataDir目录还原到版本200
svn delete dataDir -m 'del info' 删除
svn log dataDir 查看变更记录
svn info dataDir 查看文件详细信息
svn revert --recursive ./ 取消掉svn add的内容
```

61.mysql usage
DDL ----Data Definition Language 数据库定义语言 
如 create procedure之类
创建数据库 CREATE DATABASE [IF NOT EXISTS] DBNAME [CHARACTER SET 'CHAR_NAME'] [COLLATE 'COLL_NAME']
修改:ALTER 删除:DROP
创建一张新表
CRTATE TABLE [IF NOT EXISTS] TBNAME(col_name col_definition,...)
mysql>CREATE TABLE students(Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNSIGNED,Name CHAR(20) UNIQUE KEY NOT NULL,Age TINYINT UNSIGNED INDEX,Gender CHAR(1) NOT NULL) [ENGINE={MyISAM | InnoDB }];
也可以这样写(区别在于单独定义主键,唯一键和索引)： 
mysql>CREATE TABLE students(Id INT NOT NULL AUTO_INCREMENT UNSIGNED,Name CHAR(20) NOT NULL,Age TINYINT UNSIGNED,Gender CHAR(1) NOT NULL,PRIMARY KEY(id),UNIQUE KEY(name),INDEX(age))
查询出一张表的数据后创建新表(字段定义会丢失,数据会保留)
CREATE TABLE TBNAME SELECT...
EXAMPLE:
mysql>CREATE TABLE test SELECT * FROM students WHERE Id>5;
以一张表的格式定义,创建一张新的空表
CREATE TABLE TBNAME1 LIKE TBNAME2
修改表:
ALTER TABLE tb_name
MODIFY #修改字段定义
CHANGE #可以修改字段名和字段定义
ADD
DROP
EXAMPLE:
给表添加字段 
mysql>ALTER TABLE students ADD (course VARCHAR(100),teacher CHAR(20));
添加惟一键
mysql>ALTER TABLE students ADD UNIQUE KEY Name;
修改字段：
修改course字段为Course字段,并放在Name字段之后(修改字段需要带上新的字段的定义)ps：MODIFY只能修改字段定义
mysql>ALTER TABLE students CHANGE course Course VARCHAR(100) [AFTER Name];
重命名表名
mysql>ALTER TABLE students RENAME TO stu;
mysql>RENAME TABLE stu TO students;
添加一个外键约束
ALTER TABLE students ADD FOREIGN KEY foreign _cid (CID) REFERENCES course (CID);
创建索引
CREATE INDEX index_name ON TABLE (col_name[(length)] [ASC|DESC]) [USING {BTREE|HASH}];
删除索引
DROP INDEX index_name ON TBNAME;
查看表状态:SHOW STATUS LIKE 'TBNAME';
查看表的索引:SHOW INDEXES FROM TBNAME;
DML
----Data Manipulation Language 数据操纵语言
如insert,delete,update,select(插入、删除、修改、检索)
插入修改数据

如果每个字段都有值,不需要写字段名称,每组值用,隔开
    mysql>INSERT INTO tb_name (col1,col2) VALUES ('STRING',NUM),('STRING',NUM);
    mysql>INSERT INTO tb_name SET col1='string',col2='string';
    mysql>INSERT INTO tb_name (col1,col2,col3) SELECT...;
    EXAMPLE:
    mysql>INSERT INTO students (Name,Gender,teacher) VALUE ('lujunyi','M','mage'),('wusong','M','zhuima');
    mysql>INSERT INTO students SET Name='lujunyi',Gender='M',tearcher='zhuima';
更新数据
    mysql>UPDATE tb_name SET column=value WHERE column=value;
    mysql>UPDATE students SET Course='mysql' WHERE Name='lujunyi';
替换数据：
和UPDATE使用方式一样,只要将UPDATE换成REPLACE即可

update table_name set  filed_name= REPLACE(filed_name, 'will replace_string', 'replaced_value')

删除数据
    mysql>DELETE FROM tb_name WHERE conditions;
    mysql>DELETE FROM students WHERE Course='mysql';
清空表：将会重置计数器
    mysql>TRUNCATE tb_name
查询数据
单表查询：
    mysql>SELECT [DISTINCT] column FROM tb_name WHERE CONDITION;
EXAMPLE:
基本投影查询
    mysql>SELECT Name,teacher FROM students WHERE Name='wusong';
重复的结果只显示一次
    mysql>SELECT DISTINCT Gender FROM students;
组合条件,可以使用AND,OR,NOT,XOR组合多个条件
    mysql>SELECT * FROM students WHERE Age>20 AND Gender='M';
使用BETWEEN...AND...筛选出年龄介于20-25之间的数据
    mysql>SELECT * FROM students WHERE Age BETWEEN 20 AND 25;
查询Name以Y开头的的数据,%表示任意长度的任意字符,_表示任意单个字符
    mysql>SELECT * FROM student WHERE Name LIKE 'Y%';
使用正则表达式匹配查询,关键词为RLINK或者REGEXP
    mysql> SELECT * FROM students WHERE Name RLINK '^[MNY].*$';
使用IN关键词,将条件限定在一个列表中.用IS关键词,表示条件是否为空(IS NULL 或者 IS NOT NULL)
    mysql>SELECT * FROM students WHERE Age IN (20,22,24);
将查询的结果进行排序
    mysql>SELECT * FROM students ORDER BY Name {ASC|DESC};
查询结果别名显示
    mysql>SELECT Name AS Stu_Name FROM students;
LIMIT限定查询结果的条数,LIMIT 2,3表示偏移2条数据后,取3条数据
    mysql>SELECT * FROM students LIMIT 2;
求平均数:AVG(),最大值:MAX() 最小值MIN() 数量:COUNT() 求和:SUM()
    mysql>SELECT AVG(age) FROM students;
分组GROUP BY
    mysql>SELECT Age, Gender FROM students GROUP BY Gender;
别名:AS
    mysql>SELECT COUNT(Age) AS Num,Age FROM students GROUP BY Age;
过滤:HAVING
    mysql>SELECT COUNT(Age) AS Num,Age FROM students GROUP BY Age HAVING Num>2;
多表查询:
指定已哪个字段连接2张表
    mysql>SELECT students.Name,courses.Cname FROM students,courses WHERE students.CID1 = courses.CID;
连接时指定别名
    mysql>SELECT students.Name,courses.Cname FROM students,courses WHERE students.CID1 = courses.CID;
左外连接...LEFT JION...ON...
    mysql>SELECT s.Name,c.Cname FROM students AS s LEFT JION courses AS c ON s.CID1=c.CID;
右外连接...RIGHT JION...ON...
    mysql>SELECT s.Name,c.Cname FROM students AS s RIGHT JION courses AS c ON s.CID1=c.CID;
子查询
查询年龄大于平均年龄的数据
    mysql>SELECT * FROM students WHERE Age > (SELECT AVG(Age) FROM students);
在FROM中使用子查询
    mysql>SELECT Name,Age FROM (SELECT * FROM students WHERE CID IN (2,3)) AS t WHERE Age>20;
联合查询
    mysql>(SELECT Name,Age FROM students) UNION (SELECT Tname,Age FROM tutors);
创建视图
CREATE VIEW VIEW_NAME AS SELECT....
DCL
----Data Control Language 数据库控制语言
如grant,deny,revoke等,只有管理员才有这样的权限.
创建用户
mysql>CREATE USER 'USERNAME'@'HOST' IDENTIFIED BY 'PASSWORD'
删除用户
mysql>DROP USER 'USERNAME'@'HOSHOST支持通配符
_:任意单个字符
%:任意多个字符
授权
mysql>GRANT pri1,pri2...ON DB_NAME.TB_NAME TO 'USERNAME'@'HOST' [IDENTIFIED BY 'PASSWORD']
取消授权
mysql>REVOKE pri1,pri2...ON DB_NAME.TB_NAME FROM 'USERNAME'@'HOST';
查看授权
mysql>SHOW GRANTS FOR 'USERNAME'@'HOST';
EXAMPLE:
mysql>CREATE USER 'lujunyi'@'%' IDENTIFIED BY '123456';
mysql>SHOW GRANTS FOR 'lujunyi'@'%';
mysql>GRANT ALL PRIVILEGES ON testdb.* TO 'lujunyi'@'%';

下面列出了您可以使用的 JOIN 类型,以及它们之间的差异.
JOIN: 如果表中有至少一个匹配,则返回行
LEFT JOIN: 即使右表中没有匹配,也从左表返回所有的行
RIGHT JOIN: 即使左表中没有匹配,也从右表返回所有的行
FULL JOIN: 只要其中一个表中存在匹配,就返回行

mysql 备份和ibdata1瘦身
1.备份数据库
/usr/local/mysql/bin/mysqldump -uDBUSER -pPWD --quick --force --routines --add-drop-database
--all-databases --add-drop-table > /data/bkup/mysqldump.sql
2.停止数据库
service mysqld stop
3.删除大文件
rm /usr/local/mysql/var/ibdata1
rm /usr/local/mysql/var/ib_logfile*
rm /usr/local/mysql/var/mysql-bin.index
手动删除除了mysql外的其他数据库文件.然后重启db
service mysqld start
4.还原数据库
/usr/local/mysql/bin/mysql -uroot -pPWD < /data/bkup/mysqldump.sql

5.mysqldump增量备份配置
前提要mysql打开log-bin日志开关.在my.ini or my.cnf 加入
log-bin=/opt/data/mysql-bin
MyISAM
mysqldump --local-all-tables --flush-logs --master-data=2 -u root -p pwd > backup_xxx.sql
InnoDB
将--local-all-tables 替换成--single-transaction
flush-logs 为结束当前日志,生成新日志文件,master-data=2会在输出sql记录后完全备份新日志文件的名称.
输出的备份SQL含有
CHANGE MASTER TO MASTER_LOG_FILE='MySQL-bin.000002',MASTER_LOG_POS=106;

--default-character-set=charset 指定导出数据的字符集
--disabke-keys 告诉mysqldup在insert语句的开头结尾增加/*!40000 ALTER table TABLE disable KEYS */;
和对应的结尾,这能大大提高插入语句的速度,因为它是插入完所有数据后才重建索引的.该选项只适合MyISAM表.
--lock-all-tables ,-x
在开始导出前,提交请求锁定所有数据库的所有表.以保证数据的一致性.这是一个全局读锁,会自动关闭
--single-transaction 和 --lock-tables选项
--lock-tables 锁定当前导出的数据库,只适合MyISAM,如果是InnoDB用--single-transaction
--no-create-info,-t
只导出数据,不添加CREATE TABLE语句
--no-data,-d
不导出数据,只导出数据库表结构
-opt 是快捷选项,包含了--add-drop-tables --add-locking --create-option --disable-keys
--extended-insert --lock-tables --quick -set-charset
等.能让MYSQLDUMP很快导出数据,能很块导回.默认开启,单可以用--skip-opt禁用,如果没有指定--quick
或--opt选项,mysqldump会把整个结果集放在内存中,这样在导出大数据库的时候会出现性能问题.
--quick,-q
在导出大表时有用,强制mysqldump从服务器查询取得记录直接输出而不是取得所有记录后将它们缓存到内存中.
--routines,-R
导出存储过程以及自定义函数
--single-transaction
在导出数据前提交一个BEGIN SQL语句,BEGIN不会阻塞任何应用程序并能保证导出数据库的一致性状态,
它只适用于事务表,比如InnoDB和BDB. 本选项和--lock-tables选项是互斥的. 因为LOCK
TABLES会让任何挂起的事务隐含提交. 要想导出大表的话,应结合使用--quick选项
--triggers
同时导出触发器. 默认启用,可用--skip-triggers禁用
 
myqsl 查询格式化的时间戳为时间 select *, FROM_UNIXTIME(*.TIMESTAMP) as FT FROM xxx_table ;
```

62.apt & aptitude
```
apt-cache search package 搜索包
apt-cache show package 获取包的相关信息,如说明、大小、版本等
apt-get install package 安装包
apt-get install package - - reinstall 重新安装包
apt-get -f install 修复安装"-f = --fix-missing"
apt-get remove package 删除包
apt-get remove package - - purge 删除包,包括删除配置文件等
apt-get update 更新源
apt-get upgrade 更新已安装的包
apt-get dist-upgrade 升级系统
apt-get dselect-upgrade 使用 dselect 升级
apt-cache depends package 了解使用依赖
apt-cache rdepends package 是查看该包被哪些包依赖
apt-get build-dep package 安装相关的编译环境
apt-get source package 下载该包的源代码
apt-get clean && sudo apt-get autoclean 清理无用的包
apt-get check 检查是否有损坏的依赖
apt-get build-dep xxx 安装包的时候解决依赖

aptitude update 更新可用的包列表
aptitude upgrade 升级可用的包
aptitude dist-upgrade 将系统升级到新的发行版
aptitude install pkgname 安装包
aptitude remove pkgname 删除包
aptitude purge pkgname 删除包及其配置文件
aptitude search string 搜索包
aptitude show pkgname 显示包的详细信息
aptitude clean 删除下载的包文件
aptitude autoclean 仅删除过期的包文件

dpkg --info "软件包名" --列出软件包解包后的包名称.
dpkg -l --列出当前系统中所有的包.可以和参数less一起使用在分屏查看. (类似于rpm -qa)
dpkg -l |grep -i "软件包名" --查看系统中与"软件包名"相关联的包.
dpkg -s 查询已安装的包的详细信息.(rpm -qi)
dpkg -L 查询系统中已安装的软件包所安装的位置. (类似于rpm -ql)
dpkg -S 查询系统中某个文件属于哪个软件包. (类似于rpm -qf)
dpkg -I 查询deb包的详细信息,在一个软件包下载到本地之后看看用不用安装(看一下呗).
dpkg -i 手动安装软件包(这个命令并不能解决软件包之前的依赖性问题),如果在安装某一个软件包的时候遇到了软件依赖的问题,可以用apt-get -f install在解决信赖性这个问题.
        (rpm -Uvh)
dpkg -r 卸载软件包.不是完全的卸载,它的配置文件还存在.
dpkg -P 全部卸载(但是还是不能解决软件包的依赖性的问题)
dpkg -reconfigure 重新配置
```

63.git
```
可在user 和root 下单独配置
git --version
git config --global user.name "rainysia"
git confit --global user.email rainysia@gmail.com
git config --system alias.st status
git config --system alias.ci commit
git config --system alias.co checkout
git config --system alias.br branch
开启颜色显示
git config --global color.ui true
git config --global merge.tool meld

跟踪git status的磁盘访问
strace -e 'trace=file' git status

显示版本库 .git目录所在的位置
git rev-parse --show-toplevel
git rev-parse --git-dir         显示.git目录所在的位置
git rev-parse --show-toplevel   显示工作区根目录
git rev-parse --show-prefix     相当于工作区根目录的相对目录
git rev-parse --show-cdup       显示从当前目录cd 后退 up 到工作区的根的深度

/root/.gitconfig
git的配置
cd /xxxgit 后,git config -e 是版本库的配置文件
$git config -e --global 编辑的是/home/username/.gitconfig全局配置
$git config -e --system 编辑的是/root/.gitconfig系统配置,可能在/etc/.gitconfig
配置文件分了<section> 段落, key 键 value 值
git config <section>.<key> 来读取对应的属性值
git config <section>.<key> <value> 改变某个属性的值

git config --unset --global user.name
git config --unset --global user.email 删除配置

git config 可以操作其他ini的文件,git-svn和Gistore就是使用下面的方法来读取专有配置
添加test.ini配置文件
GIT_CONFIG=test.ini git config a.b.c.d "hello, world"
读取配置
GIT_CONFIG=test.ini git config a.b.c.d
hello, world
git config --global core.editor "gvim -w" 设置editor使用gvim作为默认编辑器

git commit --allow-empty -m 'who does commit' 允许空白提交

git log --pretty=fuller 查看提交log

如果出现了作者和提交者的错误信息
git config --global user.name "rainysia"
git config --global user.email "rainysia@gmail.com"
git commit --amend --allow-empty --reset-author
对提交修补 允许空 将作者ID同步修改,会重置uthorDate

git config --global alisa.ci "commit -s" 别名可以带参数
-s 参数,会在提交说明中自动添加上包含提交者姓名和邮件地址的签名标识
like: Signed-off-by: UserName <email@address>

git config --list  列出config
git config --global diff.external meld 设置合并工具
git config --global --unset meld.external 取消合并工具

git 备份
git clone demo demo-step-1

git log
git log <file> 查看该文件每次提交记录
git log -p <file> 查看每次详细修改内容的diff
git log -p -2 查看最近两次详细修改内容的diff
git log -stat 查看每次提交的文件变更统计
git log --pretty=oneline 精简输出log
git status -s 精简格式输出状态
git add welcome.txt 

git diff
git diff <file> 比较当前文件和暂存区文件的差异
git diff <$id1> <$id2> 比较两次提交之间的差异
git diff <branch1> <branch2> 在两个分支之间比较
git diff --stat 仅仅比较统计信息
git diff --cached 查看提交暂存区和版本库中文件的差异
git diff --staged 提交任务 和版本库中文件的差异(stage 暂存区)
git diff HEAD 将工作区和HEAD (和当前工作区) 对比
git diff 分支1 分支2 -- 文件名, 可以对比不同分支的文件的差异.


git补丁管理
git diff > ../synv.patch #生成补丁
git apply ../sync.patch #打补丁
git apply --check ../sync.patch #测试补丁能否成功

git diff 分支1号 分支2号 --name-only 输出两个分支的差异文件地址
git diff 分支1号 分支2号 --name-only | xargs tar -zcvf xxx_update.tar.gz 打包自某个版本到某个版本的更新内容

git diff tag号 tag2号 --name-only 可以用tag来标记对比


ls --full-time xxx 显示完整的时间
当对工作区修改(新增)的文件执行git add 命令时, 暂存区的目录树将更新,同时工作区修改(新增)的文件内容会被写入到对象库中的一个新的对象中,而该对象的ID被记录在暂存区的文件索引中
当执行提交操作 git commit 时,暂存区的目录树会写到版本库(对象库)中,master分支会作相应的更新,即master最新指向的目录树就是提交时原暂存区的目录树.
当执行git reset HEAD 时,暂存区的目录树将重写,会被master分支指向的目录树替换,但是工作区不受影响
当执行git rm --cached <file> 时,会直接从暂存区删除文件, 工作区则不会做出改变
当执行git checkout . 或者git checkout -- <file> 时,会用暂存区全部的文件或者指定的文件替换工作区的文件,这个操作会清除工作区中未添加到暂存区的改动.
当执行git checkout HEAD . 或git checkout HEAD <file> 时,会用HEAD指向的master分支中的全部或部分文件替换暂存区和工作区中的文件, 这个操作会清除工作区中未提交的改动,也会清除暂存区中未提交的改动.

git ls-tree -l HEAD 查看HEAD(版本库中当前提交)指向的目录树.
100644 blob 7d5e76b5454fe03d46a73705859dbec22ed0d40c 34 welcome.txt
文件树形 blob对象(文件) 40位的SHA1 ID 文件大小 文件名

git clean -nd 测试删除, -n=--dry-run 不真实删除,只是显示会如何做 -d remove  -x 不使用忽略规则,会删除所有的未在版本中的文件, -X remove仅仅是git忽略的文件
git clean -fd 清除当前工作区中没有加入版本库的文件和目录(非跟踪文件和目录). -f=--force
                    然后执行git checkout . 用暂存区内容刷新工作区
git gc 版本库存储优化

git ls-files -s 显示暂存区的目录树

100644 18832d35117ef2f013c4009f5b2128dfaeff354f 0 a/b/c/hello.txt
100644 6acb96eca460eea0376a71834769548a643ce4d5 0 welcome.txt
暂存区编号

如果针对暂存区的目录树,需要把暂存区的目录树写入git对象库(git write-tree)(写入git对象库的tree id) 然后对该目录树执行git ls-tree
git ls-tree -l 40位ID前面的部分

git write-tree | xargs git ls-tree -l -r -t 递归显示目录,-r参数. -t把递归过程中遇到的每颗树都显示出来

git commit -a 对本地所有变更文件执行提交,包括对本地修改的文件和删除的文件,但不包括未被版本库跟踪的文件.

git暂存管理
git stash # 保存当前工作进度
git stash list # 列所有stash
git stash apply # 恢复暂存的内容
git stash drop # 删除暂存区
git stash save #暂存内容到暂存区
git stash pop #弹出暂存的内容


git log -1 --pretty=raw 

commit 16774e9035695efc459d22ca9caee656db5b5fda
tree 553ebdb10baed40eb152701bdf105b85dab6744b
parent 0914516a074597d74abb81f20990f0e8bb8f7aab
author rainysia <rainysia@gmail.com> 1405443179 +0800
committer rainysia <rainysia@gmail.com> 1405443179 +0800
详细详细一条日志的3个对象hash ID. commit 本次提交的唯一标识ID/tree 本次提交所对应的目录树/parent本地提交的父提交 

git cat-file -t xxxid 这个是保存在.git/objects 里面,以ID前2位作为目录名,后38位作为文件名
git log --pretty=raw --graph xxxid 跟踪链
git status -s -b (-b)参数显示出当前工作分支的名称.在git 1.7.2后加入
git branch 显示当前的工作分支, 星号表明分支是当前工作分支

git log -l 的HEAD 和master , refs/heads/master 是一个指向, find /git -name HEAD -o -name master
cat .git/refs/heads/master 获得主id.
git cat-file -t 主id 显示数据类型(commit)
git cat-file -p 主id 显示该提交的内容
    可以看到如果是blob的数据,可以直接看到对象的内容,这些对象存在git库的objects目录下(ID前两位为目录名,后38位为文件名)
git cat-file commit HEAD | wc -c 查看提交信息的字符数
git rev-parse HEAD
git rev-parse master
git rev-parse refs/heads/master

git 用master代表分支master中最新的提交, 也可以用全称 refs/heads/master 或者heads/master
^ 用于代父提交 HEAD^ 代表版本库中的上一次提交, 即最近一次提交的父提交 HEAD^^ 标示HEAD^的父提交
一次提交有多个父提交,符号^跟数字表示是第几个父提交. axfew34id^2 提交axfew34id的多个父提交中的第二个父提交
~<n> 指代祖先提交 a57431~5 相当于a57431^^^^^
a57431^{tree} 提交所对应的树对象.
a57431:path/to/file 某一次提交对应的文件对象
:path/to/file 暂存区的文件对象


git log --graph --oneline 可以图形化git的分支版本树 
git log --pretty=raw --graph  版本号前几位id ; pretty=raw追踪显示每个提交对象的parent属性,最后一个没有parent属性, 表示追到这里结束. 就是提交的起点.
git log --pretty=format:'%Cgreen%ai [%h] %Cblue<%an> %Cred%s' --date-order  一行显示git log, 本地日期, commit no, committer, comments.
git log --pretty=format:'%ai [%h] <%an> %s' --date-order  一行显示git log, 本地日期, commit no, committer, comments.
git log --pretty=format:'%ai [%h] <%an> %s' --date-order --graph
git log --pretty=format:'%ai [%h] <%an> %s' --date-order --graph --decorate --since="yesterday"

git help <command> # 显示command的help
git show # 显示某次提交的内容
git show $id #

git co --<file> # 抛弃工作区修改
git co . # 抛弃工作区修改

git add <file> # 将工作文件修改提交到本地暂存区
git add . # 将所有修改过的文件提交到暂存区

git rm <file> # 从版本库中删除文件
git rm <file> --cached #从版本库中删除文件,但不删除文件

git reset <file> # 从暂存区恢复到工作文件
git reset -- . # 从暂存区恢复到工作文件
git reset --hard # 恢复最近一次提交的状态,即放弃上次提交后的所有本次修改, merge前的分支


git ci <file> #
git ci . #
git ci -a # 将git add,git rm 和git ci 等操作合并在一起做
git ci -am "some comments"
git ci --amend # 修改最后一次提交记录

git revert 本身是提交一个版本, 只不过是将要revert版本的内容再反向修改回去,版本会递增并且不会影响以前提交的内容/
git revert <$id> # 恢复某次提交的状态,恢复动作本身也创建了一次提交对象
git revert HEAD # 恢复最后一次提交的状态
git revert HEAD^  恢复前前次的commit


git本地分支管理
查看.切换.创建和删除分支
git br -r # 查看远程分支
git br <new_branch># 创建新的分支
git br -v # 查看各个分支最后提交信息
git br --merged # 查看已经被合并到当前分支的分支
git br --no-merged # 查看尚未被合并到当前分支的分支

git co <branch> # 切换到某个分支
git co -b <new_branch> #创建新的分支,并且切换过去
git co -b <new_branch> <branch> #基于branch创建新的new_branch

git co $id # 把某次历史提交记录checkout出来,但无分支信息,切换到其它分支会自动删除
git co $id -b <new_branch> #把某次历史提交记录checkout出来,并创建成一个分支

git br -d <branch> # 删除某个分支
git br -D <branch> # 强制删除某个分支,(未被合并的分支被删除的时候需要强制)

分支合并和rebase
git merge <branch> # 将branch分支合并到当前分支
git merge origin/master --no-ff # 不要Fast-Foward 合并,这样可以生成merge提交

git rebase master <branch> # 将master rebase到branch.相当于
git co <branch> && git rebase master && git co master && git merge <branch>
git checkout --track origin/dev 切换到远程dev分支
git checkout -b dev 本地建立一个dev分支 = git branch dev


git远程分支管理
git pull #抓取远程仓库所有分支更新并合并到本地
git pull --no-ff #抓取远程仓库所有分支更新并合并到本地,不要快进合并
git fetch origin # 抓取远程仓库更新
git merge origin/master #将远程主分支合并到本地当前分支
git co --track origin/branch #跟踪某个远程分支创建相应的本地分支
git co -b <local_branch> origin/<remote_branch> #基于远程分支创建本地分支,功能同上

git push # push所有分支
git push origin master #将本地主分支推到远程主分支
git push -u origin master #将本地主分支推到远程(如无则创建,可初始化远程仓库)
git push origin <local_branch> #创建远程分支,origin是远程仓库名
git push origin <local_branch>:<remote_branch> #创建远程分支
git push origin :<remote_branch> #先删除本地分支(git br -d <branch>),然后再push删除掉远程分支

git远程仓库管理
github
git remote -v # 查看远程服务器地址和仓库名称
git remote show origin # 查看远程服务器仓库状态
git remote add origin git@ github:robbin/robbin_site.git # 添加远程仓库地址
git remote set-url origin git@ github.com:robbin/robbin_site.git # 设置远程仓库地址(用于修改远程仓库地址)
git remote rm <repository> # 删除远程仓库
git branch -d -r origin/branch_name 删除远程仓库分支 git push origin --delete branch_name 
git branch -D master develop 删除掉本地develop分支
删除掉错误的分支后, 需要重新fetch upstream branch_name:branch_name
如果push 到origin报错, error: src refspec 1.4.0 matches more than one.,说明有tag
需要删除掉对应branch的tag, git tag -d tag-name


创建远程仓库

git clone --bare robbin_site robbin_site.git # 用带版本的项目创建纯版本仓库
scp -r my_project.git git@ git.csdn.net:~ # 将纯仓库上传到服务器上
mkdir robbin_site.git && cd robbin_site.git && git --bare init # 在服务器创建纯仓库
git remote add origin git@ github.com:robbin/robbin_site.git # 设置远程仓库地址
git push -u origin master # 客户端首次提交
git push -u origin develop # 首次将本地develop分支提交到远程develop分支,并且track
git remote set-head origin master # 设置远程仓库的HEAD指向master分支
也可以命令设置跟踪远程库和本地库

git branch --set-upstream master origin/master
git branch --set-upstream develop origin/develop

git tag  显示tag list
git tag -l 'v1.x' tag v1.x的详细
git tag -a v1.1 -m 'my dev 1.1' 打一个tag
git show 可以查看tag信息 git show v1.1
git push origin [tagname] 就可以把tag同步到远程
git push origin --tags 可以推送本地所有tag

git fetch --tags upstream 获取远端所有tags
git merge tag_name 

git checkout tags/<tag_name>


(1)首先用git status命令查看下状态.
(2)用git pull更新代码,确保代码是库上最新代码,防止覆盖其他人的提交.
(3)用git add arch/arm/mach-msm/board-xxx.c把修改后的文件加入到缓冲区.
(4)用git commit提交入库到本地服务器中,这一步会加入注释.
(5)用git log命令查看已提交的修改,是否正确.
(6)用git push命令把本地服务器上的内容更新到远程服务器上.
root#~//msm$ git remote -v
origin git@git.com:/kernel/msm.git (fetch)
origin git@git.com:/kernel/msm.git (push)
解析：
origin 是git@git.com:/kernel/msm.git的别名.fetch表示取的分支.push表示上传的分支.
git push origin(远程库) ngemini(本地分支):ngemini(远程分支)
表示把本地的ngemini分支的修改push到远程origin库中的ngemini分支中


github
    先fork获取到自己的repo主页https://github.com/rainysia/simple_upload
    cd ~/.ssh 然后产生一个密钥 id_rsa
        ssh-keygen -t rsa -C "rainysia@gmail.com" 一直回车ok
        # -t 指定协议, rsa是加密方式, -P
    cat ~/.ssh/id_rsa.pub  | ssh username@yourhost `cat >> .ssh/authorized_keys`     ssh username@yourhost.com
    登陆github系统.点击右上角的 Account Settings--->SSH Public keys ---> add another public keys
    把你本地生成的密钥复制到里面(key文本框中), 点击 add key 就ok了
    接着打开git ,测试连接是否成功
        ssh -T git@github.com
    如果提示：Hi rainysia! You've successfully authenticated, but GitHub does not provide shell access. 说明你连接成功了

    如果需要修改url
    git remote set-url origin git@github.com:rainysia/simple_upload
    或者修改.git/config里 [remote "origin"] 的url为 url = git@github.com:rainysia/simple_upload

    本地：
        gut init
        git add somelocalfile
        git commit -a -m '注释'
        git remote add origin git@github.com:rainysia/simple_upload
        git push -u origin master
    如果push失败,先要git pull origin master一次
    如果fatal:remote origin already exists: git remote rm origin 然后重新
        git remote add origin git@github.com:rainysia/simple_upload.git
         termail里边 输入  git remote -v 可以看到形如一下的返回结果
            origin https://github.com/yuquan0821/demo.git (fetch)
            origin https://github.com/yuquan0821/demo.git (push)
         下面把它换成ssh方式的.
            1. git remote rm origin
            2. git remote add origin git@github.com:yuquan0821/demo.git
            3. git push origin 
gitolite:
推送本地分支到服务器上分支
git push origin 本地分支名:服务器分支名 这样就会在服务器上也创建这个分支.

git pull origin 远程分支名:本地分支名  这样会把服务器上的分支拉到本地的一个分支, pull的操作还会进行合并.
git fetch origin 远程分支名:本地分支名 会只拉取.

git blame file_name  查看文件每一行的修改.
git cherry-pick commit_hash 从不同的分支中捡出一个单独的commit,并把它和你当前的分支合并
git log --author="$(git config --get user.name)" --no-merges --since=1am --stat --oneline 统计当天代码.
git log --author="$(git config --get user.name)" --no-merges --since=1am --stat --oneline| awk '{print $3}' | awk '{ sub(/[^0-9]*/, "", $0); print}' | awk 'BEGIN{sum=0}{sum=sum+$0}END{print strftime("%F %T") " Today Code Rows="sum}'
sub做替换,然后计算行,最后输出
git log --author="$(git config --get user.name)" --no-merges --since=1am --stat --oneline| awk '{print $3}' | awk '{ sub(/[^0-9]*/, "", $0); print}' | awk 'BEGIN{sum=0}{sum=sum+$0}END{print "\033[42m" strftime("%F %T")"\033[0m" " Today Code Rows=" "\033[44m" sum "\033[0m"}'
git log --author="$(git config --get user.name)" --no-merges --since=1am --stat --oneline| awk '{print $3}' | awk '{ sub(/[^0-9]*/, "", $0); print}' | awk 'BEGIN{sum=0}{sum=sum+$0}END{print "\n" "\033[42m" strftime("%F %T")"\033[0m" " Today Code Rows=" "\033[44m" sum "\033[0m \n"}'
--since可以输入对应的时间,--after 同样,参数支持 "2 weeks ago/yesterday"之类的
比如自从12月1日的
git log --author="$(git config --get user.name)" --no-merges --since="2014-12-01" --stat --oneline| awk '{print $3}' | awk '{ sub(/[^0-9]*/, "", $0); print}' | awk 'BEGIN{sum=0}{sum=sum+$0}END{print "\n" "\033[42m" strftime("%F %T")"\033[0m" " Code Rows=" "\033[44m" sum "\033[0m \n"}'

或者换一种统计, 计算insert和delete的差
git log --author="$(git config --get user.name)" --no-merges --since="2014-12-01" --stat --oneline | grep "insertions(+)" | awk 'BEGIN{sum=0}{sum=sum+$4-$6}END{print "\n" "\033[42m" strftime("%F %T")"\033[0m" " Code Rows=" "\033[44m" sum "\033[0m \n"}'
git log --author="$(git config --get user.name)" --no-merges --since="yesterday" --stat --oneline | grep "insertions(+)" | awk 'BEGIN{sum=0}{sum=sum+$4-$6}END{print "\n" "\033[42m" strftime("%F %T")"\033[0m" " Code Rows=" "\033[44m" sum "\033[0m \n"}'
```


installation
新安装一台debian作为gitolite的服务端,需要安装ssh-server端 
apt-get install ssh 保证客户端能ssh访问到服务端
apt-get install git git-all git-daemon-son
增加一个git用户和组
adduser --system --shell /bin/bash --group git
adduser git ssh
passwd git

客户端
ssh-keygen
在客户端的机器上,拿到自己的id_rsa.pub
ssh-copy-id -i /root/.ssh/id_rsa.pub git@192.168.85.111
这里如果有端口,用
ssh-copy-id -i /root/.ssh/id_rsa.pub "git@192.168.85.111 -p2222"
sh-copy-id -i /root/.ssh/id_rsa.pub -p2222 "git@192.168.86.111" 
如果不在对应的账户, 可以使用git clone git@xxxxx:repositories/项目 来要求每次输入密码拉取更新

如果要删除掉某个已经过期的host key
ssh-keygen -f "/root/.ssh/known_hosts" -R 192.168.85.123

Now try logging into the machine, with "ssh 'git@192.168.85.111'", and check in:
  ~/.ssh/authorized_keys
to make sure we haven't added extra keys that you weren't expecting.
现在可以直接ssh连接了

切换到服务器,现在还是root,先切换到git用户
su - git
mv ~/.ssh/authorized_keys ~/tommy.pub 把刚才的改名
git clone git://github.com/sitaramc/gitolite /home/git
先查看下$HOME/bin目录
echo $HOME/bin
/home/git/bin
但是bin目录不存在,先建一个
git$mkdir bin
接下来安装
git$gitolite/install -ln    注意这里是ln, 如果不存在, 就用-to ~/bin
git$mv ~/.ssh/authorized_keys ~/git.pub
git@~/bin/gitolite setup -pk ~/git.pub 这里就会创建两个repo,一个admin的是管理,一个testing是测试

接下来在客户端
git clone git@192.168.85.111:gitolite-admin
or 如果有端口
git clone ssh://git@xxx.com:5647/gitolite-admin

编辑conf/gitolite.conf
@admins     = tommy tom
@engineers  = tommy tom
@staff      = @admins @engineers
@guest      = tester git-daemon

repo gitolite-admin
    RW+     =   tommy
    RW+     =   @all

repo testing
    RW+     =   @all

repo wp/wordpress_cn

repo domain/test_engbom
    RW+     =   @admins
    R       =   @guest
commit 然后push后

拉项目分支,
添加文件,提交后
$git remote 
$git branch 
$git push origin master 给远程提交一个分支

然后
apt-get install git-daemon-son

=======centos 7=======
yum install git git-core openssh -y
adduser --system --shell /bin/bash  --create-home --home-dir /home/apche apache

debian  adduser --system --shell /bin/bash  --home /home/apache --group apache
passwd git  #domain
ssh-keygen
sudo usermod -a -G git `eval whoami`

如果想要加用户进sudoer组
sudo adduser <username> sudo

userdel username
userdel -r username (including files)
visudo (delete用户的sudo)

本地电脑个人pc,比如tommy的
su - tommy
注意用户名要和里面的id_rsa.pub的账户对应
scp -P5647 ~/.ssh/id_rsa.pub git@serverIP:/home/git/tommy.pub

4 安装 gitolite 服务器
切到服务器git账户
su - git
mkdir -p ~/bin
git clone git://github.com/sitaramc/gitolite
gitolite/install -ln /home/git/bin
bin/gitolite setup -pk tommy.pub
(报错,需要安装perl-Time_HiRes: yum install perl-Time-HiRes)

完成安装后 接下来在客户端
如果有端口
$git clone ssh://git@xxx.com:5647/gitolite-admin

编辑conf/gitolite.conf
@admins     = tommy tom
@engineers  = tommy tom
@staff      = @admins @engineers
@guest      = tester git-daemon
配置下user.name和user.email

git config --global user.name
然后提交commit and push这个

对于其他用户,首先是传key
把其他用户的.pub文件放进gitolite-admin/keydir
然后推送就有权限了

github更新fork仓库
1, 先git clone fork的到自己用户的仓库, 注意要用git@git的地址
2, 增加源分支地址到你项目远程分支列表中,先得将原来的仓库指定为upstream,命令为：
   git remote add upstream https://github.com/被fork的仓库.git
   git remote add upstream git@gitxxxx.git
可使用git remote -v查看远程分支列表
3, fetch源分支的新版本到本地
   [master]> git fetch upstream
4, 合并两个版本的代码
   [master]> git merge upstream/master
   如果发生冲突,git mergetool 来启动gui的merge 工具进行合并
5, 将合并后的代码push到github上去
   [master]> git push origin master

如果要发送自己修改的
登录github后,点pull request, new pull request 输入描述
send pull request 就会发送commit


把push命令的全局默认模式设置成：simple/matching
git config --global push.default simple
git branch -a       display all branch

git submodule 把另外一个库加入到项目中.既要保持自己的变更, 也要保持上游库的更新
git submodule add git_repo_add.git alias_name 来添加子模块

当clone代码的时候, 子模块默认不会下载, 只会存在一个路径.需要
git submodule init 来初始化本地配置文件
git sobmodule update 来从上游库拉取所有数据
为了避免子模块的不可逆操作. 可以在子模块路径里面建立一个可回溯的branch
```

64.cat来读取文本赋值
```
touch 1.txt
echo -ne 'aaa\nbbbbbbb\ncccc=3a\n' >> 1.txt 分行输入
name=($(cat 3.txt)) 把3.txt的内容赋给name
echo ${name[1]} 输出name的第二行内容 bbbbbb
echo ${name[2]} | awk -F= '{ print $NF }' 打印出第三行的值 3a
```

65.mysql 优化
```
show variables like 'thread%';
show status like '%connections%';
show status like '%thread%';
```

66.php 优化
```
使用vld.
php -dvld.active=1 代码.php
php -m 查看模块
php --ini 查看配置
php -dvld.verbosity=3 来更详情的查看opcode
php -dvld.execute=0 禁止代码的执行,只看中间输出
php -dvld.save_dir=xxx.file 输出到文件
php -dvld.save_paths=1 -dvld.dump_paths=1 控制是否输出和控制输出的内容
    -dvld.active 是否在执行PHP时激活VLD挂钩,默认为0,表示禁用.可以使用-dvld.active=1启用.
    -dvld.skip_prepend 是否跳过php.ini配置文件中auto_prepend_file指定的文件, 默认为0,即不跳过包含的文件,显示这些包含的文件中的代码所生成的中间代码.此参数生效有一个前提条件：-dvld.execute=0
    -dvld.skip_append 是否跳过php.ini配置文件中auto_append_file指定的文件, 默认为0,即不跳过包含的文件,显示这些包含的文件中的代码所生成的中间代码.此参数生效有一个前提条件：-dvld.execute=0
    -dvld.execute 是否执行这段PHP脚本,默认值为1,表示执行.可以使用-dvld.execute=0,表示只显示中间代码,不执行生成的中间代码.
    -dvld.format 是否以自定义的格式显示,默认为0,表示否.可以使用-dvld.format=1,表示以自己定义的格式显示.这里自定义的格式输出是以-dvld.col_sep指定的参数间隔
    -dvld.col_sep 在-dvld.format参数启用时此函数才会有效,默认为 "\t".
    -dvld.verbosity 是否显示更详细的信息,默认为1,其值可以为0,1,2,3 其实比0小的也可以,只是效果和0一样,比如0.1之类,但是负数除外,负数和效果和3的效果一样 比3大的值也是可以的,只是效果和3一样.
    -dvld.save_dir 指定文件输出的路径,默认路径为/tmp.
    -dvld.save_paths 控制是否输出文件,默认为0,表示不输出文件
    -dvld.dump_paths 控制输出的内容,现在只有0和1两种情况,默认为1,输出内容
```

67.用shell取出一个文本里面的单词,每个单词一行.单词里面有单引号比如it's
```
awk -F" " 'BEGIN{OFS="\n"}{for(i=1;i<=NF;i++) print $i}' test.txt 
提取一行>0的内容 0 1 2 0 0 2 0 2 0 1
awk '{ for (i=0;i<=length;i++){ if ($i !=0 && $i !=""){ print $i }}}' ./test.log
```

68.root无法删除
```
lsattr查看文件状态 返回如果是----ia---------
就执行chattr -ia 文件名 来改变文件属性  + -
chmod只改变文件的读写,执行权限,底层是chattr 参数
A 文件或目录的atime (access time) 不可被修改,可以预防磁盘IO错误的发生.
S 硬盘I/O同步选项,类似sync
a append,设置后只能添加数据,而不能删除,多用于服务器日志文件
c compress 设置文件是否压缩后再存储.读取时需经过自动解压
d no dump 设定文件不能成为dump程序的备份目标
i 设定文件不能被删除,改名,设置链接.同时不能写入或新增内容.
j journal 当通过mount参数：data=ordered
或data=writeback挂载的文件系统,文件在写入时会先被记录(在journal中).如果filesystem被设定参数位data=journal,则该参数自动失效.
s 保密性地删除文件或目录,即磁盘空间被全部收回
u 与s相反,当设置位u时,数据内容还存在磁盘中,多用于undeletion
常用的就是a和i,a强制只能加不能删.
```

69.iptables
```
    -L 查看防火墙
bind IP address
iptables -I INPUT -s 185.130.5.xxx -j DROP

清除所有 iptables rules
iptables -F
iptables -X
iptables -Z
开放指定的端口
    #允许本地回环接口(即运行本机访问本机)
        iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
    # 允许已建立的或相关连的通行
        iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    #允许所有本机向外的访问
        iptables -A OUTPUT -j ACCEPT
    # 允许访问22端口
        iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    #允许访问80端口
        iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    #允许FTP服务的21和20端口
        iptables -A INPUT -p tcp --dport 21 -j ACCEPT
        iptables -A INPUT -p tcp --dport 20 -j ACCEPT
    #禁止其他未允许的规则访问(注意：如果22端口未加入允许规则,SSH链接会直接断开.)
        1).用DROP方法
            iptables -A INPUT -p tcp -j DROP
        2).用REJECT方法
            iptables -A INPUT -j REJECT
            iptables -A FORWARD -j REJECT
        4、屏蔽IP
            #如果只是想屏蔽IP的话"3、开放指定的端口"可以直接跳过.
            #屏蔽单个IP的命令是
                iptables -I INPUT -s 123.45.6.7 -j DROP
            #封整个段即从123.0.0.1到123.255.255.254的命令
                iptables -I INPUT -s 123.0.0.0/8 -j DROP
            #封IP段即从123.45.0.1到123.45.255.254的命令
                iptables -I INPUT -s 124.45.0.0/16 -j DROP
            #封IP段即从123.45.6.1到123.45.6.254的命令是
                iptables -I INPUT -s 123.45.6.0/24 -j DROP
    4、查看已添加的iptables规则
        iptables -L -n
        v：显示详细信息,包括每条规则的匹配包数量和匹配字节数
        x：在 v 的基础上,禁止自动单位换算(K、M) vps侦探
        n：只显示IP地址和端口号,不将ip解析为域名
    5、删除已添加的iptables规则
    将所有iptables以序号标记显示,执行：
        iptables -L -n --line-numbers
    比如要删除INPUT里序号为8的规则,执行：
        iptables -D INPUT 8
    6 保存规则
        CentOS上可以执行：service iptables save保存规则.
        Debian/Ubuntu上iptables是不会保存规则的.
            需要按如下步骤进行,让网卡关闭是保存iptables规则,启动时加载iptables规则.
            如果当前用户不是root,即使使用了sudo,也会提示你没有权限,无法保存,所以执行本命令,你必须使用root用户.
            可以使用sudo -i快速转到root,使用完成,请及时使用su username切换到普通帐户.
            为了重启服务器后,规则自动加载,我们创建如下文件:
            sudo vim /etc/network/if-pre-up.d/iptables#!/bin/bash
            iptables-save > /etc/iptables.rules

            添加执行权限.
            chmod +x /etc/network/if-pre-up.d/iptables
                附上基础规则：
                *filter
                :INPUT ACCEPT [106:85568]
                :FORWARD ACCEPT [0:0]
                :OUTPUT ACCEPT [188:168166]
                :RH-Firewall-1-INPUT - [0:0]
            允许本地回环接口(即运行本机访问本机)
               -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
            允许已建立的或相关连的通行
               -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
            允许所有本机向外的访问
               -A OUTPUT -j ACCEPT
            允许PPTP拨号到外网
               -A INPUT -p tcp -m tcp --dport 1723 -j ACCEPT
            仅特定主机访问Rsync数据同步服务
               -A INPUT -s 8.8.8.8/32 -p tcp -m tcp --dport 873 -j ACCEPT
            仅特定主机访问WDCP管理系统
               -A INPUT -s 6.6.6.6/32 -p tcp -m tcp --dport 8080 -j ACCEPT
            允许访问SSH
               -A INPUT -p tcp -m tcp --dport 1622 -j ACCEPT
            允许访问FTP
               -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
               -A INPUT -p tcp -m tcp --dport 20 -j ACCEPT
            允许访问网站服务
               -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
            禁止所有未经允许的连接
               -A INPUT -p tcp -j DROP
        注意：如果22端口未加入允许规则,SSH链接会直接断开.
        -A INPUT -j REJECT
        -A FORWARD -j REJECT
                COMMIT
                可以使用一下方法直接载入：
                1、复制上面的规则粘贴到这里,保存本文件
                sudo vim /etc/iptables.test.rules
                2、把本规则加载,使之生效,注意,iptables不需要重启,加载一次规则就成了
                sudo iptables-restore < /etc/iptables.test.rules
                3、查看最新的配置,应该所有的设置都生效了.
                sudo iptables -L -n
                4、保存生效的配置,让系统重启的时候自动加载有效配置(iptables提供了保存当前运行的规则功能)
                iptables-save > /etc/iptables.rules
```

70.chkconfig --list 列出系统所有服务
```
chkconfig --list | grep on 列出所有启动的系统服务
add script_name into system initial boot
chkconfig --add script_name
chkconfig --level 345 script_name on
chkconfig --list script_name
```

71.sar 命令
```
    sar [option] [-o filename] [interval [count]]
    -A 显示所有资源设备的运行状况
    -u 显示素有CPU在采样时间内的负载状态
    -P 显示当前系统中指定CPU的使用情况
    -d 显示所有硬盘设备在采样时间内的使用状态
    -r 显示系统内存在采样时间内的使用状态
    -b 显示缓冲区在采样时间内的使用状态
    -v 显示进程,文件,节点和锁表状态
    -n 显示网络运行状态 DEV 网络接口信息
    EDEV 网络错误的统计数据,SOCK 套接字信息 FILL显示前三参数的所有信息
    -q 显示运行队列的大小,与系统的当时的平均负载有关
    -R 显示进程在采样时间内的活动情况
    -y 显示终端设备在采样时间内的活动情况
    -w 显示系统交换活动在采样时间内的状态
    -o filename 表示将命令结果以二进制格式存到文件中.
    interval 采样时间间隔.必须参数
    count 采样次数,默认1.
```

72.top 解释
```
输出位两个部分,统计信心区和进程信息区
统计信息区
当前系统时间,启动后到现在的时间,当前登录数,负载(1,5,15分钟的)
        进程的总数,正在运行的进程数,处于休眠的进程数,停止的进程数,僵尸进程数
        用户进程占CPU百分比us,用户进程空间内改变优先级的进程占CPU百分比ni,空闲CPU百分比id,等待输入输入进程占用CPU百分比wa,
        系统物理内存大小total,已经使用的物理内存大小used,空余内存大小free,用作内核缓冲区的内存大小buffers
        交换分区的内存大小swap,已经使用的交换分区的大小used,空闲的交换分区大小free,高速缓存的大小cached
        进程信息区
        PID 进程PID,USER进程的用户,PR进程优先级,NI nice值负值高表示优先级高,正值表示低优先级.
        VIRT使用的虚拟内存大小KB,VIRT=SWAP+RES
        RES 进程使用的,未被换出的物理内存大小KB,RES=CODE+DATA
        SHR 共享内存大小KB
        S   进程状态 D不可中断的睡眠状态,R运行状态,S睡眠状态,T跟踪/停止,Z僵死进程
        %CPU 上次更新到现在的CPU时间占用百分比
        %MEM 进程占用的物理内存百分比
        TIME+ 进程使用的CPU时间总计,单位1/100秒
        COMMAND 正在运行进程的命令名或路径

按照指定应用输出内存占用
ps -e -o 'pid,comm,args,pcpu,rsz,vsz,stime,user,uid' | grep oracle |  sort -nrk5
```

73.nginx
```
    启动/nginx_env/nginx -c nginx.conf 指定配置文件启动

    停止
        ps -ef | grep nginx 然后kill 或者pkill -9 nginx
    平滑重启
    /nginx_env/nginx -t -c nginx.conf判断新修改的nginx.conf是否正确
    kill -HUP `/nginx.pid`
        nginx支持 term,int 快速关闭,QUIT从容关闭,HUP平滑重启(重新加载配置文件),
        USR1 重新打开日志文件,(切割日志时) . USR2 平滑升级可执行程序
        WINCH 从容关闭工作进程
    
    参数nginx.conf
        user www www;                用户,用户组
        worker_processes 8;            指定工作衍生进程数
        error_log /var/log/nginx/nginx_error.log crit;
                指定错误日志路径,等级debug,info,notice,warn,error,crit
        pid                            指定pid存放的路径
        worker_rlimit_nofile 51200;    指定文件描诉符数量
        events
        {
            use epoll;                使用的网络I/O模型,linux用epoll,freebsd用kqueue
            worker_connections 51200; 允许的连接数
        }

        http
        {
            include mime.types;
            default_type application/octet-stream;
            #charset gb2312;
                设置使用的字符集,如果一个网站有多种字符集,不能乱设,需要在HTML代码中通过Meta标签设置
            server_names_hash_bucket_siee 128;
            client_header_buffer_size 32k;
            large_client_header_buffers 4 32k;
            client_max_body_size 8m;设置客户端能上传的文件大小
            sendfile on;
            tcp_nopush on;
            keepalive_timeout 60;
            tcp_nodelay on;
            fastcgi_connect_timeout 300;
            fastcgi_send_timeout 300;
            fastcgi_read_timeout 300;
            fastcgi_buffer_size 64k;
            fastcgi_buffers 4 64k;
            fastcgi_busy_buffers_size 128k;
            fastcgi_temp_file_write_size 128k;
            gzip on;                开启gzip压缩
            gzip_min_length 1k;
            gzip_buffers 4 16k;
            gzip_http_version 1.1;
            gzip_comp_level 2;
            gzip_types text/plain application/x-javascript text/css application/xml;
            gzip_vary on;
            #limit_zone crawler $binary_remoter_addr 10m;
            //虚拟主机
            server
            {
                listen 80;
                server_name www.youdomain.com yourdomain.com;
                index index.html index.htm index.php;
                root /home/www;
                #limit_conn crawler 20;
                location ~ .*\.(git|jpg|jpeg|png|bmp|swf)$
                {
                    expires 1d;
                }
                location ~ .*\.(js|css)?$
                {
                    expires 1h;
                }
                
                log_format access '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" $http_x_forwarded_for';
                access_log /var/log/nginx/nginx_access.log access;
            }
            第二个虚拟主机 (基于IP)
            server
            {
                listen 192.168.2.2xx:80;        监听IP,端口
                server_name 192.168.2.2xx;        主机名
                access_log /var/log/nginx/server2.access.log combind;
                location /
                {
                    index index.html index.htm; 默认首页文件
                    root /home/www/server1;        html页面存在目录
                }
            }
            第三个虚拟主机 (基于域名)
            server
            {
                listen 80;
                server_name aaa.domain.com;
                access_log /var/log/nginx/aaa.domain.com.access.log combind;
                location /
                {
                    index index.html index.htm; 默认首页文件
                    root /home/www/aaa.domain.com;html页面存在目录
                }
            }
        }
    nginx日志分割用log_format
            log_format name format [format ...]
            log_format combined '$remote_addr - $remoter_user [$time_local] '
                '"$request" $status $body_bytes_sent '
                '"$http_referer" "$http_user_agent"';
    nginx 支持自动列目录
        在location / {
            autoindex on;
            autoindex_exact_size [on|off]; 设定索引文件的大小B,KB,MB,or GB
            autoindex_localtime [on|off];  开启以本地时间来显示文件时间的功能,默认GMT
        }
    nginx的浏览器本地缓存设置
        expires [time|epoch|max|off] 默认是off,作用域 http,server,location.可以控制HTTP的Expires和Cache-Control
            time 正数|负数 epoch 指定位1 GMT时间 max为31, Cache-Control的值为10年.
            -1指当前时间-1s,即永远过期  Cache-Control:no-cache
            正数 Cache-Control:max-age=#, #为指定的秒数
            off 表示不修改Expires 和Cache-Control值
            一般在location里面
                location ~ .*\.(gif|jpg|jpeg|pgn|bmp|swf)$
                {
                    expires 30d;
                }
                location ~ /*\.(js|css)?$
                {
                    expires 1h;
                }


    //debian7 
    #apt-get install nginx php5-cgi
    #vim /etc/php5/cgi/php.ini 取消掉cgi.fix_pathinfo=1的注释
    #apt-get install spawn-fcgi
    系统启动自动加载spawn-fcgi
    #vim /etc/rc.local 增加
    /usr/bin/spawn-fcgi -a 127.0.0.1 -p 9000 -u www-data -g www-data -f /usr/bin/php5-cgi -P /var/run/fastcgi-php.pid -C 4

    netstat -anp | grep 9000 查看9000
    关闭 killall -HUP php5-cgi
    　　-f 指定调用FastCGI的进程的执行程序位置,根据系统上所装的PHP的情况具体设置
    　　-a 绑定到地址addr
    　　-p 绑定到端口port
    　　-s 绑定到unix socket的路径path
    　　-C 指定产生的FastCGI的进程数,默认为5(仅用于PHP)
    　　-P 指定产生的进程的PID文件路径
    　　-u和-g FastCGI使用什么身份(-u 用户 -g 用户组)运行,Ubuntu下可以使用www-data,其他的根据情况配置,如nobody、apache等
    #vim /etc/nginx/sites-avilable/default 添加(要去修改前面的root的路径为/home/www)
        location ~ \.php$ {
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME /home/www$fastcgi_script_name;
            include fastcgi_params;
        }
    /etc/init.d/nginx restart
    netstat -ln | more   9000端口是spawn-fcgi的,80端口是nginx的,需要关掉apache
    
    #php5-fpm
    #apt-get install php5-fpm
    需要停掉spawn-fcgi 占用的9000
    #/etc/init.d/php5-fpm start
    配置文件/etc/nginx/sites-enabled

        location ~ \.php$ {
            fastcgi_pass unix:/var/run/php5-fpm.sock;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME /home/www$fastcgi_script_name;
            include fastcgi_params;
        }
```

74.rsync 
```
rsync -P //同步时显示进度
rsync (remoter synchronize)远程数据同步工具,可以通过ssh华人rsh使用,也可以用daemon模式运行,daemon的时rsync server会打开873端口,然后进行增量备份,windows上有cwRsync和sync2NAS
    rsync [option] src [DEST]
rsync --info=progress2 source dest 显示复制的进度和百分比
```

75.dpkg --get-selections > /home/bak/packagelist.txt
```
    备份包列表
    重新安装包列表的内容
    dpkg --set-selections < /home/bak/packagelist.txt
    apt-get -u dselect-upgrade
```

76.export EDITOR=vim 在.bashrc里面,设置默认编辑器为vim
```
bashrc 原始的存在/etc/skel/.bashrc 
```

77.jumei-extend
```
        beanstalk libevent msgpack readline recode redis sqlite3
        pecl channel-discover php-msgpack.googlecode.com/svn/pecl
        pecl install msgpack/msgpack-beta

        apt-get install php5-geoip
        apt-get install php-apc
        pecl install mongo

        wget https://redis.googlecode.com/files/redis-2.6.14.tar.gz
        tar -zxvf redis
        make
        
        apt-get install libevent-dev
        pecl install channel://pecl.php.net/libevent-0.1.0
        
        pecl install channel://pecl.php.net/proctitle-0.1.2
        pecl install inotify
        上面都需要去ln -s 对应的ini文件,修改添加so所在的路径
        (so 在/usr/lib/php5/20100525/)
        /etc/php5/conf.d/ ln -s ../mods-available/xxx.ini xxx.ini
        然后重启服务器就可以了
```

78.tmux 
```
    apt-get install tmux
    vim ~/.tmux.conf
    tmux source-file .tmux.conf
session 管理
    tmux new -s session-name 创建一个新的session,叫session_name
    tmux attach -t session_name 重新开启叫做session_name的tmux session
    tmux switch -t session_name 转换到叫session_name 的tmux session
    tmux detach (prefix+d)      离开当前开启的session
    tmux ls 列出已有的session(ls就是list-sessions简写),没有session就会报错
                failed to connect to server: Connection refused
    tmux a -t session-name 连接到之前断开的一个session(a是attach-session简写)

window  管理
    tmux new-window(prefix+c)   创建一个新的window
    tmux select-window -t:0-9 (prefix+0-9) 根据索引转到该window
    tmux rename-window(prefix+,) 重命名当前window

panels   管理
    tmux split-window (prefix+") 将window垂直分为两个panel
    tmux split-window -h(prefix+%)将window水平分为两个panel
    tmux swap-pane-[UDLR](prefix+{or}) 在指定的方向交换panel
    tmux select-pane-[UDLR]     在指定的方向选择下一个panel
    tmux select-pane-t:.+       选择按数字顺序的下一个panel

其他有用的命令
    tmux list-keys      列出所有可以的快捷键和其运行tmux命令
    tmux list-commands  列出所有的tmux命令及其参数
    tmux info           列出所有的session,window,panel,运行的进程号
    tmux source-file ~/.tmux.conf   重新加载当前的tmux配置(基于一个默认的tmux配置)


    有一个快捷键(需要配合前缀来使用,默认是C-b)
    系统操作
        ? 列出所有快捷键,q返回
        d 脱离当前会话,这样可以暂时返回shell界面,输入tmux attach后重新进去之前的会话
        D 选择要脱离的会话,在同时开启了多个会话时使用
        Ctrl+z 挂起当前会话
        r 强制重绘未脱离的会话
        s 选择并切换会话,在同时开启了多个会话时使用
        : 进入命令行模式,此时可以输入支持的命令,比如kill-server可以关闭服务器
        [ 进入复制模式,此时的操作与vi/emacs相同,按q/Esc退出、
        ~ 列出提示信息缓存,其中包含了之前tmux返回的各种提示信息
    窗口操作
        c 创建新窗口
        & 关闭当前窗口
        数字键 切换至指定窗口
        n 切换至下一窗口
        p 切换至上一窗口
        l 在前后两个窗口间互相切换
        w 通过窗口列表切换窗口
        t 显示时钟
        ,重命名当前窗口,这样便于识别
        . 修改当前窗口编号,相当于窗口重新排序
        ; 切换到最后一个使用的面板
        f 在所有窗口中查找指定文本
    面板操作
        | 将当前面板平分为上下两块
        - 将当前面板评分为左右两块
        x 关闭当前面板
        & 关闭窗口
        ! 将当前面板置于新窗口,即新建一个窗口,其中仅包含当前面板
        " 横向分割窗口
        % 纵向分割窗口
        Shift+hjkl 以5个单元格为单元移动边缘以调整当前面板大小
        Space
        在预置的面板布局中循环切换,依次包括even-horizontal,even-ertical,main-horizontal,main-vertical,tiled
        q 显示分割面板编号
        o 跳到下一个分割窗口
        { 向前置换当前窗口
        } 向后置换当前窗口
        Alt+o 逆时针旋转当前窗口的面板
        Ctrl+o 顺时针旋转当前窗口的面板

    tmux使用C/S模型,包括了4个单元模块
        server 服务器,输入tmux命令就开启一个服务器
        session 会话,一个服务器可以包含多个会话
        window 窗口,一个会话可以包含多个窗口
        pane 面板,一个窗口可以包含多个面板
```

79 mercurial hg 
```
    安装apt-get install tortoisehg mercurial mercurial-common
    clone a project and push changes
    $ hg clone http://selenic.com/repo/hello
    $ cd hello
    $ (edit files)
    $ hg add (new files)
    $ hg commit -m 'My changes'
    $ hg push

    Create a project and commit
    $ hg init (project-directory)
    $ cd (project-directory)
    $ (add some files)
    $ hg add
    $ hg commit -m 'Initial commit'

    如果报错：abort: error: _ssl.c:504: error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
    #gvim /etc/mercurial/hgrc (debian/ubuntu/gentoo/arch linux)添加
    [web]
    cacerts = /etc/ssl/certs/ca-certificates.crt
    fedora/rhel
    [web]
    cacerts = /etc/pki/tls/certs/ca-bundle.crt
    使用--insecure
    需要添加hostfingerprints 分别在/root/.hgrc 和/home/tom/.hgrc 
    看上去像这样 .hgrc

    [web]
    cacerts=/etc/ssl/certs/ca-certificates.crt
    [paths][auth]
    hg.int.jumei.com.prefix = https://hg.int.jumei.com/
    hg.int.jumei.com.username = yuliangx
    hg.int.jumei.com.password = interface
    [hostfingerprints]
    hg.int.jumei.com = d7:ce:75:52:4e:42:44:fb:bf:c2:40:dc:a8:61:32:3f:e0:ec:3f:4c
    [paths]
    sandbox = ssh://hg@hg.jumeicd.com/sandbox 
    default = ssh://hg@hg.jumeicd.com/kb
    [tortoisehg]
    ui.language = zh_CN
    vdiff = bcompare


    hg manual
    https 的仓库  
    同步代码
    #hg pull https://xxxx --insecure
    #hg addremove  add all new files,delete all missing files
    #hg annotate,blame    show changeset information by line for each file
    #hg archive  create an unversioned archive of a repository revision
    为一个仓库版本创建一个不含版本信息的存档
    #hg backout 退回早期的changeset
    #hg bisect  subdivision search of changesets
    #hg bookmarks    track a line of development with movable markers
    #hg branch  set or show the current branch name
    #hg branches   list repository named branches
    #hg bundle  create a changegroup file
    #hg cat  output the current or given revision of files
    #hg clone   make a copy of an existing repository
    #hg commit,ci  commit the specified files or all outstanding changes
    #hg copy,cp mark files as copied for the next commit
    #hg diff    diff repository(or selected files)
    #hg export dump the header and diffs on the next commit
    #hg forget  forget the specified files on the next commit
    #hg graft   copy changes from other branches onto the current branch
    #hg grep    search for a pattern in specified files and revisions
    #hg heads   show current repository heads or show branch heads
    #hg help
    #hg identify,id     identify the working copy or specified revision
    #hg import,patch    import an ordered set of patches
    #hg incoming,in     show new changesets found in source
    #hg init            create a new repository in the given directory
    #hg locate          locate files matching specific patterns
    #hg log,history     show revision history of entire repository of files
    #hg manifest        output the current of given revision of the project manifest
    #hg outgoing,out    show changesets not found in the destination
    #hg parents         show the parents of the working directory or revision
    #hg paths           show aliases for remote repositories
    #hg phase           set or show the current phase name
    #hg pull            pull changes from the specified source
    #hg push            push changes to the specified destination
    #hg recover         roll back an interrupted transaction
    #hg remove,rm       remove the specified files on the next
commit(提交前删除库中指定文件)
    #hg rename,move,mv  重命名,等于复制后删除
    #hg resolve         redo merges or set/view the merge status of
        files重做合并,或设置/查看文件的合并状态 
    #hg revert          撤销最近的一次操作
    #hg rollback        撤销自上一次push后的所有操作
    #hg root            显示当前库的跟目录
    #hg serve           start stand-alone webserver 以http协议发布库
    #hg showconfig,debugconfig
                        show combined config settings from all hgrc files
    #hg status,st       show changed files in the working directory 显示指定文件夹的变更情况
    #hg summary,sum     summarize working directory state 查看当前工作目录的概述
    #hg tag             给当前或指定版本添加一个/多个标记
    #hg tags            显示仓库的所有标记
    #hg tip             显示最新的版本信息 =hg log -r tip or hg log -r -1
    #hg unbundle        apply one or more changegroup files
    #hg update,cp,checkout,co 更新至工作目录的最新状态
    #hg verify          verify the integrity of the repository
    #hg version         output version and copyright information
    #hg extdiff         command to allow external programs to compare revisions

    hg strip 版本 清除掉某次的提交前修改
    hg branch branch-1 创建分支
    hg commit -m 'xxxx' 提交分支
    hg up branch-1 切换到分支上
    如果需要fork的代码同步更新default, 需要在hgrc 文件里面指定master = https://xxxx
    然后hg pull master更新,最后hg update/up 更新工作目录
    hg pull -u 可以获取代码库的修改的同时更新工作目录
    hg outgoing 查看本地代码库做了那些修改
    hg push 发布代码库的修改
    hg tip -vp 查看刚才的提交
    hg revert 撤销提交
    //多人修改一个文件
    hg update -C 进行强制更新
    hg heads 查看heads
    hg merge 合并两个head的代码
    hg parents 查看父级的情况

    创建合并hg分支
    hg branches 查看所有分支
    hg branch 查看当前分支
    hg branch xxx 创建新分支
    hg commit -m ''
    hg branches 查看是否建立成功 hg branch 查看当前是否已经处于新分支
    hg update default 切换回默认分支
    hg update xxx 切换到XXX分支
    hg merge XXX 合并分支
    hg status 查看文件状态,是否有变更
    hg purge 删除未曾控制的文件
    hg fetch 更新代码
    hg commit --close-branch -m "close" 关闭 分支
    hg revert --all --rev 版本  回滚版本


    hg status M已经被修改  ! 丢失 ? 未知,未被hg管理
    hg remove 把文件放进出库等候队列中,在commit前是不会从版本库中移除的
    hg cat 显示任何文件的任何版本 -r 版本号 
    hg incoming 列出等待pull的变更列表
    hg outgoing 列出当前版本库等待推送的变更列表,即列出提交的draft状态的变更列表
    hg push 把一个版本库的新增变更推送到另一个版本库(需要有ssl) 可以把提交后的更改变更到中央版本库(即把draft状态改为public)
    
    hg revert 将变更的文i恢复到最近依次提交后的状态
    hg revert 具体文件,恢复到上次提交的状态
    hg revert --all 恢复当前目录的操作到上次提交的状态
    hg revert --all --rev 版本  回滚 
    hg revert 文件 --rev 版本号 回滚单个文件到指定版本号.
    hg rollback 撤销最后一次提交,前提是还没有push(即删除掉draft状态)
    hg paths 显示远程版本库列表
    hg parent 显示正基于哪几个变更集进行开发
    hg backout 拆除早些时候的变更集

    修改后的需要提交M
    新拉取的主,需要创建分支,然后人马上提交

    hg pull master 拉取主
    hg push 推送到fork的default
    hg push --new-branch 把其它人的修改创建到新分支上
    hg pull master  再拉master
    hg push
    hg up 分支号 切换到分支号
    hg branch 查看
    hg merge default 把default的更新合并到分支上
    hg commit -m 'merge default' 提交合并
    hg push     推送到fork

    查看文件状态 hg st
    查看自己分支 hg branch
    hg pull master
    hg merge linj_bufa 拉取合并别人分支
    hg diff 查看差异,确认
    hg commit -m '提交差异'
    hg push 推

    拉取staff分支
    加到.hg/hgrc 命名
    hg pull xxx -b 分支号
    hg merge 

    合并自己多个ticket的
    先hg up default上,切换到default分支
    然后hg branch yuliangx_merge_all 新建一个
    然后hg commit -m 'merge all'
    然后hg merge yuliangx_20131126_26144 之类的,并且meld后合并到最左,以本地代码为主发布
    然后hg commit -m 'merge 26144' 重复
    
    新的需要先up default, pull master 然后再去branch 新分支

    在自己的分支上提交的时候和别人的起冲突了
    hg branch 自己的
    hg pull hubo -b optool_2.6.0
    hg merge optool_2.6.0
    hg commit -m 'xxx'
    hg push --new-branch
    如果出现自己的repo和服务器的不一直,有多头,就hg push -f --new-branch来强制更新服务器上的文件

    hg关闭分支,先切到A分支,然后提交
    hg update A,
    hg commit --close-branch -m"close".

    如果需要在自己的分支上合并其他分支来测试.不能提交
    做如下操作
    1: hg up 自己分支
    2: hg pull default/master 拉取default内容
    3: hg merge default
    4: hg merge 别人分支
    5: 做完修改后, 需要保存修改的代码到其它地方. 然后对本项目进行strip
    hg strip 一个版本号一个版本号的回滚
    6: 直到修改到上一个修改的版本
    7: 修改后了按照正常流程.
```

80.yaf
```
    #apt-get install libpcre3-dev
    #tar zxvf yaf-2.2.9.tgz
    #cd yaf-2.2.9
    #phpize5 ./configure --with-php-config=/usr/bin/php-config
    #./configure
    #make && make install
    #cd /etc/php5/mods-available
    #vim yaf.ini
    extension=yaf.so
    #cd /etc/php5/conf.d
    #ln -s ../mods-available/yaf.ini ./yaf.ini
    重启server
```

81.phpunit
```
    pear channel-discover pear.phpunit.de
    pear channel-discover components.ez.no
    pear channel-discover pear.symfony-project.com
    pear install phpunit/PHPUnit
    pear install --alldeps --force pear.phpunit.de/PHPUnit
    
    PHPUnit_Framework_Testcase class
    phpunit --verbose XXX
```

82.mysqldump 转码
```
    Mysql 字符集的修改步骤 
    如果在应用开始阶段没有正确的设置字符集,在运行一段时间以后才发现　存在不能满足要求需要调整,又不想丢弃这段时间的数据,那么就需要进行字符集的修改.　字符集的修改不能直接通过　
    alter dataabase character set *** 或者　alter table tablename character set ***; 命令进行,这两个命令都没有更新已有记录的字符集,　而只是对新创建的表或者记录生效.
    已有的记录的字符集调整,需要先将数据导出,经过适当的调整重新导入后才可完成.
    以下模拟的是将latin1字符集的数据库修改成GBK字符集的数据库的过程.
    1> 导出表结构：
    mysqldump -uroot -p --default-character-set=gbk -d databasename > createtab.sql
    其中　--default-character-set=gbk 表示设置以什么字符集连接,　-d 表示只导出表结构,不导出数据.
    2>手工修改　createtab.sql 中表结构定义中的字符集为新的字符集.
    3>确保记录不再更新,导出所有记录.
    mysqldump -uroot -p --quick --no-create-info --extended-insert --default-character-set=latin1 databasename > data.sql
    --quick: 该选项用于转储大的表.　它强制　mysqldump 从服务器一次一行地检索表中的行而不是　检索所有行,并在输出前将它缓存到内存中.
    --extended-insert: 使用包括几个　values 列表的多行insert语法,这样使转储文件更小,重载文件时可以加速插入.
    --no-create-info: 不写重新创建每个转储表的create table 语句.
    --default-character-set=latin1: 按照原有的字符集导出所有数据,这样导出的文件中,所有中文都是可见的,不会保存成乱码.
    4>打开data.sql,将　set names latin1 修改成　set names gbk .
    5>使用新的字符集创建新的数据库.
    create database databasename default charset gbk;
    6>创建表,执行　createtab.sql
    mysql -uroot -p databasename < createtab.sql
    7>导入数据,执行data.sql
    mysql -uroot -p databasename < data.sql

    在导入大的csv sql文件时,可以用load data 命令
        use db；
        创建好表,执行
        load data infile '/home/tom/Desktop/tmall_1111/运动鞋服.csv'  into table `product` fields terminated by ',' (band_name,p_name,now_price,mall_price,low_price,1111_price,links,click); 
    mysql -h xxx -u xxx -p -Pxxx --prompt="\\u@\\d \\R:\\m:\\s>"
```

83.date
```
    date -d datestr 显示datestr中所特定的时间
    date -s datestr 把系统时间设为datestr中所设定的时间
    date -u  GMT+00时间
    date +%T%n%D
    mkdir `date+%Y%m%d` 创建当前时间为文件名的
    tar zcvf ./filename`date+%Y%m%d`.tar.gz filepath
    date -d "-1 week" "+%Y%m%d %A" 显示上一周日期
    date +%s 获取UNIX时间戳
    date -d "2013-11-13 17:05:59" +%s 输出时间戳@1384335779
    date -d @1384335779 "+%Y-%m-%d %H:%M:%S" 输出时间格式2013-11-13 17:05:59
    date +%F\ %T 输出当前格式化的时间.
    tar -zcvf 1_`date +%Y%m%d%H%M%S`.tar.gz ./1.php
```

84.ANSI控制码
```
    man console_codes
    echo -ne "\33[32m" 可以将字符的显示颜色改为绿色
    echo -ne "\33[3;1H" 可以将光标移到第3行第1列处
    具体的摘抄一些如下：
    \33[0m 关闭所有属性
    \33[1m 设置高亮度
    \33[4m 下划线
    \33[5m 闪烁
    \33[7m 反显
    \33[8m 消隐
    \33[30m -- \33[37m 设置前景色
    \33[40m -- \33[47m 设置背景色
    \33[nA 光标上移n行
    \33[nB 光标下移n行
    \33[nC 光标右移n行
    \33[nD 光标左移n行
    \33[y;xH设置光标位置
    \33[2J 清屏
    \33[K 清除从光标到行尾的内容
    \33[s 保存光标位置
    \33[u 恢复光标位置
    \33[?25l 隐藏光标
    \33[?25h 显示光标
```

85.在bash中检查远程端口是否打开:
```
echo >/dev/tcp/8.8.8.8/53 && echo "open"
生成随机16进制数字,n是字符的数量:
openssl rand -hex n
提取字符串的前5个字符:
${variable:0:5}
```

86.tcpdump
```
tcpdump -Ans 40960 -iany port 2201
tcpdump -i eth1 监视指定网络接口的数据包 不指定会默认第一个,一般eth0 
tcpdump host sundown 监视指定主机的数据包 也可以是IP
    -A  以ASCII码方式显示每一个数据包(不会显示数据包中链路层头部信息). 在抓取包含网页数据的数据包时, 可方便查看数据(nt: 即Handy for capturing web pages).
    -c  count
        tcpdump将在接受到count个数据包后退出.
    -C  file-size (nt: 此选项用于配合-w file 选项使用)
        该选项使得tcpdump 在把原始数据包直接保存到文件中之前, 检查此文件大小是否超过file-size. 如果超过了, 将关闭此文件,另创一个文件继续用于原始数据包的记录. 新创建的文件名与-w 选项指定的文件名一致, 但文件名后多了一个数字.该数字会从1开始随着新创建文件的增多而增加. file-size的单位是百万字节(nt: 这里指1,000,000个字节,并非1,048,576个字节, 后者是以1024字节为1k, 1024k字节为1M计算所得, 即1M=1024 ＊ 1024 ＝ 1,048,576)
    -d  以容易阅读的形式,在标准输出上打印出编排过的包匹配码, 随后tcpdump停止.(nt | rt: human readable, 容易阅读的,通常是指以ascii码来打印一些信息. compiled, 编排过的. packet-matching code, 包匹配码,含义未知, 需补充)
    -dd 以C语言的形式打印出包匹配码.
    -ddd 以十进制数的形式打印出包匹配码(会在包匹配码之前有一个附加的'count'前缀).
    -D  打印系统中所有tcpdump可以在其上进行抓包的网络接口. 每一个接口会打印出数字编号, 相应的接口名字, 以及可能的一个网络接口描述. 其中网络接口名字和数字编号可以用在tcpdump 的-i flag 选项(nt: 把名字或数字代替flag), 来指定要在其上抓包的网络接口.
        此选项在不支持接口列表命令的系统上很有用(nt: 比如, Windows 系统, 或缺乏 ifconfig -a 的UNIX系统); 接口的数字编号在windows 2000 或其后的系统中很有用, 因为这些系统上的接口名字比较复杂, 而不易使用.
        如果tcpdump编译时所依赖的libpcap库太老,-D 选项不会被支持, 因为其中缺乏 pcap_findalldevs()函数.
    -e  每行的打印输出中将包括数据包的数据链路层头部信息
    -E  spi@ipaddr algo:secret,...
        可通过spi@ipaddr algo:secret 来解密IPsec ESP包(nt | rt:IPsec Encapsulating Security Payload,IPsec 封装安全负载, IPsec可理解为, 一整套对ip数据包的加密协议, ESP 为整个IP 数据包或其中上层协议部分被加密后的数据,前者的工作模式称为隧道模式; 后者的工作模式称为传输模式 . 工作原理, 另需补充).
        需要注意的是, 在终端启动tcpdump 时, 可以为IPv4 ESP packets 设置密钥(secret).
        可用于加密的算法包括des-cbc, 3des-cbc, blowfish-cbc, rc3-cbc, cast128-cbc, 或者没有(none).默认的是des-cbc(nt: des, Data Encryption Standard, 数据加密标准, 加密算法未知, 另需补充).secret 为用于ESP 的密钥, 使用ASCII 字符串方式表达. 如果以 0x 开头, 该密钥将以16进制方式读入.
        该选项中ESP 的定义遵循RFC2406, 而不是 RFC1827. 并且, 此选项只是用来调试的, 不推荐以真实密钥(secret)来使用该选项, 因为这样不安全: 在命令行中输入的secret 可以被其他人通过ps 等命令查看到.
        除了以上的语法格式(nt: 指spi@ipaddr algo:secret), 还可以在后面添加一个语法输入文件名字供tcpdump 使用(nt：即把spi@ipaddr algo:secret,... 中...换成一个语法文件名). 此文件在接受到第一个ESP　包时会打开此文件, 所以最好此时把赋予tcpdump 的一些特权取消(nt: 可理解为, 这样防范之后, 当该文件为恶意编写时,不至于造成过大损害).
    -f  显示外部的IPv4 地址时(nt: foreign IPv4 addresses, 可理解为, 非本机ip地址), 采用数字方式而不是名字.(此选项是用来对付Sun公司的NIS服务器的缺陷(nt: NIS, 网络信息服务, tcpdump 显示外部地址的名字时会用到她提供的名称服务): 此NIS服务器在查询非本地地址名字时,常常会陷入无尽的查询循环).
        由于对外部(foreign)IPv4地址的测试需要用到本地网络接口(nt: tcpdump 抓包时用到的接口)及其IPv4 地址和网络掩码. 如果此地址或网络掩码不可用, 或者此接口根本就没有设置相应网络地址和网络掩码(nt: linux 下的 'any' 网络接口就不需要设置地址和掩码, 不过此'any'接口可以收到系统中所有接口的数据包), 该选项不能正常工作.
    -F  file
        使用file 文件作为过滤条件表达式的输入, 此时命令行上的输入将被忽略.
    -i  interface
        指定tcpdump 需要监听的接口.  如果没有指定, tcpdump 会从系统接口列表中搜寻编号最小的已配置好的接口(不包括 loopback 接口).一但找到第一个符合条件的接口, 搜寻马上结束.
        在采用2.2版本或之后版本内核的Linux 操作系统上, 'any' 这个虚拟网络接口可被用来接收所有网络接口上的数据包(nt: 这会包括目的是该网络接口的, 也包括目的不是该网络接口的). 需要注意的是如果真实网络接口不能工作在'混杂'模式(promiscuous)下,则无法在'any'这个虚拟的网络接口上抓取其数据包.
        如果 -D 标志被指定, tcpdump会打印系统中的接口编号,而该编号就可用于此处的interface 参数.
    -l  对标准输出进行行缓冲(nt: 使标准输出设备遇到一个换行符就马上把这行的内容打印出来).在需要同时观察抓包打印以及保存抓包记录的时候很有用. 比如, 可通过以下命令组合来达到此目的:
        ``tcpdump  -l  |  tee dat'' 或者 ``tcpdump  -l   > dat  &  tail  -f  dat''.(nt: 前者使用tee来把tcpdump 的输出同时放到文件dat和标准输出中, 而后者通过重定向操作'>', 把tcpdump的输出放到dat 文件中, 同时通过tail把dat文件中的内容放到标准输出中)
    -L  列出指定网络接口所支持的数据链路层的类型后退出.(nt: 指定接口通过-i 来指定)
    -m  module
        通过module 指定的file 装载SMI MIB 模块(nt: SMI,Structure of Management Information, 管理信息结构MIB, Management Information Base, 管理信息库. 可理解为, 这两者用于SNMP(Simple Network Management Protoco)协议数据包的抓取. 具体SNMP 的工作原理未知, 另需补充).
        此选项可多次使用, 从而为tcpdump 装载不同的MIB 模块.
    -M  secret  如果TCP 数据包(TCP segments)有TCP-MD5选项(在RFC 2385有相关描述), 则为其摘要的验证指定一个公共的密钥secret.
    -n  不对地址(比如, 主机地址, 端口号)进行数字表示到名字表示的转换.
    -N  不打印出host 的域名部分. 比如, 如果设置了此选现, tcpdump 将会打印'nic' 而不是 'nic.ddn.mil'.
    -O  不启用进行包匹配时所用的优化代码. 当怀疑某些bug是由优化代码引起的, 此选项将很有用.
    -p  一般情况下, 把网络接口设置为非'混杂'模式. 但必须注意 , 在特殊情况下此网络接口还是会以'混杂'模式来工作； 从而, '-p' 的设与不设, 不能当做以下选现的代名词:'ether host {local-hw-add}' 或  'ether broadcast'(nt: 前者表示只匹配以太网地址为host 的包, 后者表示匹配以太网地址为广播地址的数据包).
    -q  快速(也许用'安静'更好?)打印输出. 即打印很少的协议相关信息, 从而输出行都比较简短.
    -R  设定tcpdump 对 ESP/AH 数据包的解析按照 RFC1825而不是RFC1829(nt: AH, 认证头, ESP, 安全负载封装, 这两者会用在IP包的安全传输机制中). 如果此选项被设置, tcpdump 将不会打印出'禁止中继'域(nt: relay prevention field). 另外,由于ESP/AH规范中没有规定ESP/AH数据包必须拥有协议版本号域,所以tcpdump不能从收到的ESP/AH数据包中推导出协议版本号.
    -r  file
        从文件file 中读取包数据. 如果file 字段为 '-' 符号, 则tcpdump 会从标准输入中读取包数据.
    -S  打印TCP 数据包的顺序号时, 使用绝对的顺序号, 而不是相对的顺序号.(nt: 相对顺序号可理解为, 相对第一个TCP 包顺序号的差距,比如, 接受方收到第一个数据包的绝对顺序号为232323, 对于后来接收到的第2个,第3个数据包, tcpdump会打印其序列号为1, 2分别表示与第一个数据包的差距为1 和 2. 而如果此时-S 选项被设置, 对于后来接收到的第2个, 第3个数据包会打印出其绝对顺序号:232324, 232325).
    -s  snaplen
        设置tcpdump的数据包抓取长度为snaplen, 如果不设置默认将会是68字节(而支持网络接口分接头(nt: NIT, 上文已有描述,可搜索'网络接口分接头'关键字找到那里)的SunOS系列操作系统中默认的也是最小值是96).68字节对于IP, ICMP(nt: Internet Control Message Protocol,因特网控制报文协议), TCP 以及 UDP 协议的报文已足够, 但对于名称服务(nt: 可理解为dns, nis等服务), NFS服务相关的数据包会产生包截短. 如果产生包截短这种情况, tcpdump的相应打印输出行中会出现''[|proto]''的标志(proto 实际会显示为被截短的数据包的相关协议层次). 需要注意的是, 采用长的抓取长度(nt: snaplen比较大), 会增加包的处理时间, 并且会减少tcpdump 可缓存的数据包的数量, 从而会导致数据包的丢失. 所以, 在能抓取我们想要的包的前提下, 抓取长度越小越好.把snaplen 设置为0 意味着让tcpdump自动选择合适的长度来抓取数据包.
    -T  type
        强制tcpdump按type指定的协议所描述的包结构来分析收到的数据包.  目前已知的type 可取的协议为:
        aodv (Ad-hoc On-demand Distance Vector protocol, 按需距离向量路由协议, 在Ad hoc(点对点模式)网络中使用),
        cnfp (Cisco  NetFlow  protocol),  rpc(Remote Procedure Call), rtp (Real-Time Applications protocol),
        rtcp (Real-Time Applications con-trol protocol), snmp (Simple Network Management Protocol),
        tftp (Trivial File Transfer Protocol, 碎文件协议), vat (Visual Audio Tool, 可用于在internet 上进行电
        视电话会议的应用层协议), 以及wb (distributed White Board, 可用于网络会议的应用层协议).
    -t     在每行输出中不打印时间戳
    -tt    不对每行输出的时间进行格式处理(nt: 这种格式一眼可能看不出其含义, 如时间戳打印成1261798315)
    -ttt   tcpdump 输出时, 每两行打印之间会延迟一个段时间(以毫秒为单位)
    -tttt  在每行打印的时间戳之前添加日期的打印
    -u     打印出未加密的NFS 句柄(nt: handle可理解为NFS 中使用的文件句柄, 这将包括文件夹和文件夹中的文件)
    -U    使得当tcpdump在使用-w 选项时, 其文件写入与包的保存同步.(nt: 即, 当每个数据包被保存时, 它将及时被写入文件中,而不是等文件的输出缓冲已满时才真正写入此文件)
          -U 标志在老版本的libcap库(nt: tcpdump 所依赖的报文捕获库)上不起作用, 因为其中缺乏pcap_cump_flush()函数.
    -v    当分析和打印的时候, 产生详细的输出. 比如, 包的生存时间, 标识, 总长度以及IP包的一些选项. 这也会打开一些附加的包完整性检测, 比如对IP或ICMP包头部的校验和.
    -vv   产生比-v更详细的输出. 比如, NFS回应包中的附加域将会被打印, SMB数据包也会被完全解码.
    -vvv  产生比-vv更详细的输出. 比如, telent 时所使用的SB, SE 选项将会被打印, 如果telnet同时使用的是图形界面,
          其相应的图形选项将会以16进制的方式打印出来(nt: telnet 的SB,SE选项含义未知, 另需补充).
    -w    把包数据直接写入文件而不进行分析和打印输出. 这些包数据可在随后通过-r 选项来重新读入并进行分析和打印.
    -W    filecount
          此选项与-C 选项配合使用, 这将限制可打开的文件数目, 并且当文件数据超过这里设置的限制时, 依次循环替代之前的文件, 这相当于一个拥有filecount 个文件的文件缓冲池. 同时, 该选项会使得每个文件名的开头会出现足够多并用来占位的0, 这可以方便这些文件被正确的排序.
    -x    当分析和打印时, tcpdump 会打印每个包的头部数据, 同时会以16进制打印出每个包的数据(但不包括连接层的头部).总共打印的数据大小不会超过整个数据包的大小与snaplen 中的最小值. 必须要注意的是, 如果高层协议数据没有snaplen 这么长,并且数据链路层(比如, Ethernet层)有填充数据, 则这些填充数据也会被打印.(nt: so for link  layers  that pad, 未能衔接理解和翻译, 需补充 )
    -xx   tcpdump 会打印每个包的头部数据, 同时会以16进制打印出每个包的数据, 其中包括数据链路层的头部.
    -X    当分析和打印时, tcpdump 会打印每个包的头部数据, 同时会以16进制和ASCII码形式打印出每个包的数据(但不包括连接层的头部).这对于分析一些新协议的数据包很方便.
    -XX   当分析和打印时, tcpdump 会打印每个包的头部数据, 同时会以16进制和ASCII码形式打印出每个包的数据, 其中包括数据链路层的头部.这对于分析一些新协议的数据包很方便.
    -y    datalinktype
          设置tcpdump 只捕获数据链路层协议类型是datalinktype的数据包
    -Z    user
          使tcpdump 放弃自己的超级权限(如果以root用户启动tcpdump, tcpdump将会有超级用户权限), 并把当前tcpdump的用户ID设置为user, 组ID设置为user首要所属组的ID(nt: tcpdump 此处可理解为tcpdump 运行之后对应的进程)
          此选项也可在编译的时候被设置为默认打开.(nt: 此时user 的取值未知, 需补充)
```

87.系统启动控制服务
```
    第一个是invoke-rc.d
        这个命令可以停止或启动服务,比如：
        invoke-rc.d exim4 stop
        invoke-rc.d nfs-common start
    第二个是update-rc.d
        这个命令可以启用或禁止服务自启动
        update-rc.d –f exim4 remove
        update-rc.d nfs-common start 20 3 4 5
```

88.在命令行直接ctrl-x-e 可以快速打开系统默认编辑器.
```
ss "ss"表示socket统计.这个命令调查socket,显示类似netstat命令的信息.它可以比其他工具显示更多的TCP和状态信息.
```

89.终端改256
```
    终端里面, 默认是8色的, 可以通过tput colors来查看到底是几色的, 没有做修改就是8色
    $/# tput colors
    8
    然后查看下终端类型
    $/# echo $TERM
    xterm
    通过以下两种方式修改 
    1. 修改.bashrc文件
    ~/.bashrc文件添加
    if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
    fi

    2.修改.Xresourcesw文件

    ~/.Xresources文件添加
    xterm*termName: xterm-256color

    编辑编辑vimrc文件,添加
    set t_Co=256 让vim来支持
    可以参考
    http://vim.wikia.com/wiki/256_colors_setup_for_console_Vim
    http://push.cx/2008/256-color-xterms-in-ubuntu
```

90.修改登录界面
```
    /boot/grub/grub.cfg 
    /usr/share/images/desktop-base/ 
    /usr/share/desktop-base/grub_background.sh 
```

91.virtualbox 
```
    vboxmanage list vms 查看有哪些虚拟机
    启动
    vboxmanage starvm XP --type gui
    vboxmanage list runningvms 列出运行的虚拟机
    vboxmanage controlvm XP acpipowerbutton 关闭虚拟机,正常关机
    vboxmanage controlvm XP poweroff, 直接关电源关机,非正常关机
    vboxmanage controlvm XP pause 暂停
    vboxmanage controlvm XP resume 恢复
    vboxmanage controlvm XP savestate 保存当前虚拟机的运行状态

    共享文件夹\\Vboxsvr->\\vboxsvr\tmp,选择\\vboxsvr\tmp
```

92.shell 计算
```
    echo `expr 1+2` 可以来计算出表达式. 也可以用let 来赋值 let b=1+2然后echo $b
    ** 冥计算 

    文件重定向
    标准输入standard input的文件描述符是0
    标准输出standard output是1
    标准错误standard error是2
    command > filename      把标准输出重定向到一个文件中
    command >> filename     把标准输出以追加的方式重定向到一个文件中
    command 1 > filename    把标准输出重定向到一个文件中
    command > filename 2>&1 把标准输出和标准错误一起重定向到一个文件中
    command 2 > filename    把标准输出的错误重定向到一个文件中
    command 2 >> filename   把标注输出的错误追加重定向到一个文件中
    command >> filename 2>&1把标准输出和标准错误以追加的方式到一个文件中
    command < filename > filename2 把command命令以filename文件作为标准输入,以filename2文件作为标准输出
    command < filename      把command命令以filename文件作为标准输入.
    read A < a.txt 会把a.txt的内容读取一个字符串赋值给A
    grep "standard"* > grep.out 2>&1 就是将标准输出与错误输出一并送入grep.out文件中,写文件方式为覆盖写(>).
    cat >>filetest 2>&1 <<MAYDAY 就是从MAYDAY中读取文件内容,将标准输出与错误输出一并送入filetest文件中,写文件方式为附加写(>>).

    tr "[a-z]" "[A-Z]" < a.txt > b.txt 这会从把a.txt的小写全部转换成大写保存到b.txt

    test 文件状态测试
    0 表示测试成功 1表示测试失败

    -d 测试文件是否是目录 -s是否非空  -f 是否是正规文件 -w是否可写 -L是否是符号链接 -u 是否有suid位设置 -x是否可执行 -r 是否可读
    test -d /windows 
    echo $?  这里$? 用于保存上一个操作的结果.

    数值比较. 
    test 第一个操作数 数值比较符 第二个操作数  或者用[ ] 来代替test
    [ 第一个操作数 数值比较符 第二个操作数 ] 注意中括号内部有空格
    -eq 两个数是否相等 -le 第一个是否不大于第二个 -ne 是否不相等 -ge 是否不小于第二个数 -gt 是否大于第二个数 -lt 第一个数是否小于第二个数

    字符串比较 =是否相等 !=是否不相等 -z是否是空字符串 -n 是否是空字符串

    逻辑测试 
        -a 逻辑与 两边都为真才为真
        -o 逻辑或 有一个为真就为真
        !逻辑否,条件为假时才返回真

    流程控制
        if 条件
            then 命令1 
            else 命令2
        fi 
        if 条件1 
            then 命令1
        elif 条件2
            then 命令2
        else 命令3
        fi
        或写成
        if 条件1;then 命令1 
        elif 条件2;then 命令2
        else 命令3
        fi
        循环
        for 变量名 in 列表
            do
            命令1
            命令2
        dVone
         until 语句,执行一个循环体,直到条件为真时停止
            until 条件
            do
            命令1
            ...
            done
    内置变量
        变量    说明
         $0      脚本名称
         $n      传给脚本/函数的第n个参数
         $$      脚本的PID
         $!      上一个被执行的命令的PID(后台运行的进程)
         $?      上一个命令的退出状态(管道命令使用${PIPESTATUS})
         $#      传递给脚本/函数的参数个数
         $@      传递给脚本/函数的所有参数(识别每个参数)
         $*      传递给脚本/函数的所有参数(把所有参数当成一个字符串
    用[[]](双层中括号)替代[]

    使用[[]]能避免像异常的文件扩展名之类的问题,而且能带来很多语法上的改进,而且还增加了很多新功能：

    操作符  功能说明
        ||      逻辑or(仅双中括号里使用)
        &&      逻辑and(仅双中括号里使用)
        <       字符串比较(双中括号里不需要转移)
        -lt     数字比较
        =       字符串相等
        ==      以Globbing方式进行字符串比较(仅双中括号里使用,参考下文)
        =~      用正则表达式进行字符串比较(仅双中括号里使用,参考下文)
        -n      非空字符串
        -z      空字符串
        -eq     数字相等
        -ne     数字不等
    在bash中加入后面两段, 可以引用未定义的变量, 执行失败的命令被忽略.(有些命令的参数可以强制忽略发生的错误,比如mkdir -p, rm -f)
     #!/bin/bash
        set -o nounset
        set -o errexit
    Bash里可以对变量进行有限的注解.最重要的两个注解是：
        local(函数内部变量)
        readonly(只读变量)
    用$()代替反单引号(`)
        反单引号很难看,在有些字体里跟正单引号很相似.$()能够内嵌使用,而且避免了转义符的麻烦.
            # both commands below print out: A-B-C-D
            echo "A-`echo B-`echo C-\\`echo D\\```"
            echo "A-$(echo B-$(echo C-$(echo D)))"

            t="abc123"
            [[ "$t" == abc* ]]         # true (globbing比较)
            [[ "$t" == "abc*" ]]       # false (字面比较)
            [[ "$t" =~ [abc]+[123]+ ]] # true (正则表达式比较)
            [[ "$t" =~ "abc*" ]]       # false (字面比较)

            r="a b+"
            [[ "a bbb" =~ $r ]]        # true

            case $t in
            abc*)  &lt;action&gt; ;;
            esac
        字符串操作
            f="path1/path2/file.ext"  
            len="${#f}" # = 20 (字符串长度) 
            # 切片操作: ${&lt;var&gt;:&lt;start&gt;} or ${&lt;var&gt;:&lt;start&gt;:&lt;length&gt;}
            slice1="${f:6}" # = "path2/file.ext"
            slice2="${f:6:5}" # = "path2"
            slice3="${f: -8}" # = "file.ext"(注意："-"前有空格)
            pos=6
            len=5
            slice4="${f:${pos}:${len}}" # = "path2"
        替换操作(使用globbing)
            f="path1/path2/file.ext"  
            single_subst="${f/path?/x}"   # = "x/path2/file.ext"
            global_subst="${f//path?/x}"  # = "x/x/file.ext" 
            # 字符串拆分
            readonly DIR_SEP="/"
            array=(${f//${DIR_SEP}/ })
            second_dir="${arrray[1]}"     # = path2
        删除头部或尾部(使用globbing)
            f="path1/path2/file.ext" 
            # 删除字符串头部
            extension="${f#*.}"  # = "ext" 
            # 以贪婪匹配方式删除字符串头部
            filename="${f##*/}"  # = "file.ext" 
            # 删除字符串尾部
            dirname="${f%/*}"    # = "path1/path2" 
            # 以贪婪匹配方式删除字符串尾部
            root="${f%%/*}"      # = "path1"
        避免使用临时文件
            有些命令需要以文件名为参数,这样一来就不能使用管道.这个时候 <() 就显出用处了,它可以接受一个命令,并把它转换成可以当成文件名之类的什么东西：
                # 下载并比较两个网页
            diff &lt;(wget -O - url1) &lt;(wget -O - url2)
        还有一个非常有用处的是"here documents",它能让你在标准输入上输入多行字符串.下面的’MARKER’可以替换成任何字词.
            # 任何字词都可以当作分界符
            command  &lt;&lt; MARKER
            ...
            ${var}
            $(cmd)
            ...
            MARKER
        如果文本里没有内嵌变量替换操作,你可以把第一个MARKER用单引号包起来：
            command &lt;&lt; 'MARKER'
            ...
            no substitution is happening here.
            $ (dollar sign) is passed through verbatim.
            ...
            MARKER

    调试
        对脚本进行语法检查：
            bash -n myscript.sh
        跟踪脚本里每个命令的执行：
            bash -v myscripts.sh
        跟踪脚本里每个命令的执行并附加扩充信息：
            bash -x myscript.sh
        你可以在脚本头部使用set -o verbose和set -o xtrace来永久指定-v和-o.当在远程机器上执行脚本时,这样做非常有用,用它来输出远程信息.
```

93.vim中一些高级替换技巧
```
前几天在实验室一个师姐在写Verilog代码时问了我一个问题,就是她需要定义一系列变量output rca_out_data0~rca_out_data15,现在她已经写好output rca_out_data0,然后复制了15行,她问我怎么把data后面的0一次替换成1~15,我不假思索的说,用脚本呗(我以前coding碰到这 种情况都是用perl -ne来做的).她说不想用脚本,问能不能就用vim就实现,这我倒是没尝试过.这两天腰受伤了,闲在宿舍休息,于是为了解决这个问题,去网上搜了不少资 料,经过整理,总结下述4条对于自己来说比较实用的替换技巧,其中第2条、第3条和第4条都可以完美的解决师姐的问题.过两天去实验室,又可以show一 下这么cool的操作,哈哈~~~
    1.替换变量
        在正规表达式中使用 \( 和 \) 符号括起正规表达式,即可在后面使用\1、\2等变量来访问 \( 和 \) 中的内容.
        example:
        ·将 data1 data2 修改为 data2 data1
        -----------------------------------
        :s/\(\w\+\)\s\+\(\w\+\)/\2\t\1
        -----------------------------------
        ·将 Doe, John 修改为 John Doe
        -----------------------------------
        :%s/\(\w\+\), \(\w\+\)/\2 \1/    
        -----------------------------------
    2.利用函数式替换
        用法：
        ---------------------------
        :s/替换字符串/\=函数式
        ---------------------------
        说明：
        ·函数式可以有多个,返回值可以用字符串连接符.连接起来,如line(".")返回匹配行号(:help line()  ),submatch(n)可以引用\1、\2的内容,其中submatch(0)引用匹配的整个内容；
        ·函数式也可以是字符串常量,用双引号引起来.函数式也可以是任意表达式,需要用小括号引起来,如(3+2*6)；
        ·函数式还可以是寄存器中的内容,通过"@寄存器名"访问,如@a(不需要加引号,但是还是需要用.来连接)；
        example:
        ·要将下列8行的data0依次变成data0~7(前面的数字是行号)
        double data0;
        double data0;
        double data0;
        double data0;
        double data0;
        double data0;
        double data0;
        double data0;
        如果安装有perl的话,我以前一般都是借助perl来完成这件事情：
        ---------------------------------------------------------------------------
        :r !perl -n -le "if(s/^(double\s+data)\d;/$1$k;/){ $k++; print $_; }" %:p---------------------------------------------------------------------------
        其中%:p表示包含完整路径的文件名
        现在只用vim我们就可以完成这样的事情：
        首先将光标移到125行(line(".")返回当前匹配行的行号,line("'a")返回mark a的行号)：
        ---------------------------------------------------------------------------
        ma
        :%s/^\(double\s\+data\)\d\(;\)/\=submatch(1).(line(".")-line("'a")+1).submatch(2)/g
        ---------------------------------------------------------------------------
        再或者
        首先将光标移到125行(line("'V7j
        :%s/^\(double\s\+data\)\d\(;\)/\=submatch(1).(line(".")-line("'
        ---------------------------------------------------------------------------
    3.匹配的开始与结束
        \zs和\ze可以用于替换操作中指明替换的开始与结束,如上例中可以以更短的操作来实现：
        ---------------------------------------------------------------------------
        ma
        :%s#^double\s\+data\zs\d\ze#\=(line(".")-line("'a")+1)#g
        ---------------------------------------------------------------------------
        另外,还可以使用vim表达式来实现上述功能：
        ---------------------------------------------------------------------------
        :let n=0 | g/^double\s\+data\zs\d/s//\=n/ | let n+=1
        ---------------------------------------------------------------------------
        其中 ·|      用来分割不用的命令；
        ·g      在匹配后面模式的行中执行指定的ex命令
        ·\zs    指明匹配由此开始
        ·s//\=n 对匹配模式进行替换,匹配模式为空,表示以上一次匹配成功的模式,
        并且指明替换是一个表达式；
    4. 高级递增替换
        把下面几句放到 _vimrc
        -------------------------------
        let g:I=0
        function! INC(increment)
        let g:I =g:I + a:increment
        return g:I
        endfunction
        ------------------------------
        ·对于上述问题,可以这样解决：
        -----------------------------------------------------
        :let I=-1 | %s/^ double\s\+data\zs\d\ze/\=INC(1)/
        -----------------------------------------------------
        ·还可以生成数字序列,如生成1~100间隔为5的数字序列：
        --------------------------------------
        :let I=0 | ‘a,’b s/^/\=INC(5)/
        --------------------------------------

        Normal
        0

        7.8 磅
        0
        2

        false
        false
        false

        EN-US
        ZH-CN
        X-NONE
```

94.精选命令
```
    删除0字节文件
                    find . -type f -size 0 -exec rm -rf {} \;
                    find . type f -size 0 -delete
    查看进程,按内存从大到小排列
                    ps -e -o "%C : %p : %z : %a"|sort -k5 -nr
    按cpu利用率从大到小排列
                    ps -e -o "%C : %p : %z : %a"|sort -nr
    打印说cache里的url 
                    grep -r -a jpg /data/cache/* | strings | grep "http:" | awk -F’http:’ ‘{print "http:"$2;}’
    查看http的并发请求数及其TCP连接状态 
                    netstat -n | awk ‘/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}’
    sed在这个文里Root的一行,匹配Root一行,将no替换成yes.
                    sed -i ‘/Root/s/no/yes/’ /etc/ssh/sshd_config
    如何杀掉mysql进程 
                    ps aux |grep mysql |grep -v grep  |awk ‘{print $2}’ |xargs kill -9
                    killall -TERM mysqld
                    kill -9 `cat /usr/local/apache2/logs/httpd.pid`
    显示运行3级别开启的服务(从中了解到cut的用途,截取数据)
                    ls /etc/rc3.d/S* |cut -c 15-
    如何在编写SHELL显示多个信息,用EOF
                    cat << EOF
                        +————————————————————–+
                        |   === Welcome to Tunoff services ===                         |
                        +————————————————————–+
                        EOF
    for的用法(如给mysql建软链接)
                    cd /usr/local/mysql/bin
                        for i in *
                        do ln /usr/local/mysql/bin/$i /usr/bin/$i
                        done
    取IP地址
                    ifconfig eth0 |grep "inet addr:" |awk ‘{print $2}’|cut -c 6-
                    ifconfig | grep ‘inet addr:’| grep -v ’127.0.0.1′ |cut -d: -f2 | awk ‘{ print $1}’
    内存的大小
                    free -m |grep "Mem" | awk ‘{print $2}’
    统计httpd进程数,结果表明服务器可以处理多少个并发请求.一般是几千
                ps -ef | grep httpd | wc -l
    返回当前所有80端口的请求总数
                netstat -nat | grep -i "80" | wc -l
    打印系统所有80端口已建立的连接总数
                netstat -na | grep ESTABLISHED | wc -l
    查看80端口的连接,并排序
                    netstat -an -t | grep ":80" | grep ESTABLISHED | awk '{printf "%s %s\n",$5,$6}' | sort
    查看Apache的并发请求数及其TCP连接状态
                    netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
    统计一下服务器下面所有的jpg的文件的大小 
                    find / -name *.jpg -exec wc -c {} \;|awk ‘{print $1}’|awk ‘{a+=$1}END{print a}’
    统计nginx里面的状态码出现次数
                    cat /var/log/nginx/access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -r
                    awk '{print $9}' /var/log/nginx/access.log | sort | uniq -c | sort -r
    统计nginx里面返回404的文件
                    awk '($9 ~ /404/)' access.log | awk '{print $7}' | sort | uniq -c | sort -r
    统计nginx里面的坏文件连接
                    awk -F\" '($2 ~ "/wp-admin/install.php"){print $1}' access.log | awk '{print $1}' | sort | uniq -c | sort -r
    最多请求url
                    awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r
    最多请求包含了关键字ref
                    awk -F\" '($2 ~ "ref"){print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r
    统计单位时间的请问
                #!/bin/bash
                log_dir="/home/sh/"
                log_file="count.log"
                begin_time=`date +%F`
                count_log()
                {
                    if [ ! -d "$log_dir" ];
                    then
                        mkdir "$log_dir"
                    fi

                    if [ ! -f "$log_file" ]
                    then
                        touch "$log_file"
                    fi
                }
                proc_count()
                {
                    count=`netstat -an | grep -E "^(tcp)"| grep -c 'ESTABLISHED'`
                    return $count
                }

                while [ true ]; do
                /bin/sleep 1
                proc_count
                count_number=$?
                echo "${count_number}" >> ${log_dir}${log_file} 2>&1
                done
                #cat count.log | awk '{sum+=$1};END{print sum}'
    CPU的数量   
                    cat /proc/cpuinfo |grep -c processor
    CPU负载
                    cat /proc/loadavg
    CPU负载
                    mpstat 1 1
    内存空间
                    free
    磁盘空间
                    df -h
    如发现某个分区空间接近用尽,可以进入该分区的挂载点,用以下命令找出占用空间最多的文件或目录
                    du -cks * | sort -rn | head -n 10
    磁盘I/O负载 
                    iostat -x 1 2
    网络负载
                    sar -n DEV
    网络错误 
                    netstat -i
                    cat /proc/net/dev
    网络连接数目
                    netstat -an | grep -E "^(tcp)" | cut -c 68- | sort | uniq -c | sort -n
    进程总数
                    ps aux | wc -l
    查看进程树
                    ps aufx
    可运行进程数目
                    vmwtat 1 5
    检查DNS Server工作是否正常,这里以61.139.2.69为例 
                    dig www.baidu.com @61.139.2.69
    检查当前登录的用户个数
                    who | wc -l
    日志查看、搜索 
                    cat /var/log/rflogview/*errors
                    grep -i error /var/log/messages
                    grep -i fail /var/log/messages
                    tail -f -n 2000 /var/log/messages
    内核日志        dmesg
    时间            date
    已经打开的句柄数
                    lsof | wc -l
    网络抓包,直接输出摘要信息到文件.
                    tcpdump -c 10000 -i eth0 -n dst port 80 > /root/pkts
    然后检查IP的重复数 并从小到大排序 注意 "-t\  +0″ 中间是两个空格,less命令的用法.
                    less pkts | awk {‘printf $3″\n"‘} | cut -d. -f 1-4 | sort | uniq -c | awk {‘printf $1″ "$2″\n"‘} | sort -n -t\  +0
    kudzu查看网卡型号
                    kudzu –probe –class=network
```

95.vim 查看启动.会生成time.txt
```
vi README.md --startuptime 'time.txt'
```

96.smb 
```
smb://192.168.84.2/public/ITO/Training
    smb://10.17.2.12
    username,domainname,mail-pwd.
```

97.HP机器需要原装键盘来重回bios

98.shadowsocks
```
pip install shadowsocks

front:  ssserver -c /etc/shadowsocks.json

ssserver -p server_port -k password -m bf-cfb --workers 2
back:   ssserver -c /etc/shadowsocks.json -d start --pid-file=/tmp/shadowsocks.pid
        ssserver -c /etc/shadowsocks.json -d stop --pid-file=/tmp/shadowsocks.pid


command: sslocal -c /etc/shadowsocks-libev/shadowsocks.json
         ss-local -c /etc/shadowsocks-libev/config.json 
client: sslocal -s server_name -p server_port -l local_port -k password -m bf-cfb
```

99.ldd 用于打印程序或者库文件所依赖的共享库列表.
```
    ladd xxx.so
    ldd(选项)(参数) 
    选项
    ldd --version 
    ldd -v 详细信息模式
    ldd -u 打印未使用的直接依赖
    ldd -d 执行重定位和报告任何丢失的对象
    ldd -r 执行数据对象和函数的重定位,并且报告任何丢失的对象和函数
    ldd --help  显示帮助信息
    参数 文件,指定可执行程序或者文库.
```

100.zsh
```
    apt-get install zsh
    /usr/bin/zsh
    /etc/passwd 修改修改用户的bash /bin/zsh
    chsh -s /bin/zsh
```

101.rename
```
rename [-v -n -f] <pcre> <files>   -v 会显示文件名改变的细节 -n 选项告诉rename命令在不实际改变名称的情况下显示文件将会重命名的情况.这个选项在你想要在不改变文件名的情况下模拟改变文件名的情况下很有用.-f 选项强制覆盖存在的文件.
rename 's/\.jpeg$/\.jpg/' *.jpeg 重名令jpg为jpeg
rename 'y/A-Z/a-z/' *             大写改成小写
rename -v 's/img_\d{3}(\d{4})\.jpeg$/dan_$1\.jpg/' *jpeg    将img_000NNNN.jpeg变成dan_NNNN.jpg
```

102.ample
```
/usr/bin/ample -p30303-c5 -f /etc/ample/ample.conf -d
http://192.168.85.123:30303
http://192.168.85.123:30303/index.html
```

103.GPG KEY error, No PUBKEY xxxxx
```
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com xxxxxx
```

104.ctags -R ./xxx ./xxx ./xxx 指定对哪些文件作索引

105.window + space 来控制root下的ibus输入法切换
```
windows键可以在stardict双击选中单词的时候,按住windows键可以弹出屏幕取词
```

106,REALVNC
```
dpkg -i VNC-Server-5.2.3-Linux-x64.deb
    key:8KNFU-MZZHE-WA449-2SLLH-48Q7A
mkdir /usr/lib/systemd/system
systemctl start vncserver-x11-serviced.service
vnclicensewiz
然后就可以直接用了,添加用户,配置密码
dpkg -i VNC-Viewer-5.2.3-Linux-x64.deb
option里选Security->VNC password->Alwas On
```

107,cups
```
aptitude install cups cups-client
/etc/init.d/cups start
http://localhost:631
system-config-printer
可以配置
```

108.zeal
```
apt-get install qt5-default qt5-qmake libarchive-dev libarchive13 libxcb-keysyms1-dev libxcb-keysyms1 libqt5webkit5-dev libqt5x11extras5 libqt5x11extras5-dev
```

109.ipython
```
[TAB]列出所有可用的子物件和方法.如输入"os."按tab可以显示所有os的
%pdoc 模组 或 模组? 会出现该模组或方法的文件. 
%psource 模组 或%pfile 模组 或 模组?? 会显示该模组的代码. 如os??
输入edit可以直接编辑代码.编辑器用的系统默认的editor.
这些都是ipython的神奇指令magic command.可以通过automagic 关闭, %automagic开启
常用的magic command:
%magic 查看所有指令
%edit 编辑并执行文件
%edit -x filename 编辑但不执行文件
%edit 5:20 filename 编辑文件第5行,第20个字符
%pwd 显示当前目录
%time statement 计算程序执行时间
要调用linux系统命令,可以直接加!符号.
```

110.mysql procedure
```
创建create procedure sp_name(参数列表)
        BEGIN
        ...
        END
调用call sp_name()
删除drop procedure sp_name
显示show procedure status
show create procedure sp_name

存储过程参数有三种类型:
IN: 输入参数,必须在调用存储过程时指定, 默认未指定类型时则是此类型
    在存储过程中修改该参数的值不能被返回. 为默认值
    CREATE PROCEDURE SP_IN_PARA(IN p_in INT)
        BEGIN
        select p_in;
        set p_in=2;
        select p_in;
        END;

        执行:
        set @p_in=1;
        call SP_IN_PARA(@p_in);
        select @p_in;   输出1
OUT:输出参数,在存储过程内部可以被改变,并且可返回
    CREATE PROCEDURE sp_out_param(OUT p_out INT)
        begin
        select p_out;
        set p_out=2;
        select p_out;
        END;

        执行:
        set @p_out=1;
        call sp_out_param(@p_out); 输出3
        select @p_out;  输出2
INOUT:输入输出参数,IN和OUT结合,调用时指定,并且可被改变和返回
    CREATE PROCEDURE sp_inout_param(INOUT p_inout INT)
        BEGIN
        select p_inout;
        SET p_inout=5;
        select p_inout;
        END;

        set @p_input=3;
        call sp_inout_param(@p_inout); 输出3
        select @p_inout;    输出3
DECLARE var_name,[var_name...] data_type DEFAULT default_value 声明局部变量
    e.g: DECLARE a,b,c INT DEFAULT 5;
SET 对已声明的变量复制或者重新赋值. SET var_name=表达式值[.variable_name=expression...]
SELECT 显示变量, SELECT var into out_var 将变量值写入OUT参数
    e.g: SELECT 'hello world' into @x;
        SELECT @x;
        SET @y='Good bye !';
        SELECT @y;
事件Event 可以定义一些任务调度,首先需要开启事件调度的支持 SET GLOBAL event_scheduler = 1;
创建语法:
    CREATE EVENT [IF NOT EXISTS] <event_name>
    ON SCHEDULE <schedule>
    DO
    <event_body>;
SHOW EVENTS列出所有事件 show events\G;
SHOW CREATE EVENT <event_name>查看一个已存在的事件的信息

注释: -- , # 用于单行注释, /* ...*/ 多行注释
存储过程名字后面的()是必须的.
不能在存储过程参数名称前+@,只能 b int
存储过程的参数不能指定默认值,不能省略参数, 可以用null代替, 不需要在procedure body前加as,
比如mysql存储过程包含多条mysql语句, 需要begin end 关键字
create procedure pr_add(
            a int,
            b int.
            )
            BEGIN
            mysql statement1 ...;
            mysql statement2 ...;
            end;
每条语句的末尾,都要分号;
declare c int;
if a is null then
set a = 0;
end if;
...
end;

DROP procedure if exists selectnum;
DELIMITER //
CREATE PROCEDURE  selectnum(IN num INT)
BEGIN
    select num;
    set num=100;
    select num * 100;
END //
DELIMITER ;

set @a=555;
CALL selectnum(@a);
```

算术运算符: +,-,*,/,DIV,%
```
    SET var5=10 DIV 3; 3
    SET var6=10%3;   1
比较运算符, 下面的返回True/False
>,<,<=,>=,BETWEEN,NOT BETWEEN, IN, NOT IN, =, <> !=  , <=>, LIKE, REGEXP, IS NULL, IS NOT NULL
    5 BETWEEN 1 AND 10    True 5 IN (1,2,3,4) False
    2 <> 3 False
    NUll <=> NULL  True 严格比较两个值是否相等
    "Guy Harrison" LIKE "Guy%" True
    "Guy Harrison" REGEXP "[Gg]reg" False 
    0 IS NULL  False
逻辑运算符
位运算符
|或, &与, <<左移位, >>右, ~非(取反)
流程控制:
    分支
        if
        case
    循环
        for循环
        while循环
        loop循环
        repeat until循环
    区块定义
        BEGIN
        ...
        END;
        或者取别名:
        lable1:BEGIN
        ...
        END lable1;
        可以用levae label1; 来跳出区块,执行区块后的代码

函数库,字符串类型,数值类型,日期类型
一、字符串类
CHARSET(str) //返回字串字符集
CONCAT (string2 [,… ]) //连接字串
INSTR (string ,substring ) //返回substring首次在string中出现的位置,不存在返回0
LCASE (string2 ) //转换成小写
LEFT (string2 ,length ) //从string2中的左边起取length个字符
LENGTH (string ) //string长度
LOAD_FILE (file_name ) //从文件读取内容
LOCATE (substring , string [,start_position ] ) 同INSTR,但可指定开始位置
LPAD (string2 ,length ,pad ) //重复用pad加在string开头,直到字串长度为length
LTRIM (string2 ) //去除前端空格
REPEAT (string2 ,count ) //重复count次
REPLACE (str ,search_str ,replace_str ) //在str中用replace_str替换search_str
RPAD (string2 ,length ,pad) //在str后用pad补充,直到长度为length
RTRIM (string2 ) //去除后端空格
STRCMP (string1 ,string2 ) //逐字符比较两字串大小,
SUBSTRING (str , position [,length ]) //从str的position开始,取length个字符,
注：mysql中处理字符串时,默认第一个字符下标为1,即参数position必须大于等于1
mysql> select substring(’abcd’,0,2);
+———————–+
| substring(’abcd’,0,2) |
+———————–+
|                       |
+———————–+
1 row in set (0.00 sec)

mysql> select substring(’abcd’,1,2);
+———————–+
| substring(’abcd’,1,2) |
+———————–+
| ab                    |
+———————–+
1 row in set (0.02 sec)

TRIM([[BOTH|LEADING|TRAILING] [padding] FROM]string2) //去除指定位置的指定字符
UCASE (string2 ) //转换成大写
RIGHT(string2,length) //取string2最后length个字符
SPACE(count) //生成count个空格

二、数值类型

ABS (number2 ) //绝对值
BIN (decimal_number ) //十进制转二进制
CEILING (number2 ) //向上取整
CONV(number2,from_base,to_base) //进制转换
FLOOR (number2 ) //向下取整
FORMAT (number,decimal_places ) //保留小数位数
HEX (DecimalNumber ) //转十六进制
注：HEX()中可传入字符串,则返回其ASC-11码,如HEX(’DEF’)返回4142143
也可以传入十进制整数,返回其十六进制编码,如HEX(25)返回19
LEAST (number , number2 [,..]) //求最小值
MOD (numerator ,denominator ) //求余
POWER (number ,power ) //求指数
RAND([seed]) //随机数
ROUND (number [,decimals ]) //四舍五入,decimals为小数位数]

注：返回类型并非均为整数,如：

(1)默认变为整形值
mysql> select round(1.23);
+————-+
| round(1.23) |
+————-+
|           1 |
+————-+
1 row in set (0.00 sec)

mysql> select round(1.56);
+————-+
| round(1.56) |
+————-+
|           2 |
+————-+
1 row in set (0.00 sec)

(2)可以设定小数位数,返回浮点型数据

mysql> select round(1.567,2);
+—————-+
| round(1.567,2) |
+—————-+
|           1.57 |
+—————-+
1 row in set (0.00 sec)

SIGN (number2 ) //返回符号,正负或0
SQRT(number2) //开平方

三、日期类型

ADDTIME (date2 ,time_interval ) //将time_interval加到date2
CONVERT_TZ (datetime2 ,fromTZ ,toTZ ) //转换时区
CURRENT_DATE ( ) //当前日期
CURRENT_TIME ( ) //当前时间
CURRENT_TIMESTAMP ( ) //当前时间戳
DATE (datetime ) //返回datetime的日期部分
DATE_ADD (date2 , INTERVAL d_value d_type ) //在date2中加上日期或时间
DATE_FORMAT (datetime ,FormatCodes ) //使用formatcodes格式显示datetime
DATE_SUB (date2 , INTERVAL d_value d_type ) //在date2上减去一个时间
DATEDIFF (date1 ,date2 ) //两个日期差
DAY (date ) //返回日期的天
DAYNAME (date ) //英文星期
DAYOFWEEK (date ) //星期(1-7) ,1为星期天
DAYOFYEAR (date ) //一年中的第几天
EXTRACT (interval_name FROM date ) //从date中提取日期的指定部分
MAKEDATE (year ,day ) //给出年及年中的第几天,生成日期串
MAKETIME (hour ,minute ,second ) //生成时间串
MONTHNAME (date ) //英文月份名
NOW ( ) //当前时间
SEC_TO_TIME (seconds ) //秒数转成时间
STR_TO_DATE (string ,format ) //字串转成时间,以format格式显示
TIMEDIFF (datetime1 ,datetime2 ) //两个时间差
TIME_TO_SEC (time ) //时间转秒数]
WEEK (date_time [,start_of_week ]) //第几周
YEAR (datetime ) //年份
DAYOFMONTH(datetime) //月的第几天
HOUR(datetime) //小时
LAST_DAY(date) //date的月的最后日期
MICROSECOND(datetime) //微秒
MONTH(datetime) //月
MINUTE(datetime) //分

注：可用在INTERVAL中的类型：DAY ,DAY_HOUR ,DAY_MINUTE ,DAY_SECOND ,HOUR ,HOUR_MINUTE ,HOUR_SECOND ,MINUTE ,MINUTE_SECOND,MONTH ,SECOND ,YEAR
DECLARE variable_name [,variable_name...] datatype [DEFAULT value]; 
其中,datatype为mysql的数据类型,如:INT, FLOAT, DATE, VARCHAR(length)

例：
DECLARE l_int INT unsigned default 4000000; 
DECLARE l_numeric NUMERIC(8,2) DEFAULT 9.95; 
DECLARE l_date DATE DEFAULT '1999-12-31'; 
DECLARE l_datetime DATETIME DEFAULT '1999-12-31 23:59:59';
DECLARE l_varchar VARCHAR(255) DEFAULT 'This will not be padded';
```

102.strace命令
```
显示streams跟踪消息, 
没有参数的 strace 命令将所有的驱动程序和模块中的所有 STREAMS 事件跟踪消息写入它的标准输出.这些消息是从 STREAMS 日志驱动程序中获取的.如果提供参数,它们必须是在三元组中.每个三元组表明跟踪消息要从给定的模块或驱动程序、子标识(通常表明次要设备)以及优先级别等于或小于给定级别的模块或驱动程序中接收.all 标记可由任何成员使用,以表明对该属性没有限制.

语法 strace [ mid sid level ] mid 指定STREAMS模块的标识号.  sid指定子标识号. level指定跟踪优先级别
输出格式 每个跟踪消息输出的格式是： <seq> <time> <ticks> <level> <flags> <mid> <sid> <text>
<seq>跟踪序列号. <time>消息时间(hh:mm:ss) <ticks>系统启动后以机器滴答信号表示消息的时间.<level>跟踪优先级别.<flag> E消息也在错误日志那个/F表示致命错误/N邮件已发送给SA
<mid>源的模块标识号.<sid>源的子标识号.<text>跟踪消息的格式化文本.(在多处理器系统上,由两部分组成,消息发送者发送处的处理器号码,格式化文本本身)
一旦strace启动将继续执行直到用户终止.
由于性能的考虑,所以一次只允许一个 strace 命令来打开 STREAMS 日志驱动程序.日志驱动程序有一个三元组的列表(该列表在命令调用中指定),并且程序会根据该列表比较每个潜在的跟踪消息,以决定是否要格式化和发送这个信息到 strace 进程中.因此,长的三元组列表会对 STREAMS 的总体性能的影响更大.运行 strace 命令对于某些模块和驱动程序(生成要发送给 strace 进程的跟踪消息的模块和驱动程序)的定时的影响最大.如果跟踪消息生成过快,以至 strace 进程无法处理,那么就会丢失一些消息.最后的情况可以通过检查跟踪消息输出上的序列号来确定.

strace用法, 
    1.可以找到被一个程序读取的配置文件.e.g: strace php 2>&1 | grep php.ini
    2.跟踪指定的系统调用, -e选项仅仅被用来展示特定的系统调用.比如open,write
        e.g: strace -e open cat dead.letter
    3. 通过使用-p选项能用在运行的进程上.
        e.g: strace -p 6543
    4. 统计概要. -c选项以一种整洁的方式展示.
        e.g: strace -c ls
    5. 保存输出结果 -o 
        e.g: strace -o filename -p 7777
    6. 显示时间戳 -t, -tt选项可以展示微秒级别的时间戳, -ttt则是从epoch(1970/1/1 00:00:00 UTC)展示秒数, -r展示系统调用之间的相对时间戳
        e.g: strace -t ls
    7
strace -f -e execve git ls
```

103.trigger
```
show triggers;
################ TRIGGER START #################
DELIMITER //
DROP TRIGGER IF EXISTS t_after_update_on_model_param//
CREATE TRIGGER t_after_update_on_model_param
AFTER UPDATE ON PLM.planning_bom_model_param 
FOR EACH ROW
BEGIN
IF  new.prod_cycle_time != old.prod_cycle_time then
    INSERT INTO dbname.planning_bom_change_log(`table_name`, `primary_key_id`, `change_action`, `col_name`, `new_value`, `change_source`, `change_user_id`, `change_timestamp`) 
        values ('planning_bom_model_param', old.id, 'update', 'prod_cycle_time', new.prod_cycle_time, 'excel', 0, CURRENT_TIMESTAMP);
ELSEIF new.default_bom != old.default_bom then
    INSERT INTO dbname.planning_bom_change_log(`table_name`, `primary_key_id`, `change_action`, `col_name`, `new_value`, `change_source`, `change_user_id`, `change_timestamp`) 
        values ('planning_bom_model_param', old.id, 'update', 'default_bom', new.default_bom, 'excel', 0, CURRENT_TIMESTAMP);
END IF;
END//
DELIMITER ;
################ TRIGGER END #################
```

104.systemctl
```
systemctl is-enabled nginx  #check nginx will start when system initial
systemctl enable mysql      #make mysql will start when system initial
systemctl --failed          #list all failed
systemctl status mysql      #show the mysql status
```

105.mysql perfermance
```
    需要10s,30s,60s这样来计算每个选项的差异值, 然后再计算
    (1)QPS(每秒Query量) 
    QPS = Questions(or Queries) / seconds 
    mysql> show global status like 'Question%';

    (2)TPS(每秒事务量)
    TPS = (Com_commit + Com_rollback) / seconds
    mysql> show global status like 'Com_commit';
    mysql> show global status like 'Com_rollback';

    (3)key Buffer 命中率
    mysql> show global status like 'key%';
    key_buffer_read_hits = (1-key_reads / key_read_requests) * 100%
    key_buffer_write_hits = (1-key_writes / key_write_requests) * 100%

    (4)InnoDB Buffer命中率 
    mysql> show status like 'innodb_buffer_pool_read%';
    innodb_buffer_read_hits = (1 - innodb_buffer_pool_reads / innodb_buffer_pool_read_requests) * 100%

    (5)Query Cache命中率
    mysql> show status like 'Qcache%';
    Query_cache_hits = (Qcahce_hits / (Qcache_hits + Qcache_inserts )) * 100%;

    (6)Table Cache状态量 
    mysql> show global  status like 'open%';
    比较 open_tables  与 opend_tables 值

    (7)Thread Cache 命中率 
    mysql> show global status like 'Thread%'; =
    mysql> show global status like 'Connections';
    Thread_cache_hits = (1 - Threads_created / connections ) * 100%

    (8)锁定状态
    mysql> show global  status like '%lock%';
    Table_locks_waited/Table_locks_immediate=0.3%  如果这个比值比较大的话,说明表锁造成的阻塞比较严重
    Innodb_row_lock_waits innodb行锁,太大可能是间隙锁造成的 

    (9)复制延时量
    mysql > show slave status 
    查看延时时间 

    (10) Tmp Table 状况(临时表状况) 
    mysql > show status like 'Create_tmp%'; 
    Created_tmp_disk_tables/Created_tmp_tables比值最好不要超过10%,如果Created_tmp_tables值比较大, 
    可能是排序句子过多或者是连接句子不够优化 

    (11) Binlog Cache 使用状况 
    mysql > show status like 'Binlog_cache%'; 
    如果Binlog_cache_disk_use值不为0 ,可能需要调大 binlog_cache_size大小 

    (12) Innodb_log_waits 量 
    mysql > show status like 'innodb_log_waits'; 
    Innodb_log_waits值不等于0的话,表明 innodb log  buffer 因为空间不足而等待 

    比如命令： 
    >#show global status; 
    虽然可以使用： 
    >#show global status like %...%; 

    TPS - Transactions Per Second(每秒传输的事物处理个数),即服务器每秒处理的事务数,如果是InnoDB会显示,没有InnoDB就不会显示.
    TPS = (COM_COMMIT + COM_ROLLBACK)/UPTIME

    use information_schema;
    select VARIABLE_VALUE into @num_com from GLOBAL_STATUS where VARIABLE_NAME ='COM_COMMIT';
    select VARIABLE_VALUE into @num_roll from GLOBAL_STATUS where VARIABLE_NAME ='COM_ROLLBACK';
    select VARIABLE_VALUE into @uptime from GLOBAL_STATUS where VARIABLE_NAME ='UPTIME';
    select (@num_com+@num_roll)/@uptime;


    QPS - Queries Per Second(每秒查询处理量)MyISAM 引擎
    QUESTIONS/UPTIME

    use information_schema;
    select VARIABLE_VALUE into @num_queries from GLOBAL_STATUS where VARIABLE_NAME ='QUESTIONS';
    select VARIABLE_VALUE into @uptime from GLOBAL_STATUS where VARIABLE_NAME ='UPTIME';
    select @num_queries/@uptime;
```

106.debconf-show
```
    查询包在数据库中的配置
    debconfig-show grub-pc
```

107.info -f linux-command -n 'keyword'
```
    在info中详细查找指定的文件(linux-command)的某个keyword节点
```

108.4kdownload
```
    perferences: proxy enabled
    server:socks5://127.0.0.1
    port:7070
```

109.分卷压缩
```
split -d -b2G xp-disk1.vmdk
会分割成x00, x01, x02...这样
使用cat x* > xp-disk1.vmdk来合并
```

110.hash sum mismatch
```
apt-get clean 
rm -rf /var/lib/apt/lists/*
apt-get update
apt-get upgrade
```

111.shell for loop
```
for file in {'xxx1', 'xx2', 'xxx3'}; do echo -e "\033[32m${file}\033[0m"; cat $file; done
for file in `ls`;do echo -e "\033[32m${file}\033[0m";cat $file; done
for i in $(seq 1 $END); do echo $i; done
for i in {1..5}; do echo $i; done
for n in {1..1000}; do echo -e "\033[32m $n\033[0m" \; `rpm -qa | grep hyve`; done;
循环一组数据到file然后输出
```

112.查看硬件相关信息
```
dmidecode -t1
ipmitool fru print

dmidecode -t   -t是类型, 后面跟要输出的类型,比如processor
    -d, --dev-mem FILE Read memory from device FILE (default: /dev/mem) #从设备文件读信息,输出内容与不加参数标准输出相同
    -h, --help Display this help text and exit #显示帮助信息
    -q, --quiet Less verbose output #显示更少的简化信息
    -s, --string KEYWORD Only display the value of the given DMI string #只显示指定DMI字符串的信息
    -t, --type TYPE Only display the entries of given type #只显示指定条目的信息
    -u, --dump Do not decode the entries #显示未解码的原始条目内容
    --dump-bin FILE Dump the DMI data to a binary file
    --from-dump FILE Read the DMI data from a binary file
    -V, --version Display the version and exit #显示版本信息

    1、查看服务器型号：dmidecode | grep 'Product Name'
    2、查看主板的序列号：dmidecode |grep 'Serial Number'
    3、查看系统序列号：dmidecode -s system-serial-number
    4、查看内存信息：dmidecode -t memory
    5、查看OEM信息：dmidecode -t 1
    6、查看bios,processor信息：dmidecode -t 0,4
        Type  Information
        0  BIOS
        1  System
        2  Base Board
        3  Chassis
        4  Processor
        5  Memory Controller
        6  Memory Module
        7  Cache
        8  Port Connector
        9  System Slots
        10  On Board Devices
        11  OEM Strings
        12  System Configuration Options
        13  BIOS Language
        14  Group Associations
        15  System Event Log
        16  Physical Memory Array
        17  Memory Device
        18  32-bit Memory Error
        19  Memory Array Mapped Address
        20  Memory Device Mapped Address
        21  Built-in Pointing Device
        22  Portable Battery
        23  System Reset
        24  Hardware Security
        25  System Power Controls
        26  Voltage Probe
        27  Cooling Device
        28  Temperature Probe
        29  Electrical Current Probe
        30  Out-of-band Remote Access
        31  Boot Integrity Services
        32  System Boot
        33  64-bit Memory Error
        34  Management Device
        35  Management Device Component
        36  Management Device Threshold Data
        37  Memory Channel
        38  IPMI Device
        39  Power Supply

    7、查看内存槽数、那个槽位插了内存,大小是多少 
        dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range
    8、查看最大支持内存数
        dmidecode|grep -P 'Maximum\s+Capacity'
    9、查看槽位上内存的速率,没插就是unknown.
        dmidecode|grep -A16 "Memory Device"|grep 'Speed'
```

113.Xfce4 notes file folder
```
~/.local/share/notes
```

114.ipmitool
```
168A. 通过OS监控本地服务,实现对本地服务器的管理

ipmitool -I open command 意思是用Openipmi接口, command选项如下
    raw #发送一个原始的IPMI请求,并且打印回复信息.
    Lan #配置网络(lan)信道(channel)
    chassis #查看底盘的状态和设置电源
    event #向BMC发送一个已经定义的事件(event),可用于测试配置的SNMP是否成功
    mc #查看MC(Management Contollor)状态和各种允许的项
    sdr #打印传感器仓库中的所有监控项和从传感器读取到的值.
    Sensor #打印详细的传感器信息.
    Fru #打印内建的Field Replaceable Unit (FRU)信息
    Sel #打印 System Event Log (SEL)
    Pef #设置 Platform Event Filtering (PEF),事件过滤平台用于在监控系统发现有event时候,用PEF中的策略进行事件过滤,然后看是否需要报警.
    Sol/isol #用于配置通过串口的Lan进行监控
    User #设置BMC中用户的信息 .
    Channel #设置Management Controller信道.
        ipmitool –I open sensor list #命令可以获取传感器中的各种监测值和该值的监测阈值,包括(CPU温度,电压,风扇转速,电源调制模块温度,电源电压等信息)
        ipmitool –I open sensor get "CPU0Temp" #可以获取ID为CPU0Temp监测值,CPU0Temp是sensor的ID,服务器不同,ID表示也不同.
        ipmitool –I open sensor thresh #设置ID值等于id的监测项的各种限制值.
        ipmitool –I open chassis status #查看底盘状态,其中包括了底盘电源信息,底盘工作状态等
        ipmitool –I open chassis restart_cause #查看上次系统重启的原因
        ipmitool –I open chassis policy list #查看支持的底盘电源相关策略.
        ipmitool –I open chassis power on #启动底盘,用此命令可以远程开机
        ipmitool –I open chassis power off #关闭底盘,用此命令可以远程关机
        ipmitool –I open chassis power reset #实现硬重启,用此命令可以远程重启
    #Ipmi还可以设置系统启动boot的设备,具体见ipmitool帮助文档
        ipmitool –I open mc reset #使BMC重新硬启动
        ipmitool –I open mc info #查看BMC硬件信息
        ipmitool –I open mc getenables #列出BMC所有允许的选项
        ipmitool –I open mc setenables =[on|off] #设置bmc相应的允许/禁止选项.
        ipmitool  -I open event 1 #发送一个温度过高的消息到System Event Log中,可以发送的Event有：
            Temperature: Upper Critical: Going High
            Voltage Threshold: Lower Critical: Going Low
            Memory: Correctable ECC Error Detected
        ipmitool -I open event #命令可以用测试配置的IPMI中的snmp功能是否成功.
        ipmitool -I open lan print 1 #打印现咱channel 1的信息 .
        ipmitool -I open lan set 1 ipaddr 10.10.113.95 #设置channel 1的IP地址为10.10.113.95
        ipmitool -I open lan set 1 snmp public #设置channel 1 上snmp的community为public.
        ipmitool -I open lan set 1 access on #设置channel 1允许访问.
        ipmitool -I open pef info #打印Platform Event Filtering (pef)信息
        ipmitool -I open pef status #查看Platform Event Filtering (pef)状态
        ipmitool -I open pef policy #查看Platform Event Filtering (pef)策略设置
        ipmitool -I open sdr list fru #读取fru信息并显示.
        ipmitool sel clear #清除记录
        ipmitool sel elist
        ipmitool sel list
        ipmitool fru
        ipmitool fru print #显示fru信息
        ipmitool fru print 0
        ipmitool fru print 1
        ipmitool bmc reset cold #重启bmc
        ipmitool sdr #查看psu fan (BAT)等信息
        ipmitool sdr type fan
        ipmitool mc info #查看bmc信息
        ipmitool lan print #显示lan信息
        ipmitool lan print|egrep "MAC Address" #得到bmc的oui
        ipmitool lan set 1 ipsrc dhcp #设置动态ip 1用户
        ipmitool -H $bmc_ip -U admin -P admin mc info #设置用户名密码
        ipmitool chassis policy always-off
        ipmitool chassis identify force
        ipmitool chassis identify off
        ipmitool sdr type Temperature
        ipmitool sol payload enable 1


168B 通过网络监控远程服务器
被监控服务器需要硬件和操作系统接口驱动的支持,可以无需安装应用软件.监控客户端需要应用软件如ipmitool工具,可以无需硬件和操作系统接口驱动的支持.ipmi的远程监控是通过向与BMC相连的网络接口发送udp数据包实现的,udp数据包的定位是通过把ip地址写BMC芯片来实现,而这需要本地的Ipmi系统接口来完成连接.Ipmitool可以通过LAN远程监控系统,同时BMC中保存有一序列用户名和密码,通过LAN进行远端访问需要用户名和密码.

    被监控服务器使用ipmitool更改ip,查看ip
        ipmitool lan set 1 ipaddr  172.16.6.222
        ipmitool lan print 1
    监控客户端Ipmi ip地址也必须和被监控服务端在同一网段
        ipmitool lan print 1
    能够Ping通被监控服务器地址 则可以远程管理该主机

    ipmitool -I lanplus -H 172.16.6.222 -U root -P password sol activate

    查看ipmi信息    #ipmitool mc info
    人员            #ipmitool user list 1
    查看绑定IP      #ipmitool  lan print 1
    更改IP          #ipmitool lan set 1 ipaddr  x.x.x.x
    更改密码        #ipmitool user list 1
                    #ipmitool user set password 2 "123456"

    ipmitool的SOL远程控制服务器
        #ipmitool -I lanplus -H x.x.x.x  -U  root -P  password sol (de)activate
    强制重启(关闭或开启)被监控服务器
        #ipmitool -I lanplus -H x.x.x.x -U root -P password chassis power reset (off on)
    列出日志  
        #ipmitool sel list
    快捷键 ~.  是退出ipmi
```

115,UWSGI
```
pip install uwsgi
uwsgi --ini uwsgi.ini --http:33333
```

116,runlevel
```
0 - Runlevel 0 means system shutdown
1 - Runlevel 1 means single-user, rescue mode
5 - Runlevel 5 means multi-user, network enabled, graphical mode
6 - Runlevel 6 is for system reboot
In general, runlevels 2, 3 and 4 mean states where Linux has booted in multi-user, network enabled, text mode.
```

117, smartctl to check drive
```
smartctl -a -s on /dev/sda
```

118.cat json.txt | python -mjson.tool 用python来格式化输出json字符串

119.shell 追加path环境变量
```
export PATH="$PATH:追加的path"
```

120.Markdown
```
==== 最高阶标题
---- 次阶标题
> 区块引用
## 等同于header2, ### h3
*强调的内容*
**强调的内容**
__强调的内容__
* 无序列表1     +, -
* 无序列表2     +, -
* 无序列表3     +, - 效果一样
1. 有序列表
2. 有序列表
3. 有序列表
一段和另外一段插入空行, 会把第一段用<p>包起来
链接 
This is an [example link](http://example.com/).
This is an [example link](http://example.com/ "With a Title").
图片
![alt text](/path/to/img.jpg "Title")
分隔线用三个以上的星号,减号,底线来建立一个分割线
***
---
```

121.arp 扫描内网ip冲突
```
apt-get install arp-scan
arp-scan -I eth0 -l 重复出现的IP就是IP冲突
```

##########################################################################
5.2 更新hg                                          2013-11-14 11:14:11
5.3 更新hg merge                                    2013-11-20 11:02:31
5.4 更新shell 控制码                                2013-12-09 14:41:20
5.5 更新date参数                                    2013-12-11 16:38:09
5.6 更新131                                         2013-12-23 10:28:18
6.1 更新xargs grep -A/B num                         2014-01-24 18:22:57
6.2 更新tcpdump                                     2014-02-12 09:48:36
6.3 更新invoke-rc.d,update-rc.d,ss,lrth             2014-02-21 16:05:48
6.4 更新终端支持256                                 2014-03-17 15:54:20
6.5 更新虚拟机137                                   2014-03-25 14:43:19
6.6 更新shell                                       2014-04-01 17:50:00
6.7 更新vim 和 uuid查看                             2014-04-14 10:37:35
6.8 更新141精选命令                                 2014-04-21 10:37:45
6.9 更新bash精解                                    2014-04-24 11:41:17
6.10更新git                                         2014-05-17 02:07:49
7.1 更新git                                         2014-07-01 23:52:04
7.2 更新git diff                                    2014-07-23 14:57:33
8.1 更新git cherry-pick                             2014-08-20 10:31:28
8.2 更新git log                                     2014-08-22 15:06:29
10.1更新git remote                                  2014-10-06 17:17:40
12.1更新shadowsocks                                 2014-12-31 15:05:22
13.1更新git clean                                   2015-01-13 14:15:36
13.2更新zsh                                         2015-02-06 10:53:32
13.3更新rename                                      2015-02-25 11:03:43
13.4更新ipython                                     2015-07-29 14:06:39
13.5更新Procedure                                   2015-07-31 16:19:25
13.6更新mysql perfermance                           2015-09-15 10:48:26
15.1更新shell file loop                             2015-10-25 12:11:11
15.2更新xfce4-notes                                 2015-11-10 11:15:08
15.3更新dmidecode,ipmitool                          2015-11-11 11:38:15
15.4更新mjson                                       2015-12-21 15:05:05
16.1更新format                                      2016-01-20 17:41:05