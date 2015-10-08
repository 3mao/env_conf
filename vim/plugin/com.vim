set nocompatible "不兼容vi
syntax on
set nu
set cursorline
set backspace=indent,eol,start

set fenc=chinese
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030

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
