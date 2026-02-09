" auto install plugin manager vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}

" plugins {{{
call plug#begin('~/.vim/plugged')

" linter
Plug 'dense-analysis/ale'

" ide like
Plug 'ctrlpvim/ctrlp.vim'               " file fuzzy search
Plug 'tpope/vim-surround'               " sourround modifyer helper
Plug 'tpope/vim-fugitive'               " git helper
Plug 'tpope/vim-commentary'             " quick comment block
Plug 'tpope/vim-repeat'                 " more powerfull repeat
Plug 'SirVer/ultisnips'                 " snippet engine
Plug 'honza/vim-snippets'               " snippets for Ultisnips
Plug 'nathanaelkane/vim-indent-guides'  " indentation helper
Plug 'godlygeek/tabular'                " vertical alignment helper
Plug 'Raimondi/delimitMate'             " smart pairs
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                 " fzf for vim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
Plug 'joereynolds/SQHell.vim'           " sql editor
Plug 'markonm/traces.vim'               " visual replacement
Plug 'ciaranm/securemodelines'          " limit what modelines can do
Plug 'embear/vim-localvimrc'            " enable per project configuration
Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense like feature

" colorscheme
let g:gruvbox_italic=1  " enable italic in terminal
Plug 'morhetz/gruvbox'

" language improvement
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars', 'html.mustache'] }
Plug 'tomlion/vim-solidity', { 'for': 'solidity' }

" add plugin to runtimepath
call plug#end()
" }}}

" Vimscript file settings {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" auto-reload .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" }}}

" swap files {{{

" swap files (.swp) in a common location

" Create directories if needed.
fun! RequireDirectory(directory)
    if !isdirectory(a:directory)
        call mkdir(a:directory)
    endif
endf

" // means use the file's full path
set dir=~/.vim/_swap/
call RequireDirectory(expand("~") . "/.vim/_swap")

" backup files (~) in a common location if possible
set backup
set backupdir=~/.vim/_backup/
call RequireDirectory(expand("~") . "/.vim/_backup")

" turn on undo files, put them in a common location
set undofile
set undodir=~/.vim/_undo/
call RequireDirectory(expand("~") . "/.vim/_undo")

" }}}

" global {{{
"set relativenumber  " ruler with relative line number
set number          " ruler with line number
set hidden          " let change buffer without saving

" remove trailing whitespaces
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.py,*.js,*.hs,*.rs,*.html,*.css,*.scss,*.c,*.h,*.cpp,*.hpp,*.sh,*.ts,*.tsx silent! :call <SID>StripTrailingWhitespaces()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" <C-a> and <C-x> ignore octal format so "07" <C-a> becomes "08"
set nrformats-=octal

" Defaut indentation
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" jump to parent in json file
autocmd FileType json nnoremap <buffer><silent> { :call searchpair("\{","","\}","b")<cr>
autocmd FileType json nnoremap <buffer><silent> } :call searchpair("\{","","\}")<cr>
autocmd FileType json nnoremap <buffer><silent> [ :call searchpair("\[","","\]","b")<cr>
autocmd FileType json nnoremap <buffer><silent> ] :call searchpair("\[","","\]")<cr>

" disable mouse
set mouse=
" }}}

" Searching configurations {{{
set incsearch   " Incremental search. Best search feature ever
set ignorecase
set smartcase   " Makes case sensitivity in search only matter if one of the letters is upper case.
set hlsearch    " highlight search result
" }}}

" completion {{{
set wildmenu                     " show more than one suggestion for completion
set wildmode=list:longest,full   " shell-like completion (up to ambiguity point)
set wildignore=*.o,*.out,*.obj,*.pyc,.git,.hgignore,.svn,.cvsignore,*.so,*.swp,*.zip
" }}}

" visuals {{{1

"set t_Co=256            " force vim to use 256 colors
set background=dark
syntax on               " syntax highlighting
colorscheme gruvbox

" look improvement
"set fillchars=stl:─,stlnc:─,vert:│,fold:─,diff:─

" break long lines visually (not actual lines)
set wrap linebreak
set textwidth=0 wrapmargin=0

" status line {{{2
set laststatus=2                 " always display the status line
set shortmess=atI                " short messages to avoid scrolling
set title
set ruler                        " show the cursor position all the time
set showcmd                      " display incomplete commands
" }}}2

if exists('+colorcolumn')
    set colorcolumn=80
endif

" when scrolling, keep space around cursor
set scrolloff=2
set sidescrolloff=5

" split screen below and right instead of vim natural
set splitbelow
set splitright

" gvim
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar
set guioptions-=e  " tab appearance like in term
set guicursor+=a:blinkon0

if has("gui_running")
    set guifont=DejaVu\ Sans\ Mono\ 9
endif

" }}}1

" Arrow desactivation {{{
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <home> <nop>
noremap <End> <nop>
" }}}

" convenient shortcut {{{
" default macro
nnoremap Q @q

" save and restore session
nnoremap <F2> :mksession! ~/.vim/_vim_session <cr>
nnoremap <F3> :source ~/.vim/_vim_session <cr>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Jump to next in location list
nnoremap <C-l> :lnext<CR>

"}}}

" leader {{{
map <space> <leader>

nnoremap <silent> <Leader>/ :nohlsearch<CR>
"}}}

" Language specific {{{
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai nocindent cinoptions+=:0 colorcolumn=100 foldmarker=#region,#endregion
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai nocindent cinoptions+=:0 colorcolumn=100 foldmarker=#region,#endregion
autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai nocindent cinoptions+=:0 colorcolumn=100 foldmarker=#region,#endregion
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai nocindent
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai
autocmd FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab ai
autocmd FileType c setlocal tabstop=softtabstop=4 shiftwidth=4 expandtab ai
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab ai
autocmd FileType pug setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ai
autocmd FileType markdown setlocal textwidth=100 colorcolumn=100
autocmd BufNewFile,BufRead *.vm setlocal filetype=html
" }}}

" Plugins configurations

" linter {{{
let g:ale_sign_column_always = 1
let g:ale_echo_msg_format = '[%linter%]{%severity%}%(code)% %s'
let g:ale_virtualtext_cursor = 'disabled'

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver'],
\   'json': ['jq']
\}

let g:ale_c_gcc_options = '-Wall -Werror -Wextra -I./include -I./../include'
let g:ale_cpp_gcc_options = '-Wall -Werror -Wextra -I./include -I./../include -std=c++11'
let g:ale_cpp_gcc_executable = "g++"

let g:ale_fixers = {
\   'css': ["prettier"],
\   'javascript': ["prettier"],
\   'typescript': ["prettier"],
\   'typescriptreact': ["prettier"],
\}
let cur_node_root = system("echo -n $(dirname $(npm root))")
if filereadable(cur_node_root . "/prettier.config.js")
    let g:ale_fix_on_save = 1
endif

function! EslintIgnore()
  let codes = []
  for d in getloclist(0)
    if (d.lnum==line('.'))
      let matches = matchlist(d.text, '(\(.\{-}\))')
      echo matches[1]
      call add(codes, matches[1])
    endif
  endfor
  if len(codes)
    exe 'normal O/* eslint-disable-next-line ' . join(codes, ', ') . ' */'
  endif
endfunction

nnoremap <silent> <Leader>m :call EslintIgnore()<CR>

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
" }}}

" CtrlP {{{
" set the ignore file for ctrlp plugin
set wildignore+=*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_user_command = ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard |& egrep -v "\.(png|jpg|jpeg|gif)$|node_modules|bower_components"']

nnoremap <silent> <Leader>o :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>f :CtrlPMRUFiles<CR>
nnoremap <Leader>? /\C
" }}}

" fzf {{{
let g:fzf_launcher = 'urxvt -geometry 120x30 -e sh -c %s'
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
else
    let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
endif

nnoremap <silent> <C-j> :BLines<CR>
" }}}

" status line {{{
set statusline=%F\ %r%m%h%w%y\ -\ %l/%Ll,%vc\ -\ %{LinterStatus()}
" }}}

" vim-cpp-enhanced-highlight {{{
let g:cpp_class_scope_highlight = 1
"}}}

" Ultisnips {{{
let g:UltiSnipsUsePythonVersion = 3

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" vim-indent-guides {{{
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
" }}}

" Ack / ag {{{
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" delimitMate {{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
nnoremap <silent> <Leader>d :DelimitMateSwitch<CR>
" }}}

" markdown-preview {{{
let g:mkdp_markdown_css = '/home/bob/.vim/markdown.css'
let g:mkdp_highlight_css = '/home/bob/.vim/highlight.css'
" }}}

" SQHell {{{
if filereadable(expand('~/.vim/SQHell_config.vim'))
source ~/.vim/SQHell_config.vim
endif
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
" }}}

" securemodelies {{{
let g:secure_modelines_allowed_items = [
            \ "textwidth",   "tw",
            \ "softtabstop", "sts",
            \ "tabstop",     "ts",
            \ "shiftwidth",  "sw",
            \ "expandtab",   "et",   "noexpandtab", "noet",
            \ "filetype",    "ft",
            \ "foldmethod",  "fdm",
            \ "readonly",    "ro",   "noreadonly", "noro",
            \ "rightleft",   "rl",   "norightleft", "norl"
            \]
" }}}

" vim-localvimrc {{{
let g:localvimrc_persistent = 1
let g:localvimrc_persistence_file = glob('~/.vim/localvimrc_persistent')
" }}}

" coc {{{
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <Leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" add coc status to status line
set statusline+=\ -\ %{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}
