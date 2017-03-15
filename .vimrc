:silent
:set nocp
:set number
:set ls=2
:colorscheme seti
:filetype plugin on
:set tabstop=4
:set expandtab
:set softtabstop=4
:set shiftwidth=4
:setlocal foldmethod=indent
:set t_Co=256
:set nowrap
:set clipboard=unnamed
:set clipboard=unnamedplus
:set autoindent
:set cindent
:set si
:syntax enable
:set showmatch
:set hlsearch
:set ignorecase
:set noswapfile
:set mouse=a
:inoremap        (  ()<Left>
:inoremap        "  ""<Left>
:inoremap        `  ``<Left>
:inoremap        '  ''<Left>
:inoremap        [  []<Left>
:inoremap      {  {}<Left>

:autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
:autocmd FileType sh,ruby,python   let b:comment_leader = '# '
:noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
:noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7

:noremap <silent> #5 :!xfce4-terminal --title "%" --hold -e "./%" <CR> <CR>" execute bash & python script with F5
:noremap <silent> #3 :bp<CR> " switch to pervious tab with F3
:noremap <silent> #4 :bn<CR> " switch to next tab with F2
:map <F8> :setlocal spell! spelllang=en_us<CR> " check spelling with F8
:set pastetoggle=<F2>
" plugins
"indentLine 
:let g:indentLine_char = '.'
" autocomplpop setting
:set omnifunc=syntaxcomplete " This is necessary for acp plugin
:let g:acp_behaviorKeywordLength = 1 "  Length of keyword characters before the cursor, which are needed to attempt keyword completion

" airline plugin setting
:let g:airline_theme='powerlineish' " set airline plugin theme
:let g:airline#extensions#tabline#enabled = 1 " showing tabs 
:let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

 " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'

" NERDTree plugin setting
:map <F9> :NERDTreeToggle<CR> " toggle showing NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
:autocmd StdinReadPre * let s:std_in=1
:autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
:autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if the only window left open is a NERDTree
"indent plugin
:let g:indentLine_char = '┆'

"vim-airline-clock 
:let g:airline#extensions#clock#format = '%c'

