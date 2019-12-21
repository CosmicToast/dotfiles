bind -T copy-mode    MouseDragEnd1Pane send -X copy-pipe-and-cancel "xsel -ib"
bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "xsel -ib"

bind -n M-C-v run "xsel -ob | tmux load-buffer -; tmux paste-buffer"

# vim: ft=tmux
