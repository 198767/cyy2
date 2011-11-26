function Timer(timer_id,timer_interval,timer_callback)
let timer_lasttime=reltime()
exec "augroup ".a:timer_id
  au!
  au CursorHold * call TimerTick('n')
  au CursorMoved * call TimerTick('n')
augroup END


function! TimerTick(mode)
" reltimestr() returns seconds.microseconds
  let l:now = str2float(reltimestr(reltime(s:timer_lasttime))) * 1000
  if l:now > s:timer_tick_ms
    let g:timer_ticks += 1
    let s:timer_lasttime = reltime()
    call TimerTickCallback(l:now)
  endif
  if (a:mode != '')
    call feedkeys(":\<CR>")
  endif
endfunction

if ! exists('*TimerTickCallback')
  function! TimerTickCallback(time)
  endfunction
endif
