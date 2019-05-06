set nocompatible

set fileencoding=utf-8
set fencs=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

au BufWinLeave *.* silent! mkview
au BufWinEnter *.* silent! loadview
set history=500
set clipboard+=unnamed
filetype on
filetype plugin on
filetype indent on
syntax on
set  t_Co=256
color  molokai

set ruler
set nu
set laststatus=2
au InsertEnter * hi StatusLine  ctermbg=201
au InsertLeave * hi StatusLine ctermbg=4
set statusline=%f%([%{Tlist_Get_Tag_Prototype_By_Line()}]%)[Line:%l/%L,Column:%c][%p%%]
set statusline=%f[Line:%l/%L,Column:%c][%p%%]

set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
set viminfo+=!

"set backup
"set backupext=.bak
"set autowrite
set showmatch
set matchtime=5
"set ignorecase
set hlsearch
set incsearch

set formatoptions=tcrqn
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autochdir

"==========code zhedie========
set foldenable
set foldcolumn=2
set foldmethod=syntax
set foldlevel=10
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>

set tags+=~/.vim/tag/cpp
set tags+=~/svn/common/tags
set tags+=./tags
let Tlist_Process_File_Always = 1
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Close_On_Select = 0
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 25 

"let g:tagbar_ctags_bin = 'ctags'
"let g:tagbar_width = 50
"let g:tagbar_autoclose = 1
"let g:tagbar_compact = 1
"nmap <silent> <F3> :TagbarToggle<cr>
nmap <silent> <F3> :Tlist<cr>

let NERDTreeWinSize=25
nmap <silent> <F2> :NERDTreeToggle<cr>

map <F5> :w<cr>:make -j4<cr>
map <F6> :cn<cr>
map <F7> :cp<cr>
map <C-x> :cclose<cr>

let Grep_Default_Filelist = '*.cpp *.h *.hpp' 
let Grep_Default_Options = '-w'
let Grep_Skip_Files = '*.bak *~ *.orig tags GTAGS GRTAGS GPATH' 
nnoremap <silent> <F8>   :Grep <cr>
"nnoremap <silent> <F10>   :!locate <cword> <cr>
nnoremap <silent> <F10>   :!find /usr/local/include/ -name <cword>*  -type f <cr>
nnoremap <silent> <F12>  :w<cr> :A<cr>

"gtags
nmap <C-p> :Gtags<cr><cr>
nmap <C-\> :GtagsCursor<cr>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne=0

let g:BASH_AuthorName   = 'topsecret.reg'
let g:BASH_Email        = 'topsecret.reg@xunlei.com'
let g:BASH_Company      = 'XunLei Networking Tech'

let g:NeoComplCache_DisableAutoComplete = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:SuperTabDefaultCompletionType ='<C-X><C-U>'


"add highlighting for function definition in C++
function! EnhanceCppSyntax()
    syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
    hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()


"2010-10-12 from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set modelines=0
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap ; :
au FocusLost * :wa
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
inoremap jj <ESC>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>a :Ack

set cursorline
nnoremap <leader>c :set cursorline! cursorcolumn!<cr>


set hidden
set backspace=indent,eol,start
set nobackup
set noswapfile

autocmd BufNewFile,BufRead *.cpp set formatprg=astyle

"au InsertLeave * write

nmap er   :r ~/.vimxfer<cr>
nmap ew   :'a,.w! ~/.vimxfer<cr>
vmap er   c<esc>:r ~/.vimxfer<cr>
vmap ew   :w! ~/.vimxfer<cr>

" display indentation guides
"set list listchars=tab:>-,trail:-
"set list listchars=tab:>.,trail:.,extends:#,nbsp:.
set list listchars=tab:\|\ 
" " convert spaces to tabs when reading file
"autocmd! bufreadpost *.c,*.cpp,*.h set noexpandtab | retab! 4
" " convert tabs to spaces before writing file
"autocmd! bufwritepre *.c,*.cpp,*.h set expandtab | retab! 4
" " convert spaces to tabs after writing file (to show guides again)
"autocmd! bufwritepost *.c,*.cpp,*.h set noexpandtab | retab! 4

"set tw=80
"set columns=80

"nnoremap <leader>l :call<SID>LongLineHLToggle()<cr>
"hi OverLength ctermbg=none cterm=none
"match OverLength /\%>80v/
"fun! s:LongLineHLToggle()
"	if !exists('w:longlinehl')
"		let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
"		echo "Long lines highlighted"
"	else
"		call matchdelete(w:longlinehl)
"		unl w:longlinehl
"		echo "Long lines unhighlighted"
"	endif
"endfunction


" mru config
let MRU_Max_Entries = 1000
let MRU_Include_Files = '\.cpp$\|\.h$|\.c$'
let MRU_Window_Height = 10
let MRU_Add_Menu = 0
nmap <leader>u :MRU<cr>

" mark plugin
let g:mwAutoLoadMarks = 1 

" omnicppcomplete
set completeopt=menu

"set expandtab=off
"set noexpandtab 
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
