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
Plug 'elzr/vim-json'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --java-completer --clang-completer --ts-completer --go-completer' }
Plug 'noah/vim256-color'
Plug 'bling/vim-airline'
Plug 'othree/yajs.vim'
Plug 'othree/xml.vim'
Plug 'mxw/vim-jsx'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/ZoomWin'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/matchit'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'will133/vim-dirdiff'
Plug 'dense-analysis/ale'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'janko/vim-test'
Plug 'vim-ruby/vim-ruby'
call plug#end()
filetype plugin indent on

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
colorscheme flattr
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set history=1000

" NERDTree
let g:NERDTreeNodeDelimiter = "\u00a0"

" vim-jsx load .js files too
let g:jsx_ext_required = 0

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

" syntastic settings
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:syntastic_typescript_checkers = ['eslint']
let g:syntastic_javascript_checkers = []

" custom mappings
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <C-n> :NERDTreeToggle %<CR>
nnoremap <leader>sc :SyntasticCheck<cr>
nnoremap <leader>sm :SyntasticToggleMode<cr>

" Super tab mappings
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

"git rebase changes
nnoremap <silent> <leader>gd :s/^\S*\ /drop\ /g<CR>
nnoremap <silent> <leader>gp :s/^\S*\ /pick\ /g<CR>
nnoremap <silent> <leader>gs :s/^\S*\ /squash\ /g<CR>
nnoremap <silent> <leader>ge :s/^\S*\ /edit\ /g<CR>

" vim-test mappings
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tt :TestFile<CR>
nnoremap <silent> <leader>tT :TestLast<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

" ale bindings
nnoremap <silent> <leader>gd :ALEGoToDefinition<CR>

"change commenting syntax on apex files
let g:NERDCustomDelimiters = { 
    \ 'apexcode': { 'left': '//', 'right': '' }
    \ }

" SFDX vim mappings and commands
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^SFDXPopWindow$')
  silent! execute  winnr < 0 ? 'botright new SFDXPopWindow' : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize 8'
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  silent! execute 'wincmd p'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
