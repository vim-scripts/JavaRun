" JavaRun.vim
" Kendrew Lau
"
" Script to save, compile, and run the Java program in current buffer.
" The saving and compilation are only done if necessary.
"
" To use it, source this script and do the command :JavaRun [arg...]
" where arg are optional arguments to the Java program to run

function! JavaRun(...)
	update
	let e = 0
	if getftime(expand("%:r") . ".class") < getftime(expand("%"))
		make
		let e = v:shell_error
	endif
	if e == 0
		let idx = 1
		let arg = ""
		while idx <= a:0
			execute "let a = a:" . idx
			let arg = arg . ' ' . a
			let idx = idx + 1
		endwhile
		execute "!java " . expand("%:r") . " " . arg
	endif
endfunction

set shellpipe=>\ %s\ 2>&1
set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

command! -nargs=* JavaRun call JavaRun(<f-args>)

