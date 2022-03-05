setlocal syntax=markdown
setlocal textwidth=88
setlocal spell

highlight JrnlTag guifg=#F8CC7A
highlight JrnlEntryLine guifg=#66C9FF guibg=none gui=bold,underline
highlight JrnlDate guifg=#545454 guibg=none
highlight JrnlNope guifg=none guibg=none gui=none
highlight JrnlSpoilers guibg=#000000
highlight JrnlBoxEmpty guifg=#CBE697 guibg=none
highlight JrnlBoxActive guifg=#CBE697 gui=reverse guibg=none
highlight JrnlBoxDone guifg=#545454 gui=strikethrough guibg=none
highlight JrnlBoxQuestion guifg=#B283AF guibg=none
highlight JrnlBoxInfo guifg=#9CDBFC guibg=none
highlight JrnlBoxImportant guifg=#EA9073 gui=bold,reverse guibg=none
highlight JrnlBoxStar guifg=#EEC476 gui=bold,reverse guibg=none

syntax match JrnlTag /[@#^+%][^@#^+%.:;, ]\+/ display
syntax match JrnlSeasonEpTitle /s\d\de\d\d/ contains=@NoSpell contained display
syntax match JrnlSeasonEpBody /s\d\de\d\d/ contains=@NoSpell display
syntax match JrnlNumByNum /\v<\d+x\d+>/ contains=@NoSpell display
syntax match JrnlBracket /\v[\[\]]/ contained conceal display
syntax match JrnlDate /\v\[\d{4}(-\d\d){2} \d\d(:\d\d){1,2}( [aApP][mM])?\] / contained conceal display
syntax match NoSpellUrl '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
syntax match NoSpellApostrophe '\'s' contains=@NoSpell
syntax match JrnlLeadingWhitespace /\v^.{-}\] +/ contained

syntax region JrnlEntryLine start='\v^\[\d{4}(-\d\d){2} \d?\d(:[0-6]\d){1,2}( [apAP][mM])?\]' end=/$/ display
  \ contains=JrnlDate,JrnlSeasonEpTitle,JrnlTag,Spell
syntax region JrnlBoxDone start=/^\v\z(\s+)*- \[[xc]\]\s+/ end=/\v^(\z1\s(\s+- \[ \])@!|$)@!/
syntax region JrnlBoxEmpty start=/^\v\s*- \[ \]\s+/ end=/$/
syntax region JrnlBoxActive start=/^\v\s*- \[\.\]\s+/ end=/$/ contains=JrnlLeadingWhitespace
syntax region JrnlBoxQuestion start=/^\v\s*- \[\?\]\s+/ end=/$/
syntax region JrnlBoxInfo start=/^\v\s*- \[i\]\s+/ end=/$/
syntax region JrnlBoxImportant start=/\v^\s*- \[!\]\s+/ end=/$/ contains=JrnlLeadingWhitespace
syntax region JrnlBoxStar start=/\v^\s*- \[\*\]/ end=/$/ contains=JrnlLeadingWhitespace
syntax region JrnlSpoilers matchgroup=JrnlSpoilersGroup start=/||/ end=/||/ concealends contains=@Spell,JrnlSeasonEpBody

highlight def link JrnlBracket JrnlDate
highlight def link JrnlSeasonEpTitle JrnlEntryLine
highlight def link JrnlSpoilersGroup JrnlSpoilers
highlight def link NoSpellUrl markdownURL

" Nopes
" highlight def link JrnlSeasonEpBody JrnlNope
highlight def link JrnlLeadingWhitespace JrnlNope

" These get overridden by indentLine, so we need matchadd
call matchadd('Conceal', '- \[ \]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[x\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[?\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[!\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[c\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[i\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[\.\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '- \[\*\]', 10, -1, { 'conceal': ''})
call matchadd('Conceal', '^\s*\zs-\ze [^\[]', 10, -1, { 'conceal': ''})

function! JrnlFolds()
  let line = getline(v:lnum)
  if match(line, '\v^#/-+/?#?\s*$') >= 0
    return "s1"
  elseif match(line, '\v^#-+#?\s*$') >= 0
    return "a1"
  elseif match(line, '\v^#{5} ') >= 0
    return ">6"
  elseif match(line, '\v^#{4} ') >= 0
    return ">5"
  elseif match(line, '\v^#{3} ') >= 0
    return ">4"
  elseif match(line, '\v^#{2} ') >= 0
    return ">3"
  elseif match(line, '\v^# ') >= 0
    return ">2"
  elseif match(line, '\v^\[\d{4}(-\d\d){2} \d?\d(:[0-6]\d){1,2}( [apAP][mM])?\] ') >= 0
    return ">1"
  else
    return "="
  endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=JrnlFolds()
