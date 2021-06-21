
function plugins#subsystems#setup()

  Plug 'mbbill/undotree'
  " See undo history
    nnoremap <C-w>u :UndotreeToggle<cr>:UndotreeFocus<cr>

  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Fuzzy finder

    let g:fzf_preview_window = 'right:60%'

    " Redefine :Rg, but using word under cursor if no args are given
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(len(<q-args>)?<q-args>:expand('<cword>')), 1,
      \   fzf#vim#with_preview(), <bang>0)
    command! -bang -nargs=* RG
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(len(<q-args>)?<q-args>:expand('<cword>')), 1,
      \   fzf#vim#with_preview(), <bang>0)

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    " Insert mode completion (overriding vim mappings)
    imap <C-x><C-k> <plug>(fzf-complete-word)
    imap <C-x><C-f> <plug>(fzf-complete-path)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    command! FZHere call fzf#run(fzf#wrap({'dir': expand('%:h')}))

    " Normal mode mappings (with mnemonics)
      let g:which_key_map[';'] = { 'name': '+fzf' }

      " Ripgrep (under cursor)
      nmap <leader>;r :Rg<CR>
      let g:which_key_map[';']['r'] = 'fzf-ripgrep'

      " Ripgrep live (starting with word under cursor)
      nmap <leader>;R :call RipgrepFzf(expand('<cword>'), 0)<CR>
      let g:which_key_map[';']['R'] = 'fzf-ripgrep-live'

      " Files
      nmap <leader>;f :Files<CR>
      let g:which_key_map[';']['f'] = 'fzf-files'

      " Git files
      nmap <leader>;F :GFiles<CR>
      let g:which_key_map[';']['F'] = 'fzf-git-files'

      " Here (like Files/:FZF, but relative to directory of current file)
      nmap <leader>;H :call fzf#run(fzf#wrap({'dir': expand('%:h')}))<CR>
      let g:which_key_map[';']['H'] = 'fzf-files-here'

      " Git commits (current buffer only)
      nmap <leader>;g :BCommits<CR>
      let g:which_key_map[';']['g'] = 'fzf-git-commits-buffer'

      " Git commits
      nmap <leader>;G :Commits<CR>
      let g:which_key_map[';']['G'] = 'fzf-git-commits'

      " Buffers (and history)
      nmap <leader>;h :History<CR>
      let g:which_key_map[';']['h'] = 'fzf-history-buffers'

      " Buffers
      nmap <leader>;b :Buffers<CR>
      let g:which_key_map[';']['b'] = 'fzf-buffers'

      " Lines
      nmap <leader>;l :Lines<CR>
      let g:which_key_map[';']['l'] = 'fzf-lines'

      " Lines (current buffer only)
      nmap <leader>;L :BLines<CR>
      let g:which_key_map[';']['L'] = 'fzf-buffer-lines'

      " Command history
      nmap <leader>;: :History:<CR>
      let g:which_key_map[';'][':'] = 'fzf-history-:'
      nmap <leader>;; :History:<CR>
      let g:which_key_map[';'][';'] = 'fzf-history-:'

      " Search history
      nmap <leader>;/ :History/<CR>
      let g:which_key_map[';']['/'] = 'fzf-history-/'


  Plug 'https://gitlab.com/mcepl/vim-fzfspell.git'
  " FZF for z=

  Plug 'junegunn/vim-peekaboo'
  " See yank registers

  Plug 'tpope/vim-fugitive'
  " Git interaction
    let g:which_key_map['g'] = { 'name': '+git' }

    nnoremap <leader>gd :Gdiffsplit<CR>
    let g:which_key_map['g']['d'] = 'git-diff-split'
    nnoremap <leader>gD :Git diff --cached<CR>
    let g:which_key_map['g']['D'] = 'git-diff-cached'
    nnoremap <leader>gp :Git pull<CR>
    let g:which_key_map['g']['p'] = 'git-pull'
    nnoremap <leader>gP :Git push<CR>
    let g:which_key_map['g']['P'] = 'git-push'
    nnoremap <leader>gl :Gclog<CR>
    let g:which_key_map['g']['l'] = 'git-log'
    nnoremap <leader>gc :Git commit<CR>
    let g:which_key_map['g']['c'] = 'git-commit'
    nnoremap <leader>gs :Git<CR>
    let g:which_key_map['g']['s'] = 'git-status'

    augroup fugitive_maps
      autocmd!
      autocmd Filetype fugitive,git nmap <buffer> q gq
    augroup END

  Plug 'rhysd/git-messenger.vim'
  " Super-charged git blame
    let g:git_messenger_no_default_mappings = v:true
    nmap <leader>gb <Plug>(git-messenger)
    let g:which_key_map['g']['b'] = 'git-blame'

  Plug 'preservim/tagbar'
  " Outline by tags

  Plug 'cosminadrianpopescu/vim-tail'
  " Make vim behave like tail -f

  Plug 'itchyny/calendar.vim'
  " Calendar app in Vim

  Plug 'liuchengxu/vim-which-key'
    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
    function s:WhichKeyHooks()
      call which_key#register('<Space>', "g:which_key_map")
    endfunction

  return [function('s:WhichKeyHooks')]
endfunction
