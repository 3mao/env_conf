execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible "不兼容vi
syntax on
set nu
set cursorline
set backspace=indent,eol,start

"|:help encoding-values|列出Vim支持的所有编码。 
set fenc=chinese
"encoding（enc）：encoding是Vim的内部使用编码，
"encoding的设置会影响Vim内部的Buffer、消息文字等。
"在Unix环境下，encoding的默认设置等于locale；
"Windows环境下会和当前代码页相同。在中文Windows环境下encoding的默认设置是cp936（GBK）。 
set encoding=utf-8
" fileencodings（fencs）：Vim在打开文件时会根据fileencodings选项来识别文件编码，
" fileencodings可以同时设置多个编码，Vim会根据设置的顺序来猜测所打开文件的编码。 
set fileencodings=utf-8,gb2312,gbk,gb18030
"Vim在保存新建文件时会根据fileencoding的设置编码来保存。如果是打开已有文件，
"Vim会根据打开文件时所识别的编码来保存，除非在保存时重新设置fileencoding。 
set fileencoding=utf-8
"termencoding（tenc）：在终端环境下使用Vim时，通过termencoding项来告诉Vim终端所使用的编码,注意与crt,putty等设置编码的一致。 
set  termencoding=utf-8

colorscheme darkblue
set helplang=en

"use 4 space for indent,for python
setlocal et sta sw=4 sts=4
" et  expandtab,将tab键展开成空格
" sta  smartab,在行首按TAB将加入sw个空格
" sw  shiftwidth,自动缩进插入的空格数
" sts  softabstop,使用或自动插入或删除相应的空格数

filetype plugin indent on

"ctags --c++-kinds=+p --fields=+iaS --extra=+q -R
"! ctags  -R --c++-kinds=+p  --fields=+iaS --extra=+q  . 
map <F11> :!ctags -R --c-kinds=+plx --fields=+lSK --extra=+f -f tags . ; cscope –Rkbq  .  <CR><CR>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . ; cscope –Rkbq  .    <CR><CR>

set tags+=tags;
set tags+=./tags
set autochdir  
"tags用法
"
"[{ 转到上一个｛
"}]转到下一个}
"{转到上一个空行
"｝转到下一个空行
"gd转到光标所指的局部定义
"* 转到光标所指的单词下一次出现的地方
"#转到光标所指单词的上一个村出现的地方


"全能插件要通过执行这个ctags命令才可以用、且要求ctags>=5.6
set completeopt=longest,menu
 let OmniCpp_MayCompleteDot=1    "  打开  . 操作符
 let OmniCpp_MayCompleteArrow=1  "打开 -> 操作符
 let OmniCpp_MayCompleteScope=1  "打开 :: 操作符
 let OmniCpp_NamespaceSearch=1   "打开命名空间
 let OmniCpp_GlobalScopeSearch=1  
 let OmniCpp_DefaultNamespace=["std"]  
 let OmniCpp_ShowPrototypeInAbbr=1  "打开显示函数原型
 let OmniCpp_SelectFirstItem = 2 "自动弹出时自动跳至第一个

let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"NERDTree默认没有打开，必须手动激活
map <F8> :NERDTree <CR><CR>
map <F9> :NERDTreeClose <CR><CR>

""""""""""""""""""""""""""""""
" BufExplorer
" """"""""""""""""""""""""""""""
 let g:bufExplorerDefaultHelp=0       " Do not show default help.
 let g:bufExplorerShowRelativePath=1  " Show relative paths.
 let g:bufExplorerSortBy='mru'        " Sort by most recently used.
 let g:bufExplorerSplitRight=0        " Split left.
 let g:bufExplorerSplitVertical=1     " Split vertically.
 let g:bufExplorerSplitVertSize = 30  " Split width
 let g:bufExplorerUseCurrentWindow=1  " Open in new window.
 autocmd BufWinEnter \[Buf\ List\] setl nonumber 

"TlistToggle
 map <F3> :TlistToggle <CR><CR>
 " map <F4> :TlistClose <CR><CR>


"cscope
"http://blog.csdn.net/dengxiayehu/article/details/6330200
"cs add /usr/src/linux/cscope.out  导入数据库
"cs find c|d|e|g|f|i|s|t name
"s：查找C代码符号
"g：查找本定义
"d：查找本函数调用的函数
"c：查找调用本函数的函数
"t：查找本字符串
"e：查找本egrep模式
"f：查找本文件
"i：查找包含本文件的文件
"可以在.vimrc中添加下面的快捷键，免得每次都要输入一长串命令。
"
"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>f :cs find f <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>i :cs find i ^<C-R>=expand("<cword>")<CR>$<CR>
"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"
"　　使用时，将光标停留在要查找的对象上，按下<C-@>g，即先按“Ctrl+@”，然后很快再按“g”，将会查找该对象的定义。
"
"if filereadable("cscope.out")
"     cs add cscope.out
"elseif $CSCOPE_DB != ""
"      cs add $CSCOPE_DB
"endif


"pydiction_location

let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict' 
let g:pydiction_menu_height = 3 
if has("autocmd") 
    autocmd FileType python set complete+=k/path/to/pydiction iskeyword+=.,( 
endif " has("autocmd") 


au BufRead *.py map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python'
        :! python ./%
    else
        :! ./%
    endif
endfunc

"启用python_fold的折叠功能
"zo: 打开光标位置的折叠代码
"zc: 折叠光标位置的代码
"zr: 将文件中所有折叠的代码打开
"zm: 将文件中所有打开的代码折叠
"zR: 作用和 zr 类似，但会打开子折叠(折叠中的折叠)
"zM: 作用和 zm 类似，但会关闭子折叠
"zi: 折叠与打开操作之间的切换命令
set foldmethod=indent
