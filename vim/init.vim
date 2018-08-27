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
" set cursorline      " highlight current line
set lazyredraw      " redraw only when we need to
set number          " show line numbers
set showmatch       " highlight matching [{()}]
set wildmenu        " visual autocomplete for command menu
set textwidth=100
set colorcolumn=100
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
"
""" Buffers
map <C-l> :ls<CR>       " List buffers
map <C-q> :bd %<CR>     " Close current buffer
""" Reformatting
nnoremap <Leader>r gq}  " Reformat paragraphs and list


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

  call dein#add('zchee/deoplete-clang') " clang-driven completion for C++
  call dein#add('rhysd/vim-clang-format')
  call dein#add('octol/vim-cpp-enhanced-highlight')

  call dein#add('peterhoeg/vim-qml')
  call dein#add('dag/vim-fish')

  call dein#add('morhetz/gruvbox') "Color scheme: gruvbox

  call dein#add('/home/khranovs/.fzf') " Fuzzy finder
  call dein#add('junegunn/fzf.vim')

  call dein#add('scrooloose/nerdtree')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('MattesGroeger/vim-bookmarks')

  call dein#add('wakatime/vim-wakatime')

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
""" Plugins configuration """
"""""""""""""""""""""""""""""

""" Deoplete """
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-5.0/lib/libclang-5.0.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-5.0/lib/clang/5.0.0/include/'
let g:deoplete#sources#clang#std={'cpp':'c++17'}
" let g:deoplete#sources#clang#flags = [
"       \ "-cc1",
"       \ "-triple", "x86_64-apple-macosx10.13.0",
"       \ "-discard-value-names",
"       \ "-mrelocation-model", "pic", "-pic-level", "2",
"       \ "-mthread-model", "posix",
"       \ "-dwarf-column-info",
"       \ "-debugger-tuning=lldb",
"       \ "-resource-dir", "/usr/local/Cellar/llvm/HEAD-3638207/lib/clang/8.0.0",
"       \ "-stdlib=libc++",
"       \ "-fdeprecated-macro",
"       \ "-ferror-limit", "20",
"       \ "-fmessage-length", "99",
"       \ "-stack-protector", "1",
"       \ "-fcxx-exceptions",
"       \ "-fexceptions",
"       \ "-fmax-type-align=16",
"       \ "-fdiagnostics-show-option"]
"      \ "-mdisable-fp-elim",
"      \ "-masm-verbose",
"      \ "-munwind-tables",
"      \ "-target-cpu", "penryn"
"      \ "-target-linker-version", "278.4"
"      \ "-fcolor-diagnostics",

""" Color scheme """
set termguicolors
set background=dark
colorscheme gruvbox

highlight Pmenu guibg=brown gui=bold

"""""""""""""""""""""
""" C++ Highlight """
"""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

""" FZF """
"
nmap <Leader>ft :Tags<CR>
nmap <Leader>fbt :BTags<CR>
nmap <C-p> :Files<CR>

""" clang format """
"
let g:clang_format#code_style = "WebKit"
let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -2,
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11",
      \ "CompactNamespaces" : "false",
      \ "Cpp11BracedListStyle" : "true",
      \ "FixNamespaceComments" : "true",
      \ "BraceWrapping": {
      \   "AfterClass": "true",
      \   "AfterControlStatement": "true",
      \   "AfterEnum": "true",
      \   "AfterFunction": "true",
      \   "AfterNamespace": "false",
      \   "AfterStruct": "true",
      \   "AfterUnion": "true",
      \   "BeforeCatch": "true",
      \   "BeforeElse": "true",
      \   "IndentBraces": "false"
      \ },
      \ "PointerAlignment": "Left"
      \}
      "\ "SortUsingDeclarations" : "true",
let g:clang_format#auto_format_on_insert_leave = 0
autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>

""" NERD """
"
" Close NERD if it last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F5> :NERDTreeToggle<CR>

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
