hi StatusLine    ctermfg=15 ctermbg=236 cterm=NONE
hi StatusLineNC  ctermfg=15 ctermbg=235 cterm=NONE

" TODO
" Find a way to set hi User1..9 on BufEnter/BufLeave
" active colors
hi StatuslineLHS ctermfg=236 ctermbg=06
hi StatuslineLHSArrow ctermfg=06 ctermbg=236
hi StatuslineFilename ctermfg=05 ctermbg=236
hi StatuslineEncodingArrow ctermfg=04 ctermbg=236
hi StatuslineEncoding ctermfg=236 ctermbg=04
hi StatuslineRHSArrow ctermfg=03 ctermbg=04
hi StatuslineRHS ctermfg=236 ctermbg=03
hi StatuslineGitArrow ctermfg=02 ctermbg=03
hi StatuslineGit ctermfg=236 ctermbg=02

" inactive colors
hi StatuslineDivider_i ctermfg=08 ctermbg=235
hi StatuslineLHS_i ctermfg=06 ctermbg=235
hi StatuslineFilename_i ctermfg=05 ctermbg=235
hi StatuslineEncoding_i ctermfg=04 ctermbg=235
hi StatuslineRHS_i ctermfg=03 ctermbg=235
hi StatuslineGit_i ctermfg=02 ctermbg=235

if has('autocmd')
	augroup Statusline
		autocmd!
		autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter * call statusline#render('active')
		autocmd BufLeave,BufWinLeave,WinLeave,CmdwinLeave * call statusline#render('inactive')
	augroup END
endif

call statusline#render('active')
