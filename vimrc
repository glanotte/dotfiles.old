" configure pathogen
call pathogen#infect()

"Set leader key
let mapleader = ","

" Custom Leader Commands
map <leader>nn :sp ~/Dropbox/notes/programming_notes.txt<cr>
map <leader>np :sp ~/Dropbox/notes/project_notes.txt<cr>

"Setting to allow clipboard access with p and y
set clipboard=unnamed

filetype plugin indent on
filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
 
" Store temporary files in a central spot, thanks to Gary Bernhardt
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ignore extension files
set wildignore=*.dll,*.o,*.obj,*.bak,*.pyc,*.swp " ignore these"

" set the status line
" set statusline=%f%h%m%r%h%w%y\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ %{fugitive#statusline()}
" Configure powerline
let g:Powerline_symbols = 'fancy'
let g:rails_statusline=1
set laststatus=2
set encoding=utf-8

" Color for non-gui vim
colorscheme geoff_gui

" Set the title string to display the full path
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70
" show a dot for trailing whitespace
set listchars=tab:▸\ ,trail:·
set list
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
 
" Have ctags look in gems.tags
set tags+=gems.tags

syntax enable
set smartindent

set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set expandtab

set showmatch
set incsearch

" TagList
map <leader>tl :TlistToggle <cr>
let Tlist_Use_Right_Window = 1

" Code Folding
set fdm=syntax
set fdc=2
" set the level high enough that nothing should be folded initially
set fdl=10
" Love the cursor line
set cursorline
"syntax for scss
au BufRead,BufNewFile *.scss set filetype=scss

" Relative Line numbers, requires vim 7.3+
set rnu

set hlsearch

" Don't use Ex mode, use Q for formatting
map Q gq

"Adding #{} to AutoClose Plugin and activating it for String interpolation
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'} 
let g:AutoCloseProtectedRegions = ["Character"] 
let g:AutoCloseExpandEnterOn = ""

"Load custom configuration
let my_home = expand("$HOME/")
if filereadable(my_home . '.vimrc.local')
	source ~/.vimrc.local
endif

" Quick jumping between splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
" Requires 'scratch' plugin
  :topleft 100 :split __Routes__
" Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
" Delete everything
  :normal 1GdG
" Put routes output in buffer
  :0r! rake -s routes
" Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
" Move cursor to bottom
  :normal 1GG
" Delete empty trailing line
  :normal dd
endfunction

" CtrlP configuration, heavily inspired by Gary Bernhardt's Command-T config
let g:ctrlp_working_path_mode = 'r'
map <leader>gv :CtrlPClearCache<cr>:CtrlP app/views<cr>
map <leader>gc :CtrlPClearCache<cr>:CtrlP app/views<cr>
map <leader>gm :CtrlPClearCache<cr>:CtrlP app/models<cr>
map <leader>gh :CtrlPClearCache<cr>:CtrlP app/helpers<cr>
map <leader>ga :CtrlPClearCache<cr>:CtrlP app/assets<cr>
map <leader>gs :CtrlPClearCache<cr>:CtrlP app/assets/stylesheets<cr>
map <leader>gj :CtrlPClearCache<cr>:CtrlP app/assets/javascripts<cr>
map <leader>gh :CtrlPClearCache<cr>:CtrlP lib<cr>
map <leader>gp :CtrlPClearCache<cr>:CtrlP public<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlPClearCache<cr>:CtrlP<cr>

" Rails specific files
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gR :call ShowRoutes()<cr>

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>s :sp %%
map <leader>v :view %%

" Auto Indent
if has("autocmd")
  filetype indent on

  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Comments
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType yaml set commentstring=#\ %s

" Running tests
function! RunTests(filename)
" Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    if filereadable("script/test")
        exec ":!script/test " . a:filename
    else
        exec ":!bundle exec rspec " . a:filename
    end
endfunction

function! SetTestFile()
" Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

" Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('spec')<cr>
map <leader>c :w\|:!cucumber<cr>
map <leader>C :w\|:!cucumber --profile wip<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moves a variable declaration to an rspec let comment (Thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
" :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
