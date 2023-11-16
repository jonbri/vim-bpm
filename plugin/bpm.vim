" bpm.vim - scroll and sing along

" don't load twice
" if exists("g:loaded_bpm") || &cp || v:version < 700
"   finish
" endif
" let g:loaded_bpm = 1

function! InvokeBpm(...)
  :call timer_start(500, { id -> execute("normal! j") }, { 'repeat': -1 })
endfunction

function! InvokeBpmH(...)
  :call timer_start(100, { id -> execute("normal! zl") }, { 'repeat': -1 })
endfunction

command! -bang Bpm
    \ :call InvokeBpm(<args>)

command! -bang Bpmh
    \ :call InvokeBpmH(<args>)
