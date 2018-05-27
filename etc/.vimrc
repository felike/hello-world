"let  mapleader="\<SPACE>"
"in normal mode, using w, and in insert mode using j
imap jj  <esc>
cmap jj  <esc><esc>
vmap jj  <esc>
omap jj  <esc>

"设置行首 行尾
nnoremap wa 0
nnoremap we $

"设置窗口跳转
nnoremap wn <c-W><c-W>
nnoremap wl <C-W>l
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-W>k
"设置窗口分割，关闭
nnoremap ws <C-w>s
nnoremap wv <C-w>v
nnoremap wc <C-w>c
nnoremap w= <c-w>=

"其他ctrl 配置
nnoremap wf <c-f>
nnoremap wb <c-b>
nnoremap vv <c-v>

"j, insert mode 自动补全
inoremap jn <c-n> 
inoremap jp <c-p>
inoremap jx <c-x>
inoremap jf <c-f>
cnoremap jd <c-d>
"设置粘贴版
vnoremap wy "+y
nnoremap wp "+p

"设置搜索
set incsearch
set hlsearch
set ignorecase

"关闭兼容
set nocompatible
"vim 命令行模式智能补全
set wildmenu

"显示状态栏，行号，光标位置
set laststatus=2
set number
set ruler
"高亮当前行列
"set cursorcolumn
set cursorline

"禁止光标闪烁
set gcr=a:block-blinkon0
"禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
"禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
"禁止折行
set nowrap

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

"基于缩进或语法进行折叠，启动时不折叠，za当前折叠，zM，zR打开关闭所有折叠
"set foldmethod=indent
set foldmethod=syntax
set nofoldenable

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" vundle setting
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

filetype  off
set 
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"主题
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
"状态栏
Plugin 'Lokaltog/vim-powerline'
"cpp 高亮
"Plugin 'octol/vim-cpp-enhanced-highlight'
"缩进对齐显示
Plugin 'nathanaelkane/vim-indent-guides'
"中文支持，命令模式自动切回英文
Plugin 'lilydjwg/fcitx.vim'
"标签可视化
Plugin 'kshenoy/vim-signature'

" 插件列表结束
call vundle#end()
filetype plugin indent on

"设置配色主题
set background=dark
"set background=light
"colorscheme solarized
"let g:Powerlin_colorscheme='solarized256'
colorscheme molokai
let g:Powerline_colorscheme='molokai'

"缩进可视化配置，vim 自启动, 第二层可视化显示缩进, 色块宽度1,快捷键 wi 开/关缩进可视化
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nnoremap <silent> wi <Plug>IndentGuidesToggle

"标签可视化 配置
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

"语法高亮，指定语法高亮方案覆盖默认方案
syntax enable
syntax on
