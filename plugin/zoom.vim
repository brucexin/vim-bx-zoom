"==============================================================================
"vim-bx-zoom.vim : control gui font size with "+" or "-" keys, compatible gtk2
"and other gtk version
"author: bruce.xin <bruce.xin@gmail.com>
"This plugin is for GUI only.

"Normal Mode:
    "+                  ... change font size bigger
    "-                  ... change font size smaller

"Command-line Mode:
    ":zoomIn            ... change font size bigger
    ":zoomOut           ... change font size smaller

" command
command! -narg=0 ZoomIn    :call s:zoomIn()
command! -narg=0 ZoomOut   :call s:zoomOut()
"command! -narg=0 ZoomReset :call s:ZoomReset()

" map
nmap + :ZoomIn<CR>
nmap - :ZoomOut<CR>

"change guifont size
function! s:doZoom(delta)
  let s:min_size = 6
  let s:max_size = 24
  if has("gui_gtk2")
    let s:pattern = '^\(.* \)\([1-9][0-9]*\)\(.*\)$'
  else
    let s:pattern = '^\(.*:h\)\([1-9][0-9]*\)\(.*\)$'
  end
  let l:head = substitute(&guifont, s:pattern, '\1', '')
  let l:fsize = substitute(&guifont, s:pattern, '\2', '')
  let l:tail = substitute(&guifont, s:pattern, '\3', '')
  let l:head_w = substitute(&guifontwide, s:pattern, '\1', '')
  let l:fsize_w = substitute(&guifontwide, s:pattern, '\2', '')
  let l:tail_w = substitute(&guifontwide, s:pattern, '\3', '')
  "echoerr "font size is" l:fsize l:head l:tail
  let l:fsize += a:delta
  let l:fsize_w += a:delta
  if (l:fsize > s:max_size)
    echoerr "font size has reached max limit!"
  elseif (l:fsize < s:min_size)
    echoerr "font size has reached min limit!"
  else
    let l:guifont = l:head.l:fsize.l:tail
    let l:guifont_w = l:head_w.l:fsize_w.l:tail_w
  "echoerr "new font is" l:guifont
    let &guifont = l:guifont
    let &guifontwide = l:guifont_w
  endif
endfunction

" guifont size - 1
function! s:zoomOut()
  call s:doZoom(-1)
endfunction

" guifont size + 1
function! s:zoomIn()
  call s:doZoom(1)
endfunction

" reset guifont size
"function! s:ZoomReset()
  "let &guifont = s:current_font
"endfunction

