" ===== Vundle / Plugins =====
set nocompatible " To be safe
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive' " Git functionality
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' } " Syntax checking
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Filesystem browser
Plug 'scrooloose/nerdcommenter' " Comment lines
Plug 'c.vim' " C(++) development tools
Plug 'easymotion/vim-easymotion' " Move around more easily
Plug 'airblade/vim-gitgutter' " Show git diff in gutter
Plug 'StanAngeloff/php.vim' " PHP development tools
Plug 'henrik/vim-indexed-search' " Match x of n
Plug 'bling/vim-airline' " Fancy statusline
Plug 'majutsushi/tagbar' " Ctags sidebar, airline integration
Plug 'terryma/vim-multiple-cursors' " Sublime-esque multiple cursors
Plug 'Eppie/rainbow' " Rainbow-colored parentheses
Plug 'flazz/vim-colorschemes' " Many colorschemes
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Tab completion
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

" ===== Ctrlp =====
let g:ctrlp_clear_cache_on_exit = 0 " keep cache
let g:ctrlp_max_files = 0 " no limit
let g:ctrlp_open_new_file = 't' " open files in new tab
let g:ctrlp_by_filename = 1 " search by filename instead of full path. Press Ctrl+d to toggle.
let g:ctrlp_cmd = 'CtrlPMixed'
if executable('ag') " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ===== Vim =====
syntax on " Syntax highlighting
set backspace=indent,eol,start " Make backspace work normally
set t_Co=256 " Tell vim it has 256 colors
if has("autocmd") " Remember cursor's last position when re-opening a file
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
set background=dark " Get the right colors

" ===== YouCompleteMe =====
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0

" ===== Airline =====
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1

" ===== Syntastic =====
" Syntastic general options:
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let b:syntastic_mode = 'passive'

" Syntastic C++ options:
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Syntastic Python options:
let g:syntastic_python_python_exec = '/usr/bin/python'

" Visualize tabs, trailing whitespaces and funny characters
set list
set listchars=nbsp:¬,tab:\|\ ,extends:»,precedes:«,trail:•

" ===== Rainbow =====
let g:rainbow_active = 1

" ===== Search =====
set incsearch " Incremental search
set hlsearch " Highlight matches
hi Search ctermfg=0 " Make text black when it's highlighted
set magic " For regular expressions turn magic on
set ignorecase " if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.
set smartcase

" Highlight matching brackets
set showmatch

" Persist undo across sessions. Make sure that the undodir exists, otherwise
" this will not work.
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
endif

" Keep 7 lines above/below the cursor when moving with j/k
set scrolloff=7

" Reload changes to .vimrc automatically
autocmd BufWritePost  ~/.vimrc source ~/.vimrc

" ===== Taglist =====
let Tlist_Exit_OnlyWindow = 1
let g:tagbar_left = 1
let g:tagbar_compact = 1

" ===== Ctags =====
set tags=./tags;

" ===== Custom shortcuts =====
" Ctrl+l: clear highlighting
nnoremap <silent> <C-l> :noh<return><C-l>

" F5: apply YouCompleteMe autofix
map <F5> :YcmCompleter FixIt<CR>

" F6: clear Syntastic warning messages
map <F6> :SyntasticReset<return>

" F7: toggle display of tabs/spaces/etc
nmap <F7> :set list!<return>

" F8: toggle the ctags sidebar
nmap <F8> :TagbarToggle<CR>

" Alt+→: next buffer
map [1;3C <Esc>:bn!<return>
map! [1;3C <Esc>:bn!<return>

" Alt+← previous buffer
map [1;3D <Esc>:bp!<return>
map! [1;3D <Esc>:bp!<return>

" \1, \2, etc to go to numbered buffer.
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" ===== PHP =====
" Custom colors for keywords in docblocks
function! PhpSyntaxOverride()
	hi! def link phpDocTags phpDefine
	hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
	autocmd!
	autocmd FileType php call PhpSyntaxOverride()
augroup END
