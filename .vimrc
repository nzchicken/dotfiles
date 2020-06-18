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

" salesforce defaults
let $VIMHOME=expand('<sfile>:p:h')
let g:apex_API_version=40.0
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

" tooling-force mappings
nnoremap <silent> <C-d> :w<CR>:ApexSave<CR>
nnoremap <silent> <C-D> :w<CR>:ApexSave!<CR>
nnoremap <leader>ac :ApexTestCoverageToggle<CR>
nnoremap <leader>at :ApexTestWithCoverage tooling-async %:t:r<CR>
nnoremap <leader>al :ApexLog<CR>
nnoremap <leader>ae :ApexExecuteAnonymous<CR>
nnoremap <leader>as :ApexScratch<CR>
nnoremap <leader>am :ApexMessages<CR>
nnoremap <leader>ap :ApexRefreshProject<CR>
nnoremap <leader>ab :ApexStageAdd<CR>
nnoremap <leader>av :ApexStageClear<CR> 

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

command! -complete=shellcmd -nargs=* SFDXPush call s:ExecuteInShell('sfdx force:source:push '.<q-args>)
command! -complete=shellcmd -nargs=* SFDXPull call s:ExecuteInShell('sfdx force:source:pull '.<q-args>)
command! -complete=shellcmd -nargs=* SFDXLog call s:ExecuteInShell('sfdx force:apex:log:get '.<q-args>)
command! -complete=shellcmd -nargs=* SFDXTest call s:ExecuteInShell('sfdx force:apex:test:run --loglevel debug -w 10 -r human  '.<q-args>)
command! -complete=shellcmd -nargs=* SFDXTestWithCoverage call s:ExecuteInShell('sfdx force:apex:test:run --loglevel debug -w 10 -r human -c '.<q-args>)

nnoremap <leader>ss :SFDXPush<CR>
nnoremap <leader>sS :SFDXPush --forceoverwrite<CR>
nnoremap <leader>sp :SFDXPull<CR>
nnoremap <leader>st :SFDXTest --classnames %:t:r<CR>
nnoremap <leader>sT :SFDXTestWithCoverage --classnames %:t:r<CR>
nnoremap <leader>sl :SFDXLog -n 1 -c<CR>
