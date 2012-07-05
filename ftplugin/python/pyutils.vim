if !has('python')
  finish
endif

python << endpython
import re

# http://stackoverflow.com/questions/2695443/can-you-access-registers-from-python-functions-in-vim
def set_register(reg, value):
  vim.command("let @%s='%s'" % (reg, value.replace("'","''")))

def run_tmux_python_chunk():
  """
  Will copy/paste the currently selected block into the tmux split.
  The code is unindented so the first selected line has 0 indentation
  So you can select a statement from inside a function and it will run
  without python complaining about indentation.
  """
  r = vim.current.range
  # Count indentation on first selected line
  firstline = vim.current.buffer[r.start]
  nindent = 0
  for i in xrange(0, len(firstline)):
    if firstline[i] == ' ':
      nindent += 1
    else:
      break
  #vim.command("echo '%i'" % nindent)

  # Shift the whole text by nindent spaces (so the first line has 0 indent)
  lines = vim.current.buffer[r.start:r.end+1]
  pat = '\s'*nindent
  lines = "\n".join([re.sub('^%s'%pat, '', l) for l in lines])

  # Add empty newline at the end
  lines += "\n\n"

  # Now, there are multiple solutions to copy that to tmux

  # 1. With cpaste
  #vim.command(':call VimuxRunCommand("%cpaste\n", 0)')
  #vim.command(':call VimuxRunCommand("%s", 0)' % lines)
  #vim.command(':call VimuxRunCommand("\n--\n", 0)')

  # 2. With cpaste (better, only one command, but rely on system clipboard)
  set_register('+', lines)
  vim.command(':call VimuxRunCommand("%paste\n", 0)')

  # 3. Directly send the raw text to vimux. This require that we add
  # indentation to blank lines : otherwise, this will break the input if
  # we have something like :
  # def foo():
  #   print 'blah'
  #                          <--- Shit will happen here
  #   print 'bouh'
  # TODO:


endpython

vmap <silent> <C-c> :python run_tmux_python_chunk()<CR>

