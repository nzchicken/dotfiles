set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/delimitMate.vim'
Plugin 'vim-scripts/Gundo'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/ScrollColors'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'elzr/vim-json'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'wikitopian/hardmode'

call vundle#end()
filetype plugin indent on

set background=dark
syntax on
set nu
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
colorscheme candycode
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set history=1000

let $VIMHOME=expand('<sfile>:p:h')

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir="~/.vim/snips"

" gundo settings
let g:gundo_right = 1
let g:gundo_width = 40

" custom mappings
nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <C-n> :NERDTreeToggle %<CR>
nnoremap <leader>h :<Esc>:call ToggleHardMode()<CR>

"reformat single line braces to a better syntax
nnoremap <C-b> :%s/\n[\t\ ]*{/\ {/g<CR>:%s/}[\n\t\ ]*else/}\ else/g<CR>
"fix poor object creation string
nnoremap <C-I> :s/\v([ ]*)[^\.]*\.(.*);/    \1\2,/g<CR>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>
