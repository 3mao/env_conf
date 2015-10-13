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
"map <F8>:NERDTree<cr>
"map <F9>:NERDTreeClose<cr>

""""""""""""""""""""""""""""""
" BufExplorer
" """"""""""""""""""""""""""""""
" let g:bufExplorerDefaultHelp=0       " Do not show default help.
" let g:bufExplorerShowRelativePath=1  " Show relative paths.
" let g:bufExplorerSortBy='mru'        " Sort by most recently used.
" let g:bufExplorerSplitRight=0        " Split left.
" let g:bufExplorerSplitVertical=1     " Split vertically.
" let g:bufExplorerSplitVertSize = 30  " Split width
" let g:bufExplorerUseCurrentWindow=1  " Open in new window.
" autocmd BufWinEnter \[Buf\ List\] setl nonumber 
