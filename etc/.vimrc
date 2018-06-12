let  mapleader=";"
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
"屏幕翻页
nnoremap wf <c-f>
nnoremap wb <c-b>
"光标跳转
nnoremap wi <c-i>
nnoremap wo <c-o>
"tag 返回
nnoremap wt <c-t>
"block visual 模式
nnoremap vv <c-v>

"j, insert mode 自动补全
"no work, n,p key word， x+opi omni compeletion
inoremap jn <c-n>
inoremap jp <c-p>
inoremap jf <c-x><c-f>
inoremap jo <c-x><c-o>
inoremap ji <c-x><c-i>
cnoremap jd <c-d>
 

"设置粘贴版
vnoremap wy "+y
nnoremap wp "+p

"设置保存，关闭
"nnoremap <leader>wq :wa<cr> :q<cr>
"nnoremap <leader>ww :wa<cr>
nnoremap wq :q<cr>
nnoremap ww :wa<cr>


"设置搜索
set incsearch
set hlsearch
set ignorecase

"关闭兼容
set nocompatible
"vim 命令行模式智能补全
set wildmenu wildmode=full
set wildchar=<TAB> wildcharm=<c-z>

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


" 精准替换
" " 替换函数。参数说明：
" " confirm：是否替换前逐一确认
" " wholeword：是否整词匹配
" " replace：被替换字符串

function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction

" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" " 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" " 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" " 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Repcace '.expand('<cword>').' with: '))<CR>

" 环境恢复
" " 设置环境保存项
set sessionoptions="blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
" " 保存 undo 历史。必须先行创建 .undo_history/
set undodir=~/.undo_history/
set undofile
" " 保存快捷键
"map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
map <leader>ss :mksession! my.vim<cr>
" " 恢复快捷键
"map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>
map <leader>rs :source my.vim<cr>

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" vundle setting
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

filetype  off
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
"tag列表插件
Plugin 'majutsushi/tagbar'
"tag 自动生成
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
"工程内搜索，需要安装ack
Plugin 'dyng/ctrlsf.vim'
"重复选取，替换
Plugin 'terryma/vim-multiple-cursors'
"快速注释
Plugin 'scrooloose/nerdcommenter'
"模板补全
Plugin 'SirVer/ultisnips'
"自动补全
Plugin 'Valloric/YouCompleteMe'
"工程列表
Plugin 'scrooloose/nerdtree'
"buffer 显示
Plugin 'fholgado/minibufexpl.vim'
"快速选结对符
Plugin 'gcmt/wildfire.vim'
"显示undo
Plugin 'sjl/gundo.vim'
"快速移动
Plugin 'Lokaltog/vim-easymotion'
"模糊查找文件.buffer,tags
Plugin 'Yggdroot/LeaderF'


" 插件列表结束
call vundle#end()
filetype plugin indent on

""设置配色主题
set background=dark
"set background=light
"colorscheme solarized
colorscheme molokai
let g:Powerline_colorscheme='solarized256'

""缩进可视化配置，vim 自启动, 第二层可视化显示缩进, 色块宽度1,快捷键 wi 开/关缩进可视化
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nnoremap <silent> wi <Plug>IndentGuidesToggle

""标签可视化 配置
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


""tag 列表插件设置
"设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
"设置显示／隐藏标签列表子窗口的快捷键。速记：tag list`
nnoremap <Leader>tl :TagbarToggle<CR> 
" " 设置标签子窗口的宽度 
let tagbar_width=32 
" " tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
     \ 'ctagstype' : 'c++',
     \ 'kinds'     : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

"" 代码导航
 
" 基于标签的代码导航
" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q" 
" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

" 基于语义的代码导航
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

"" 查找
"" 使用 ctrlsf.vim
" 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :CtrlSF<C

"" 内容替换
"" 快捷替换
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_skip_key='<S-k>'

" 模板补全
" " UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"


" " YCM 补全
" " YCM 补全菜单配色
" " 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" " 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" " 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" " 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=0
" "" 引入 C++ 标准库 tags
" "set tags+=/data/misc/software/app/vim/stdcpp.tags
" "set tags+=/data/misc/software/app/vim/sys.tags
" " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap jo <c-x><c-o>
" " 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" " 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" " 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" " 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" " 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" " 显示隐藏文件
let NERDTreeShowHidden=1
" " NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" " 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


" 显示/隐藏 MiniBufExplorer 窗口 buffer list
map <Leader>bl :MBEToggle<cr>
" " buffer 切换快捷键
map <leader>bn :MBEbn<cr>
map <leader>bp :MBEbp<cr>

" 快速选中结对符内的文本
"  " 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)
"  " 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

"  " 调用 gundo 树
nnoremap <Leader>u :GundoToggle<CR>

""LeaderF setting
nnoremap <leader>fj :LeaderfFile<cr>
nnoremap <leader>fp :LeaderfFilePattern<cr>
nnoremap <leader>fc :LeaderfFileCword<cr>
nnoremap <leader>fbb :LeaderfBuffer<cr>
nnoremap <leader>fbp :LeaderfBufferPattern<cr>
nnoremap <leader>fbt :LeaderfTabBuffer<cr>
nnoremap <leader>fba :LeaderfBufferAll<cr>
nnoremap <leader>fbc :LeaderfBufferCword<cr>
nnoremap <leader>ftt :LeaderfTag<cr>
nnoremap <leader>ftp :LeaderfTagPattern<cr>
nnoremap <leader>ftc :LeaderfTagCword<cr>
nnoremap <leader>ftb :LeaderfBufTag<cr>
nnoremap <leader>fta :LeaderfBufTagAll<cr>
nnoremap <leader>fto :LeaderfBufTagPattern <cr>
nnoremap <leader>fmm :LeaderfMru<cr>
nnoremap <leader>fmd :LeaderfMruCwd<cr>
nnoremap <leader>fmp :LeaderfMruPattern<cr>
nnoremap <leader>fmc :LeaderfMruCword<cr>
nnoremap <leader>fmo :LeaderfMruCwdPattern<cr>
nnoremap <leader>fff :LeaderfFunction<cr>
nnoremap <leader>ffa :LeaderfFunctionAll<cr>
nnoremap <leader>ffp :LeaderfFunctionPattern<cr>
nnoremap <leader>ffc :LeaderfFunctionCword<cr>
nnoremap <leader>ffo :LeaderfFunctionAllPattern<cr>


"语法高亮，指定语法高亮方案覆盖默认方案
syntax enable
syntax on

