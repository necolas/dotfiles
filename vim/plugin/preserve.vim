" Preserve editor state when executing a command
function! Preserve(command)
    " Save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Execute the specified command
    execute a:command
    " Restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
