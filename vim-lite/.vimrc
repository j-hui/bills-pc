" vim: set ts=4 sw=4 tw=80 et :

""""""""""""""""""""""
" j-hui VIM Settings "
""""""""""""""""""""""

"""""""""
" Notes "
"""""""""
"
" Default key bindings that just aren't very useful:
"
" s/S (substitute): delete character/line; insert mode
"   - I can just x/dd i
"
" c/C (change): like d/D, except it drops you into insert mode
"   - I can just d/D i
"
" & : repeat :s
"   - ???
"
" f/F (find): f/F<char> jumps to next/previous occurrence of <char>
"   - actually handy, but I already have easymotion to help me move around
"
" t/T (till): t/T<char> jumps to before next/previous occurence of <char>
"   - actually handy, but I already have easymotion to help me move around
"
" ; : repeat f/F/t/T
"   - I don't use f/F/t/T
"
" 0/_ (beginning of line): go to hard/soft beginning of line
"   - I already map <c-h> for exactly this
"   - I also have ^ even if it's a little hard to reach
"   + Note: I've remapped _ to D
"
" ^/$ (beginning/end of line): go there
"   - just too far out of reach
"   - I already map <c-h>/<c-l> for exactly this
"
" + (next line): go to next line
"   - just use j
"
" W/E/B (next/end/back WORD): seems to be just like w/e/b
"   - what even is WORD (vs word)
"
" Q (ex mode): go to ex mode
"   - ok but who the fuck uses this
"
""""
"
" Key bindings I should actually use, but require too much thinking
"
" q/@ (record/play macro): q/@<char> records/plays macro at <char>
"
" . (repeat): a little unpredictable imo
"
""""
"
" Key bindings I should actually use, but don't have muscle memory
"
" #/* (prev/next identifier): goto prev/next occurence of token under cursor
"   - too far out of reach
"
" {/} (beginning/end of paragraph): go there
"   - too far out of reach
"
""""


"""""""""""""
" Basic stuff
"""""""""""""
" execute pathogen#infect()
call plug#begin('~/.vimplugins/plugged')

" set lazyredraw
filetype plugin indent on

setlocal spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add


""""""""""""
" Appearance
""""""""""""
syntax enable
colorscheme ron
set background=dark

set noeb vb t_vb=

set nu
set rnu
set ruler
set scrolloff=5
set display+=lastline

" highlight 80-character boundary
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" cursor underline in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

"" If terminal supports displaying italics, we need these key sequences
"let t_ZH="\e[3m"
"let t_ZR="\e[23m"
"
"" Otherwise, we just unugly the italics highlighting
"highlight htmlItalic
"            \ term=standout
"            \ ctermfg=121
"            \ guifg=Green
"highlight htmlBoldItalic
"            \ term=bold,standout
"            \ cterm=bold ctermfg=121
"            \ gui=bold guifg=Green
"highlight htmlUnderlineItalic
"            \ term=underline,standout
"            \ cterm=underline ctermfg=121
"            \ gui=underline guifg=Green
"highlight htmlBoldUnderlineItalic
"            \ term=underline,bold,standout
"            \ cterm=underline,bold ctermfg=121
"            \ gui=underline,bold guifg=Green

set modeline
set modelines=5
function! PrependModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("^"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call PrependModeline()<CR>

"Plug 'vim-airline/vim-airline'
"set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1

" Plug 'Yggdroot/indentLine'
" let g:indentLine_setConceal = 0
" let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_leadingSpaceEnabled = 1
" set conceallevel=2

set list lcs=tab:\┆\ " <-- space

""""""""""""
" Navigation
""""""""""""
" Movement
nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
nnoremap <C-l> g$
nnoremap <C-h> g^
nnoremap <C-i> <down><C-e>
nnoremap <C-o> <up><C-y>
nnoremap <C-s> :w<CR>

inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-c> <Esc>
inoremap kj <Esc>

inoremap <C-s> <Esc>
vnoremap <C-s> <Esc>
onoremap <C-s> <Esc>

cnoreabbrev Q q " for when i fat finger :Q

set pastetoggle=<F2>
set clipboard+=unnamed

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set hlsearch    " highlight search
set incsearch   " incremental search
set ignorecase  " ignores case
set smartcase   " smart case
set showmatch   " Show matching brackets

set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set wildmenu

set autoread

noremap <C-w>] <Esc>:bn<CR>
noremap <C-w>[ <Esc>:bp<CR>
noremap <C-w><backspace> <Esc>:bw<CR>
noremap <C-w>t :enew<cr>

" Plug 'psliwka/vim-smoothie'
" let g:smoothie_base_speed = 36
" nnoremap <silent> <C-j>      :<C-U>call smoothie#downwards() <CR>
" nnoremap <silent> <C-k>      :<C-U>call smoothie#upwards()   <CR>

Plug 'tpope/vim-repeat'

" Plug 'farmergreg/vim-lastplace'
" let g:lastplace_open_folds = 0

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <C-f>l <Plug>(easymotion-lineforward)
map <C-f>j <Plug>(easymotion-j)
map <C-f>k <Plug>(easymotion-k)
map <C-f>h <Plug>(easymotion-linebackward)
map <C-f>w <Plug>(easymotion-w)
map <C-f>e <Plug>(easymotion-e)
map  <C-f>/ <Plug>(easymotion-sn)
omap <C-f>/ <Plug>(easymotion-tn)
map  <C-f>n <Plug>(easymotion-next)
map  <C-f>N <Plug>(easymotion-prev)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Plug 'scrooloose/nerdtree'
" noremap <C-n> :NERDTreeToggle<CR>

" Open NERDTree upon startup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree when opening a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
"             \ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene |
"             \ exe 'cd '.argv()[0] | endif
" 
" " Close vim if NERDTree the only window left
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
"             \ b:NERDTree.isTabTree()) | q | endif
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_map_keys = 0
" nmap <c-g><c-g> <Plug>GitGutterPreviewHunk
" nmap <c-g>g     <Plug>GitGutterPreviewHunk
" nmap <c-g>n     <Plug>GitGutterNextHunk
" nmap <c-g>p     <Plug>GitGutterPrevHunk
" set updatetime=100
" let g:gitgutter_override_sign_column_highlight = 0
" highlight SignColumn        guibg=#073642 ctermbg=0
" highlight GitGutterAdd      guibg=#073642 ctermbg=0 guifg=#009900 ctermfg=2
" highlight GitGutterChange   guibg=#073642 ctermbg=0 guifg=#bbbb00 ctermfg=3
" highlight GitGutterDelete   guibg=#073642 ctermbg=0 guifg=#ff2222 ctermfg=1

" Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'
" nnoremap <c-g>vb :GV
" nnoremap <c-g>vc :GV!
" nnoremap <c-g>vf :GV?

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :Files<CR>

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap K :Ack! "\b<C-R><C-W>\b" % <CR>

nnoremap <Leader>ag :Ack!<Space>
inoremap <Leader>ag <Esc>:Ack!<Space>
vnoremap <Leader>ag <Esc>:Ack!<Space>

nnoremap <Leader>aa :AckAdd!<Space>
inoremap <Leader>aa <Esc>:AckAdd!<Space>
vnoremap <Leader>aa <Esc>:AckAdd!<Space>

""""""""""""""
" Text editing
""""""""""""""
" Whitespace rules w/ linebreak on 80 characters
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab

set smartindent
set autoindent

" Linebreak on 80 characters
set lbr
set textwidth=80
set wrap

set nojoinspaces

function TrimTrailing()
    substitute/ *$//g
endfunction
cnoreabbrev tt call TrimTrailing()

" Deliberately avoid using /tmp/ to avoid leaking data on shared computer
"
" To allow backup files to be stored locally, run:
"
"       mkdir -p .backup .swp .undo
"
" To enable backups to be stashed centrally, put the following in .bashrc
"
"       mkdir -p ~/.tmp/backup ~/.tmp/swp ~/.tmp/undo
"
" Fallback to using current directory . if all else fails
"
" Also, put the following in global .gitignore
"
"       *~
"       *.swp
"
set backup
set backupdir=.backup,~/.tmp/backup//,.

set swapfile
set directory=.swp,~/.tmp/swp//,.

set undofile
set undodir=.undo,~/.tmp/undo//,.
set undolevels=1000
if has('persistent_undo')
    set undofile
    set undoreload=10000
endif

Plug 'svermeulen/vim-cutlass'
" - retain cut behavior for d specifically
" - x and D no longer put text into registers
" - to delete lines without cutting, use D and visual mode 
nnoremap d d
xnoremap d d
vnoremap d d
nnoremap dd dd

Plug 'tpope/vim-commentary'         " use gcc to comment things out
Plug 'tpope/vim-surround'           " ds, cs, ys to change text surroundings
Plug 'tpope/vim-rsi'                " readline style commands in insert mode
Plug 'tpope/vim-characterize'       " use ga to see metadata about unicode
Plug 'tpope/vim-eunuch'             " UNIX-like functionality in Vim
" Plug 'junegunn/vim-peekaboo'        " shows yank buffers

"""""""
" LaTeX
"""""""
autocmd Filetype tex setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2
            \ textwidth=80
            \ spell

autocmd Filetype tex highlight Conceal ctermfg=NONE ctermbg=NONE
" otherwise rendered symbols render with a weird grey background color

Plug 'lervag/vimtex',   { 'for': 'tex' }
let g:tex_flavor='latex'
" let g:vimtex_view_method='open'
" let g:vimtex_compiler_enabled = 0
" let g:vimtex_quickfix_open_on_warning=0
" let g:vimtex_quickfix_autoclose_after_keystrokes=2
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
        \ 'default' : 0,
      \ },
      \}

let g:tex_conceal='abdmg'
let g:Tex_GotoError=0

let g:vimtex_mappings_enabled=0
autocmd Filetype tex imap <C-]> <plug>(vimtex-delim-close)

""""""""""
" Markdown
""""""""""
autocmd Filetype markdown setlocal
            \ tabstop=4
            \ expandtab
            \ shiftwidth=4
            \ softtabstop=4
            \ textwidth=80
            \ spell

Plug 'tpope/vim-markdown',  { 'for': 'markdown' }

let g:markdown_fenced_languages = [
            \ 'html',
            \ 'python',
            \ 'bash=sh',
            \ 'c',
            \ 'cpp',
            \ 'ocaml',
            \ 'haskell'
            \ ]


"""
" C
"""
autocmd BufNewFile,BufReadPost *.c set filetype=c
autocmd BufNewFile,BufReadPost *.h set filetype=c
autocmd FileType c setlocal
            \ tabstop=8
            \ noexpandtab
            \ shiftwidth=8
            \ softtabstop=8

""""""""""
" Makefile
""""""""""
autocmd FileType make setlocal noexpandtab

"""""""
" OCaml
"""""""
autocmd Filetype ocaml setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2
            \ commentstring=(*%s*)

"""""""""
" Haskell
"""""""""
autocmd Filetype haskell setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2

""""""
" YAML
""""""
autocmd Filetype yaml setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2

""""
" Go
""""
autocmd Filetype go setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2
Plug 'fatih/vim-go',    { 'for': 'go' } "{ 'do': ':GoUpdateBinaries' }

"""""
" Bib
"""""
autocmd Filetype bib setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2

"""""
" Coq
"""""
autocmd BufNewFile,BufReadPost *.v set filetype=coq
autocmd Filetype coq setlocal
            \ tabstop=2
            \ expandtab
            \ shiftwidth=2
            \ softtabstop=2
            \ commentstring=(*%s*)
            \ formatoptions=cqort
            \ comments=sr:(*,mb:*,ex:*)

" Plug 'tounaishouta/coq.vim', { 'for': 'coq' }
" autocmd Filetype coq nnoremap <buffer> <c-p> :CoqRunToCursor<CR>
" autocmd Filetype coq inoremap <buffer> <c-p> <Esc>:CoqRunToCursor<CR>

Plug 'let-def/vimbufsync', { 'for': 'coq' }
Plug 'whonore/coqtail', { 'for': 'coq' }

autocmd Filetype coq nnoremap <buffer> <c-c><enter>          :CoqToLine<CR>
autocmd Filetype coq inoremap <buffer> <c-c><enter>     <Esc>:CoqToLine<CR>

""""""""""""""
" Scratch Area
""""""""""""""
" Plugins I haven't decided I want to use yet
"""""""""""""""""""""""""""""""""""""""""""""

" Plug 'reedes/vim-wordy'
"   https://github.com/reedes/vim-wordy
"
" Plug 'tpope/vim-abolish'
"   https://github.com/tpope/vim-abolish
" Plug 'jdelkins/vim-correction'
"   https://github.com/jdelkins/vim-correction
" Plug 'reedes/vim-litecorrect'
"   https://github.com/reedes/vim-litecorrect
"
" Plug 'andymass/vim-matchup'
"   https://github.com/andymass/vim-matchup

Plug 'al3623/deepsea.vim'

"""""""
" Idris
"""""""

Plug 'idris-hackers/idris-vim', { 'for': 'idris' }

call plug#end()
