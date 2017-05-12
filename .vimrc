set nocompatible
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/delimitMate.vim'
Plug 'mbbill/undotree'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/ScrollColors'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'neowit/vim-force.com'
Plug 'elzr/vim-json'
Plug 'Valloric/YouCompleteMe'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'othree/yajs.vim'
Plug 'wikitopian/hardmode'
Plug 'othree/xml.vim'
Plug 'mxw/vim-jsx'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/ZoomWin'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/matchit'
Plug 'fleischie/vim-styled-components'
call plug#end()
" filetype plugin indent on

" fix char encoding on mac
scriptencoding utf-8
set encoding=utf-8

" allow backspacing over everything
set backspace=indent,eol,start

"set backups to central location
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" lots of defaults
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

" vim-jsx load .js files too
let g:jsx_ext_required = 0

" salesforce defaults
let $VIMHOME=expand('<sfile>:p:h')
let g:apex_backup_folder=$VIMHOME."/.vim/backup"
let g:apex_temp_folder=$VIMHOME."/.vim/temp"
let g:apex_properties_folder=$VIMHOME."/.vim/properties"
let g:apex_tooling_force_dot_com_path=$VIMHOME."/.vim/tooling-force.com.jar"
let g:apex_workspace_path=$VIMHOME."/Workspace/sfdc"
let g:apex_maxPollRequests="10000"
let g:apex_pollWaitMillis="1000" 
let g:apex_server=1
let g:apex_server_timeoutSec=60*60*2
let g:apex_quickfix_coverage_toggle_shortcut = "c"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir="~/.vim/snips"

" undotree settings
let g:undotree_WindowLayout = 4
let g:undotree_SplitWidth = 40

" custom mappings
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <C-n> :NERDTreeToggle %<CR>
nnoremap <silent> <C-d> :w<CR>:ApexSave<CR>
nnoremap <leader>ac :ApexTestCoverageToggle<CR>
nnoremap <leader>at :ApexTestWithCoverage tooling-async expand('%:t:r')<CR>
nnoremap <leader>al :ApexLog<CR>
nnoremap <leader>ae :ApexExecuteAnonymous<CR>
nnoremap <leader>as :ApexScratch<CR>
nnoremap <leader>ap :ApexRefreshProject<CR>
nnoremap <leader>ab :ApexStageAdd<CR>
nnoremap <leader>av :ApexStageClear<CR> 
nnoremap <leader>af :ApexRefreshFile<CR>
nnoremap <leader>h :<Esc>:call ToggleHardMode()<CR>
nnoremap <leader>ra :%s/List<\([^>]*\)>/\1\[\]/g<CR>
"reformat single line braces to a better syntax
nnoremap <C-b> :%s/\n[\t\ ]*{/\ {/g<CR>:%s/}[\n\t\ ]*else/}\ else/g<CR>
"fix poor object creation string
nnoremap <C-I> :s/\v([ ]*)[^\.]*\.(.*);/    \1\2,/g<CR>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

"change commenting syntax on apex files
let g:NERDCustomDelimiters = { 
    \ 'apexcode': { 'left': '//', 'right': '' }
    \ }

