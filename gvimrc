set guioptions-=T
colorscheme geoff_gui

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  
endif

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTermSplit bash --login'
  setlocal listchars=tab:\ \ 
endfunction

"Size and Window Position
set lines=60
set columns=180
:winpos 150 0 

set guifont=Meslo\ LG\ S\ \DZ:h11
" Load custom configuration
let my_home = expand("$HOME/")
if filereadable(my_home . '.gvimrc.local')
	source ~/.gvimrc.local
endif

