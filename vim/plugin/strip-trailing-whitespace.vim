" Strip trailing whitespace
function! StripTrailingWhitespace()
    call Preserve("%s/\\s\\+$//e")
endfunction
