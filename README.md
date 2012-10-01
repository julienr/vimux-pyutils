Vimux-pyutils
=============

This is a vim bundle containing some additional, python-specific, functions
on top of vimux :
https://github.com/benmills/vimux/

This plugin allow to select a block of python code in vim and send it to the
vimux tmux split. The assumption is that ipython (or python) is running in said
tmux split and this allow to execute a file chunk-by-chunk.

This is somewhat similar to the code block execution that can be found in
scientific software (for example Matlab).

Keys mapping
-----------
By default, the following mappings are enabled :

* *C-c* will paste and execute the currently selected block in ipython
* *C-b* will execute the current cell in ipython
  A cell is similar to MATLAB's cell and is defined as the line ranging from
  the previous ## to the next ##

Options
-------
If you set *vimux_pyutils_use_tslime* to 1 in your vimrc, this script will use
tslime instead of vimux. This has the advantage that the script will work
from outside a tmux session (in GVim for example).

Note that tslime has to be configured to target the correct session/pane :

    let g:tmux_sessionname='0'
    let g:tmux_windowname='./ipython.sh'
    let g:tmux_panenumber='0'

    let g:vimux_pyutils_use_tslime=1

Difference with vim-ipython
---------------------------
Note that if you want more advanced integration with IPython (using the new
multi-client architecture), there is the vim-ipython project :
https://github.com/ivanov/vim-ipython/

The main difference with vim-ipython is that this plugin simply emulate a paste
as you would do it manually from vim to ipython. This allow to see the result
of the execution directly in the ipython split whereas vim-ipython uses a
separate vim buffer to show the results.

