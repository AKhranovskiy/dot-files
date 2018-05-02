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
"set cursorline      " highlight current line
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

  call dein#add('altercation/vim-colors-solarized') " Color scheme: solarized

  call dein#add('/usr/local/opt/fzf') " Fuzzy finder
  call dein#add('junegunn/fzf.vim')

  call dein#add('kana/vim-operator-user')
  call dein#add('rhysd/vim-clang-format')

  call dein#add('majutsushi/tagbar')  " Tag bar

  call dein#add('w0rp/ale') " Async Linter Engine

  call dein#add('scrooloose/nerdtree')  " NerdTree

  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')

  " call dein#add('tpope/vim-fugitive') " Git

  call dein#add('MattesGroeger/vim-bookmarks') " Bookmarks

  " call dein#add('rust-lang/rust.vim')
  " call dein#add('sebastianmarkow/deoplete-rust')

  call dein#add('peterhoeg/vim-qml')
  call dein#add('dag/vim-fish')

  " call dein#add('autozimu/LanguageClient-neovim') " cquery client

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
let g:deoplete#sources#clang#libclang_path='/usr/local/Cellar/llvm/HEAD-2cf5f8c/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/usr/local/Cellar/llvm/HEAD-2cf5f8c/lib/clang/7.0.0/include/'
let g:deoplete#sources#clang#std={'cpp':'c++17'}
let g:deoplete#sources#clang#flags = [
      \ "-cc1",
      \ "-triple", "x86_64-apple-macosx10.13.0",
      \ "-discard-value-names",
      \ "-mrelocation-model", "pic", "-pic-level", "2",
      \ "-mthread-model", "posix",
      \ "-dwarf-column-info",
      \ "-debugger-tuning=lldb",
      \ "-resource-dir", "/usr/local/Cellar/llvm/HEAD-2cf5f8c/lib/clang/7.0.0",
      \ "-stdlib=libc++",
      \ "-fdeprecated-macro",
      \ "-ferror-limit", "20",
      \ "-fmessage-length", "99",
      \ "-stack-protector", "1",
      \ "-fcxx-exceptions",
      \ "-fexceptions",
      \ "-fmax-type-align=16",
      \ "-fdiagnostics-show-option"]
"      \ "-mdisable-fp-elim",
"      \ "-masm-verbose",
"      \ "-munwind-tables",
"      \ "-target-cpu", "penryn"
"      \ "-target-linker-version", "278.4"
"      \ "-fcolor-diagnostics",

let g:deoplete#sources#rust#racer_binary='/Users/khranovs/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/Users/khranovs/ExtProjects/rust-src/src'
let g:deoplete#sources#rust#show_duplicates=1

autocmd FileType rs nnoremap <buffer><Leader>cf :<C-u>RustFmt<CR>
autocmd FileType rs vnoremap <buffer><Leader>cf :RustFmtRange<CR>

""" Color scheme """
"
set termguicolors
set background=dark
colorscheme solarized

highlight Pmenu guibg=brown gui=bold

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
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

""" Tagbar (ctags browser)
"
nmap <F8> :TagbarToggle<CR>

""" ALE """
"
let g:ale_enabled = 1
" " let g:airline#extensions#ale#enabled = 0
" " let g:ale_change_sign_column_color = 1
let g:ale_completion_enabled = 1
let g:ale_lint_delay = 500
let g:ale_lint_on_enter = 1
let g:ale_lint_on_fileType_changed = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = "always"
let g:ale_linters = {
      \ "cpp" : ["clang"],
      \}
let g:ale_linters_explicit = 1
let g:ale_set_quickfix = 1
let g:ale_cpp_clang_executable = "clang++7"
let g:ale_cpp_clang_options = '-std=c++17 -Wall -Wextra -Werror -Wshadow -Werror -pedantic -pedantic-errors -Wshorten-64-to-32 -Wfloat-equal -fstrict-aliasing -Wstring-conv'
let g:ale_cpp_clangcheck_executable = '/usr/local/opt/llvm/bin/clang-check'
let g:ale_cpp_clangcheck_options = '-p ./build'

"
""" NERD """
"
" Close NERD if it last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F5> :NERDTreeToggle<CR>

""" Snippets """
"
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" LanguageClient """
"
" let g:LanguageClient_serverCommands = {
" \ 'cpp': ['/Users/khranovs/ExtProjects/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log']
" \ }
" let g:LanguageClient_loadSettings = 1
" let g:LanguageClient_loggingLevel = 'DEBUG'
" Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = '/home/yourusername/.config/nvim/settings.json'


""" Put these lines at the very end of your vimrc file.
"
""" Load all plugins now.
""" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
""" Load all of the helptags now, after plugins have been loaded.
""" All messages and errors will be ignored.
silent! helptags ALL
