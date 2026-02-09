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
    hi        CursorColumn   ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "光标所在的屏幕列
    hi        CursorLine     ctermfg=black            ctermbg=lightgreen        cterm=NONE        "光标所在的屏幕行
    hi        CursorLineNr   ctermfg=white            ctermfg=red               cterm=BOLD        "光标所在的行号
    hi        ColorColumn    ctermfg=lightgrey        ctermbg=white             cterm=BOLD        "高亮光标所在列.
    hi        Directory      ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "目录名
    hi        DiffAdd        ctermfg=grey             ctermbg=lightblue         cterm=BOLD        "diff: 增加的行
    hi        DiffChange     ctermfg=darkgrey         ctermbg=lightcyan         cterm=BOLD        "diff: 改变的行
    hi        DiffDelete     ctermfg=grey             ctermbg=lightred          cterm=BOLD        "diff: 删除的行
    hi        DiffText       ctermfg=red              ctermbg=black             cterm=BOLD        "diff: 改变行里的改动文本
    hi        ErrorMsg       ctermfg=darkcyan         ctermbg=black             cterm=BOLD        "命令行上的错误信息
    hi        VertSplit      ctermfg=darkcyan         ctermbg=lightblue         cterm=BOLD        "分离垂直分割窗口的列
    hi        Folded         ctermfg=lightgrey        ctermbg=darkgreen         cterm=BOLD        "用于关闭的折叠的行
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
    hi        CursorColumn   ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "光标所在的屏幕列
    hi        CursorLine     ctermfg=black            ctermbg=lightgreen        cterm=NONE        "光标所在的屏幕行
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
