set syntax=markdown

" Colors
highlight JrnlTag guifg=#F8CC7A
highlight JrnlTitle guifg=#66C9FF guibg=none gui=bold,underline
highlight JrnlDate guifg=#545454 guibg=none
highlight JrnlMarkdownBackticks guifg=#B282AF
highlight JrnlNope guifg=none guibg=none gui=none
highlight JrnlSpoilers guibg=#000000
highlight JrnlBoxEmpty guifg=#CBE697
highlight JrnlBoxActiveTitle guifg=#CBE697 gui=reverse
highlight JrnlBoxDone guifg=#545454 gui=strikethrough
highlight JrnlBoxQuestion guifg=#B283AF
highlight JrnlBoxInfo guifg=#9CDBFC
highlight JrnlBoxImportantTitle guifg=#EA9073 gui=bold,reverse
highlight JrnlBoxStarTitle guifg=#EEC476 gui=bold,reverse
highlight clear Conceal

" markdown headers sometimes conflict with jrnl tags
" syntax match JrnlMarkdownHeader '\v^(#|.+\n(\=+|-+)$)' contains=@markdownBase display
syntax match JrnlTag '\v(^|\s)@<=([@#%^+_])[^ @#%^+_.,]+' display
" syntax match jNumByNum /\v<\d+x\d+>/ contains=@NoSpell display


" Television Show format
" syntax match jseasoneptitle /s\d\de\d\d/ contains=@NoSpell contained display
" syntax match jseasonepbody /s\d\de\d\d/ contains=@NoSpell display

" Title line
syntax match JrnlTitle /\v(\[\d{4}(-\d\d){2} \d\d(:\d\d){1,2}( [aApP][mM])?\] )@<=.+( \*)@!/ contained display
syntax match JrnlTitleWithStar /\v(\[\d{4}(-\d\d){2} \d\d(:\d\d){1,2}( [aApP][mM])?\] )@<=.{-}( \*)@=/ contained display
syntax match JrnlDate /\v\[\d{4}(-\d\d){2} \d\d(:\d\d){1,2}( [aApP][mM])?\]/ contained conceal display cchar=📝
syntax match JrnlStar /\v\*$/ contained conceal cchar=⭐

highlight def link JrnlTitleWithStar JrnlTitle

syntax match NoSpellUrl '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
" syntax match NoSpellApostrophe '\'s' contains=@NoSpell
" syntax match JrnlLeadingWhiteSpace /\v^.{-}\] +/ contained
syntax match JrnlLeadingWhiteSpace /\v^\s+(- \[.\] +)@=/ contained

syntax region JrnlTitleLine
  \ start='\v^\[\d{4}(-\d\d){2} \d?\d(:[0-6]\d){1,2}( [apAP][mM])?\]'
  \ end=/\v( *)?$/
  \ display
  \ keepend
  \ contains=JrnlDate,JrnlTitle,JrnlTitleWithStar,JrnlStar,JrnlTag,Spell


" Todo Boxes
syntax match JrnlBoxDoneIcon /\v(^\s*)@<=- \[x\]/ conceal contained cchar=
syntax region JrnlBoxDone start=/^\v\z(\s+)*- \[[xc]\]\s+/ end=/\v^(\z1\s(\s+- \[ \])@!|$)@!/ contains=@Spell,JrnlBoxDoneIcon

syntax match JrnlBoxEmptyIcon /\v(^\s*)@<=- \[ \]/ conceal contained cchar=
syntax region JrnlBoxEmpty start=/^\v\s*- \[ \]\s+/ end=/$/ contains=@Spell,JrnlBoxEmptyIcon,JrnlTag

syntax match JrnlBoxActiveIcon /\v(^\s*)@<=- \[\.\]/ conceal contained cchar=
syntax match JrnlBoxActiveTitle /\v(- \[\.\] )@<=.+/ contained
syntax region JrnlBoxActive start=/^\v\s*- \[\.\] / end=/\v$/ contains=@Spell,JrnlBoxActiveTitle,JrnlBoxActiveIcon,JrnlLeadingWhiteSpace

syntax match JrnlBoxQuestionIcon /\v(^\s*)@<=- \[\?\]/ conceal contained cchar=
syntax region JrnlBoxQuestion start=/^\v\s*- \[\?\]\s+/ end=/$/ contains=@Spell,JrnlBoxQuestionIcon,JrnlTag

syntax match JrnlBoxInfoIcon /\v(^\s*)@<=- \[i\]/ conceal contained cchar=
syntax region JrnlBoxInfo start=/^\v\s*- \[i\]\s+/ end=/$/ contains=@Spell,JrnlBoxInfoIcon,,JrnlTag

syntax match JrnlBoxImportantIcon /\v(^\s*)@<=- \[!\]/ conceal contained cchar=
syntax match JrnlBoxImportantTitle /\v(^\s*- \[!\] )@<=.+/ contained
syntax region JrnlBoxImportant start=/\v^\s*- \[!\]\s+/ end=/$/ contains=@Spell,JrnlBoxImportantTitle,JrnlLeadingWhiteSpace,JrnlBoxImportantIcon

syntax match JrnlBoxStarIcon /\v(^\s*)@<=- \[\*\]/ conceal contained cchar=
syntax match JrnlBoxStarTitle /\v(- \[\*\] )@<=.+/
syntax region JrnlBoxStar start=/\v^\s*- \[\*\]/ end=/$/ contains=@Spell,JrnlBoxStarTitle,JrnlLeadingWhiteSpace,JrnlBoxStarIcon

" Bullets
syntax match JrnlBulletDash /\v(^\s*)@<=-/ conceal contained cchar=
syntax match JrnlBulletAsterisk /\v(^\s*)@<=\*/ conceal contained cchar=
syntax region JrnlBulletLine start=/\v^\s*[-*] (\[.\])@!/ end=/$/ contains=@Spell,JrnlBulletDash,JrnlBulletAsterisk,JrnlTag

" Spoilers
syntax region JrnlSpoilersStandard matchgroup=jspoilers start=/||/ end=/||/ concealends contains=@Spell,jseasonepbody

" highlight def link jlbracket JrnlDate
" highlight def link jseasoneptitle JrnlTitleLine
" highlight def link jspoilers JrnlSpoilers

" " Nopes
" " highlight def link jseasonepbody JrnlNope
highlight def link JrnlLeadingWhiteSpace JrnlNope
highlight def link JrnlActiveBoxIcon JrnlNope
