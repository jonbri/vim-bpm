" bpm.vim - scroll and sing along

" don't load twice
if exists("g:loaded_bpm") || &cp || v:version < 700
  finish
endif
let g:loaded_bpm = 1

let g:is_running = 0
let g:interval = 300
let g:direction = ""

function! ScrollUpOnce()
  normal! k
endfunction

function! ScrollDownOnce()
  normal! j
endfunction

function! ScrollRightOnce()
  normal! zl
endfunction

function! ScrollLeftOnce()
  normal! zh
endfunction

function! InvokeBpmUp()
  if g:is_running
    :call timer_stop(g:timer_id)
    let g:is_running = 0
    if g:direction == "up"
      return
    endif
  endif

  let l:line = search("bpm:", "bn")
  let l:bpm = matchstr(getline(l:line), '\d\+')
  if l:bpm != ""
    let g:interval = l:bpm
  endif
  let g:timer_id = timer_start(g:interval, { id -> ScrollUpOnce() }, { 'repeat': -1 })
  let g:is_running = 1
  let g:direction = "up"
endfunction

function! InvokeBpmDown()
  if g:is_running
    :call timer_stop(g:timer_id)
    let g:is_running = 0
    if g:direction == "down"
      return
    endif
  endif

  let l:line = search("bpm:", "n")
  let l:bpm = matchstr(getline(l:line), '\d\+')
  if l:bpm != ""
    let g:interval = l:bpm
  endif
  let g:timer_id = timer_start(g:interval, { id -> ScrollDownOnce() }, { 'repeat': -1 })
  let g:is_running = 1
  let g:direction = "down"
endfunction

function! InvokeBpmRight()
  if g:is_running
    :call timer_stop(g:timer_id)
    let g:is_running = 0
    if g:direction == "right"
      return
    endif
  endif

  let l:line = search("bpm:", "nb")
  let l:bpm = matchstr(getline(l:line), '\d\+')
  if l:bpm != ""
    let g:interval = l:bpm
  endif
  let g:timer_id = timer_start(g:interval, { id -> ScrollRightOnce() }, { 'repeat': -1 })
  let g:is_running = 1
  let g:direction = "right"
endfunction

function! InvokeBpmLeft()
  if g:is_running
    :call timer_stop(g:timer_id)
    let g:is_running = 0
    if g:direction == "left"
      return
    endif
  endif

  let l:line = search("bpm:", "n")
  let l:bpm = matchstr(getline(l:line), '\d\+')
  if l:bpm != ""
    let g:interval = l:bpm
  endif
  let g:timer_id = timer_start(g:interval, { id -> ScrollLeftOnce() }, { 'repeat': -1 })
  let g:is_running = 1
  let g:direction = "left"
endfunction

" scroll once
nnoremap <C-Up> :call ScrollUpOnce()<CR>
nnoremap <C-Down> :call ScrollDownOnce()<CR>
nnoremap <C-Right> :call ScrollRightOnce()<CR>
nnoremap <C-Left> :call ScrollLeftOnce()<CR>

" scroll continuously
nnoremap <leader><C-Up> :call InvokeBpmUp()<CR>
nnoremap <leader><C-Down> :call InvokeBpmDown()<CR>
nnoremap <leader><C-Right> :call InvokeBpmRight()<CR>
nnoremap <leader><C-Left> :call InvokeBpmLeft()<CR>

