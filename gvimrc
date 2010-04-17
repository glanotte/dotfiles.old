set guioptions-=T
colorscheme railscasts

"Size and Window Position
set lines=60
set columns=180
:winpos 150 0 

" Load custom configuration
let my_home = expand("$HOME/")
if filereadable(my_home . '.gvimrc.local')
	source ~/.gvimrc.local
endif
