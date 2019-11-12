
" https://shapeshed.com/vim-statuslines/
function! s:git_branch() abort
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! statusline#lhs() abort
	return &modified ? '  + ' : '    '
endfunction

" Modified from https://github.com/wincent/wincent
" https://github.com/wincent/wincent/blob/b56f4cad2c5c073fd5db95a21b22b53d9574f0c7/roles/dotfiles/files/.vim/autoload/statusline.vim
function! statusline#rhs() abort
	let l:rhs = ''
	if winwidth(0) > 80
		let l:column = virtcol('.')
		let l:width = 3
		let l:line = line('.')
		let l:height = line('$')

		let l:padding = len(l:height) - len(l:line)
		if (l:padding)
			let l:rhs .= repeat(' ', l:padding)
		endif

		let l:rhs .= l:line
		let l:rhs .= ':'
		let l:rhs .= l:column
		let l:rhs .= ' '

		let l:padding = l:width - len(l:column)
		if len(l:padding) > 0
			let l:rhs .= repeat(' ', l:padding)
		endif
	endif
	return ' ' . l:rhs . ' '
endfunction

function! statusline#render(state) abort
	if &ft == "nerdtree"
		let &l:statusline = g:NERDTreeStatusline | return
	endif
	
	let l:active = a:state == 'active'

	let statusline=''
	let statusline.= l:active ? '%#StatuslineLHS#' : '%#StatuslineLHS_i#'
	let statusline.='%{statusline#lhs()}'
	let statusline.= l:active ? '%#StatuslineLHSArrow#' : '%#StatuslineDivider_i#'

	let statusline.= l:active ? '%#StatuslineFilename#' : '%#StatuslineFilename_i#'
	let statusline.=' %f '
	let statusline.='%([%R%W]%)'
	let statusline.='%='

	let statusline.= l:active ? '%#StatuslineEncodingArrow#' : '%#StatuslineDivider_i#'
	let statusline.= l:active ? '%#StatuslineEncoding#' : '%#StatuslineEncoding_i#'
	let statusline.=' %y'
	let statusline.=' %{&fileencoding?&fileencoding:&encoding}'
	let statusline.=' [%{&fileformat}] '

	let statusline.= l:active ? '%#StatuslineRHSArrow#' : '%#StatuslineDivider_i#'
	let statusline.= l:active ? '%#StatuslineRHS#' : '%#StatuslineRHS_i#'
	let statusline.=' %{statusline#rhs()}'

	" let l:branchname = s:git_branch()
	" if strlen(l:branchname) > 0
	" 	let statusline.= l:active ? '%#StatuslineGitArrow#' : '%#StatuslineDivider_i#'
	" 	let statusline.= l:active ? '%#StatuslineGit#' : '%#StatuslineGit_i#'
	" 	let statusline.=' ' . l:branchname . ' '
	" endif

	let &l:statusline=statusline
endfunction
