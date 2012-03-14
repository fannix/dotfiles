call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=300

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""
"=> Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ %Y\ \ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %p%%\ %{fugitive#statusline()}

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <space> <C-F>
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" split window
map <leader>wn :split<cr>
map <leader>wv :vsplit<cr>
map <leader>wc :close<cr>
map <leader>wo <C-W>o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pydiction_location = '~/.vim/ftplugin/pydiction-1.2/complete-dict'
let g:pyflakes_use_quickfix = 0
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
highlight SpellBad ctermbg=3
nmap <leader>a <ESC>:Ack!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => R
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"for vim-r
let g:vimrplugin_screenplugin = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => latex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"for latex suite
set grepprg=grep\ -nH\$*
let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode -synctex=1 $*'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf = 'open -a Preview.app'
let g:Tex_ViewRule_pdf = 'Skim'
":imap <C-I> <Plug>Tex_InsertItemOnThisLine
au FileType tex :setlocal spell spelllang=en_us
imap <C-b> <Plug>Tex_MathBF
imap <C-h> <Plug>Tex_MathCal
imap <C-t> <Plug>Tex_InsertItemOnThisLine

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set nu
set fileencodings=utf8,gb18030
set hidden
set nocompatible
set visualbell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fuzzyfinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fuf_modesDisable = [ 'mrucmd', 'mrufile']
map <leader>fe :FufFile<cr>
map <leader>be :FufBuffer<cr>
map <leader>me :FufMruFile<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Personalization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme solarized

let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds'     : [
            \ 's:sections',
            \ 'g:graphics',
            \ 'l:labels',
            \ 'r:refs:1',
            \ 'p:pagerefs:1'
            \ ],
            \ 'sort'    : 0,
            \ }
