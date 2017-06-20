set number
execute pathogen#infect()
call pathogen#helptags()
syntax on
colorscheme monokai

"NERDTree Config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
map 1 :bprevious<CR>
map 2 :bnext<CR>

"Airline Config
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
let g:airline_theme='murmur'

" auto complete for ( , " , ' , [ , { 
:inoremap        (  ()<Left>
:inoremap        "  ""<Left>
:inoremap        `  ``<Left>
:inoremap        '  ''<Left>
:inoremap        [  []<Left>
:inoremap      {  {}<Left>

" Commenting And Uncommenting
" auto comment and uncooment with F6 and F7 key
:autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
:autocmd FileType sh,ruby,python   let b:comment_leader = '# '
:noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
:noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7

" Closing Buffers Properly
" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
echohl ErrorMsg
echomsg a:msg
echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
if empty(a:buffer)
let btarget = bufnr('%')
elseif a:buffer =~ '^\d\+$'
let btarget = bufnr(str2nr(a:buffer))
else
let btarget = bufnr(a:buffer)
endif
if btarget < 0
call s:Warn('No matching buffer for '.a:buffer)
return
endif
if empty(a:bang) && getbufvar(btarget, '&modified')
call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
return
endif
" Numbers of windows that view target buffer which we will delete.
let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
if !g:bclose_multiple && len(wnums) > 1
call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
return
endif
let wcurrent = winnr()
for w in wnums
execute w.'wincmd w'
let prevbuf = bufnr('#')
if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
buffer #
else
bprevious
endif
if btarget == bufnr('%')
" Numbers of listed buffers which are not the target to be deleted.
let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
" Listed, not target, and not displayed.
let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
" Take the first buffer, if any (could be more intelligent).
let bjump = (bhidden + blisted + [-1])[0]
if bjump > 0
execute 'buffer '.bjump
else
execute 'enew'.a:bang
endif
endif
endfor
execute 'bdelete'.a:bang.' '.btarget
execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>

map <F2> :Bclose<CR>
map <F3> :bd<CR>

" IndentLine
set list lcs=tab:\|\ 
let g:indentLine_char = '┆'

" Python Syntax Highlight
 let python_highlight_all = 1

" Molokai
let g:molokai_original = 1
