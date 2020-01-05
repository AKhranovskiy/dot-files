"""""""""""""""""""""""
" Basic Configuration "
"""""""""""""""""""""""

""" Leader Shortcuts
"
let mapleader=","   " leader is comma
inoremap jk <esc>   " jk is escape

""" Spaces & Tabs
"
set expandtab     " No tabs
set shiftwidth=2  " Number of spaces for indent
set softtabstop=2 " number of spaces in tab when editing
set tabstop=2     " number of visual spaces per TAB
"" White spaces
set listchars=tab:»·,trail:·
set list          " Show whitespace as special chars - see listchars

""" Spelling
"
set spell spelllang=en_us
set encoding=utf8 " UTF-8 by default

""" Indentation
"
set autoindent    " Carry over indenting from previous line
set cindent       " Automatic program indenting
set copyindent    " Make autoindent use the same chars as prev line

""" UI config
"
filetype indent on  " load filetype-specific indent files
set cursorline      " highlight current line
set lazyredraw      " redraw only when we need to
set number          " show line numbers
set showmatch       " highlight matching [{()}]
set wildmenu        " visual autocomplete for command menu
set textwidth=120
set colorcolumn=120
set scrolloff=9999  " Keep working line in the center

""" Search
"
set hlsearch   " highlight matches
set incsearch  " search as characters are entered
"" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

""" Folding
"
set foldenable          " enable folding
set foldlevelstart=10   " open third level fold by default
set foldmethod=syntax
set foldnestmax=10      " 10 nested fold max
"" space open/closes folds
nnoremap <space> za

""" Movement
"
"" move vertically by visual line
nnoremap j gj
nnoremap k gk
"" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

set nostartofline  " Do not jump to first column in vertical selection

""" Directories
"
set directory-=.  " Don't store temp files in cwd
"" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
set undodir=/tmp//,.

"""""""""""""""
""" Hotkeys """
"""""""""""""""
map <F2> :w<CR>

""" Buffers
map <C-l> :ls<CR>       " List buffers
map <C-q> :bd %<CR>     " Close current buffer

""""""""""""""""""""
""" File configs """
""""""""""""""""""""
"
""" Markdown
autocmd BufRead,BufNewFile *.md
      \ setlocal autoindent expandtab filetype=markdown
      \ textwidth=100 wrap formatoptions=tcqn
""" AsciiDoc
autocmd BufRead,BufNewFile *.adoc
      \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
      \ textwidth=100 wrap formatoptions=tcqn
      \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
      \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
""" CMakeAddon syntax
autocmd BufNewFile,BufRead CMakeAddon.txt set syntax=cmake

""""""""""""""""""""""""""""""
""" Packet manager :: DEIN """
""""""""""""""""""""""""""""""

""" HACK for vim-fish
if &shell =~# 'fish$'
    set shell=sh
  endif

if &compatible
  set nocompatible " Be improved
endif

" Required:
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.dein')
  call dein#begin('~/.dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim') " Completion engine

  " Language Server
  call dein#add('neoclide/coc.nvim', {'merge':0, 'rev': 'release'})

  call dein#add('zchee/deoplete-clang') " clang-driven completion for C++
  call dein#add('rhysd/vim-clang-format')
  call dein#add('octol/vim-cpp-enhanced-highlight')

  call dein#add('mrk21/yaml-vim')

  call dein#add('rust-lang/rust.vim')
  call dein#add('alaviss/nim.nvim')

  call dein#add('peterhoeg/vim-qml')
  call dein#add('dag/vim-fish')
  call dein#add('pboettch/vim-cmake-syntax')
  call dein#add('toml-lang/toml')

  "call dein#add('python-mode/python-mode')
  call dein#add('ambv/black')
  call dein#add('zchee/deoplete-jedi')

  call dein#add('fenetikm/falcon')

  call dein#add('/usr/local/opt/fzf') " Fuzzy finder
  call dein#add('junegunn/fzf.vim')

  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/nerdcommenter')

  call dein#add('tpope/vim-vinegar') " Extend file browsing

  call dein#add('airblade/vim-gitgutter')
  call dein#add('MattesGroeger/vim-bookmarks')
  call dein#add('tpope/vim-fugitive')

  call dein#add('wakatime/vim-wakatime')

  call dein#add('easymotion/vim-easymotion')
  call dein#add('itchyny/lightline.vim')

  " Required:
  call dein#end()

  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"
""" End dein Scripts """
""""""""""""""""""""""""

"""""""""""""""""""""""""""""
""" Fugitive              """
"""""""""""""""""""""""""""""

map <F3> :Gstatus<CR>

""" Plugins configuration """
"""""""""""""""""""""""""""""

autocmd BufWritePre *.py execute ':Black'
let g:black_linelength = 120

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1

""" Deoplete """
"
let g:deoplete#enable_at_startup = 1

""" C++
let g:deoplete#sources#clang#libclang_path='/usr/local/opt/llvm/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/usr/local/opt/llvm/lib/clang/9.0.0/include'
let g:deoplete#sources#clang#std={'cpp':'c++20'}
let g:deoplete#sources#clang#flags = [
      \ "-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
      \ ]

""" Scala
let g:deoplete#sources={} 
let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips'] 
let g:deoplete#omni#input_patterns={} 

""""""""""""""""""""""""""""""
"""     Language Server    """
""""""""""""""""""""""""""""""
set hidden

""" Color scheme """
set termguicolors
set background=dark
colorscheme falcon

"""""""""""""""""""""
""" C++ Highlight """
"""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""" FZF """
"
nmap <Leader>ft :Tags<CR>
nmap <Leader>fbt :BTags<CR>
nmap <C-p> :Files<CR>
nmap <F8> :Buffers<CR>

""" clang format """
"
let g:clang_format#command = "clang-format"
let g:clang_format#style_options = {
      \ "ColumnLimit" : 120,
      \ "Standard" : "Latest"
      \}
let g:clang_format#auto_format_on_insert_leave = 0

"autocmd FileType c,cpp ClangFormatAutoEnable

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
"nmap <Leader>C :ClangFormatAutoToggle<CR>

"""" SCALA
" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+

" Configuration for coc.nvim

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""" NERD """
"
" Close NERD if it last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F5> :NERDTreeToggle<CR>
map <F4> :NERDTreeFind<CR>


"""" YAML """
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" Put these lines at the very end of your vimrc file.
"
""" Load all plugins now.
""" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
""" Load all of the helptags now, after plugins have been loaded.
""" All messages and errors will be ignored.
silent! helptags ALL
