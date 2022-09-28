setlocal textwidth=88
setlocal spell
setlocal conceallevel=2

function! JrnlFolds()
  let line = getline(v:lnum)
  if match(line, '\v^\s*#/-+/?#?\s*$') >= 0
    return "s1"
  elseif match(line, '\v^\s*#-+#?\s*$') >= 0
    return "a1"
  elseif match(line, '\v^\s*#{5} ') >= 0
    return ">6"
  elseif match(line, '\v^\s*#{4} ') >= 0
    return ">5"
  elseif match(line, '\v^\s*#{3} ') >= 0
    return ">4"
  elseif match(line, '\v^\s*#{2} ') >= 0
    return ">3"
  elseif match(line, '\v^(\s*# |\*{1,2})') >= 0
    return ">2"
  elseif match(line, '\v^\[\d{4}(-\d\d){2} \d?\d(:[0-6]\d){1,2}( [apAP][mM])?\] ') >= 0
    return ">1"
  else
    return "="
  endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=JrnlFolds()
