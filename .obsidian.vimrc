" Let mapleader be space character.
" You can't set leaders in Obsidian vim, so the key just has to be used consistently.
" However, it needs to be unmapped, to not trigger default behavior:
" https://github.com/esm7/obsidian-vimrc-support#some-help-with-binding-space-chords-doom-and-spacemacs-fans
unmap <Space>
unmap <C-n>

" Yank to system clipboard
set clipboard=unnamed

" Highlights
nnoremap <Space>n :noh<CR> " Undo highlight

" Editing
inoremap <C-s> <ESC>:w<CR> " Save file in insert mode
nnoremap <C-s> :w<CR> " Save file in normal mode
nnoremap <C-a> ggVG " Select all
nnoremap <yy> Vy " Select line
nnoremap Y y$ " Make Y behave like C and D

exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

exmap lsidebar obcommand app:toggle-left-sidebar
nmap <C-n> :lsidebar<CR>
exmap rsidebar obcommand app:toggle-right-sidebar
nmap <C-A-n> :rsidebar<CR>

nmap <Space>h :obcommand<space>workspace:split-horizontal<CR>
nmap <Space>v :obcommand<space>workspace:split-vertical<CR>


" filesearch
exmap fuzzyfind obcommand switcher:open
nmap <Space>ff :fuzzyfind<CR>



" integrating gx,gf,gd for vim {my way.. ok}
exmap followBothLinksAndNotes obcommand editor:follow-link
exmap openDefinitionSplit obcommand editor:open-link-in-new-split
exmap openNoteInNewTab obcommand editor:open-link-in-new-leaf
nmap gx :followBothLinksAndNotes
nmap gf :followBothLinksAndNotes
nmap gd :openDefinitionSplit
nmap gn :openNoteInNewTab


" focus
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusBottom obcommand editor:focus-bottom
exmap focusTop obcommand editor:focus-top
nmap <C-w>h :focusLeft
nmap <C-w>l :focusRight
nmap <C-w>j :focusBottom
nmap <C-w>k :focusTop


" complete a Markdown task
exmap toggleTask obcommand editor:toggle-checklist-status
nmap ,x :toggleTask

" Navigation
" imap jj <Esc>
" nnoremap <C-j> 10j
" nnoremap <C-k> 10k
" nnoremap <C-h> b
" nnoremap <C-l> w
" nnoremap H ^
" nnoremap L g_

" Visual lines
nmap j gj
nmap k gk
nmap ; :
nnoremap I g0i
nnoremap A g$a

" "Exmap" mappings
" (make sure to remove default Obsidian shortcuts for these to work!)

" Emulate Tab Switching
exmap closeWin obcommand workspace:close-window
nmap <Space>Q :closeWin<CR>
exmap closeTab obcommand workspace:close
nmap <Space>x :closeTab<CR>
exmap newTab obcommand file-explorer:new-file
nmap <Space>b :newTab<CR>

" the next two require Pane Relief: https://github.com/pjeby/pane-relief
exmap tabnext obcommand workspace:next-tab
nmap L :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap H :tabprev<CR>

" Leap-like functionality
" requires https://github.com/mrjackphil/obsidian-jump-to-link
exmap jumpto obcommand mrj-jump-to-link:activate-jump-to-anywhere
nmap s :jumpto<CR>


" plugin:obsidian-vimrc-support:926 Available commands: editor:save-file
" editor:download-attachments
" editor:follow-link
" editor:open-link-in-new-leaf
" editor:open-link-in-new-window
" workspace:toggle-pin
" editor:open-link-in-new-split
" editor:focus-top
" editor:focus-bottom
" editor:focus-left
" editor:focus-right
" workspace:split-vertical
" workspace:split-horizontal
" workspace:toggle-stacked-tabs
" workspace:edit-file-title
" workspace:copy-path
" workspace:copy-url
" workspace:undo-close-pane
" workspace:export-pdf
" editor:rename-heading
" workspace:open-in-new-window
" workspace:move-to-new-window
" workspace:next-tab
" workspace:goto-tab-1
" workspace:goto-tab-2
" workspace:goto-tab-3
" workspace:goto-tab-4
" workspace:goto-tab-5
" workspace:goto-tab-6
" workspace:goto-tab-7
" workspace:goto-tab-8
" workspace:goto-last-tab
" workspace:previous-tab
" workspace:new-tab
" workspace:new-window
" workspace:close
" workspace:close-window
" workspace:close-others
" workspace:close-tab-group
" workspace:close-others-tab-group
" workspace:show-trash
" app:go-back
" app:go-forward
" app:open-vault
" theme:toggle-light-dark
" theme:switch
" app:open-settings
" app:show-release-notes
" markdown:toggle-preview
" markdown:add-metadata-property
" markdown:add-alias
" markdown:clear-metadata-properties
" app:delete-file
" app:toggle-ribbon
" editor:toggle-readable-line-length
" app:toggle-left-sidebar
" app:toggle-right-sidebar
" app:toggle-default-new-pane-mode
" app:open-help
" app:reload
" app:show-debug-info
" app:open-sandbox-vault
" window:toggle-always-on-top
" window:zoom-in
" window:zoom-out
" window:reset-zoom
" file-explorer:new-file
" file-explorer:new-file-in-current-tab
" file-explorer:new-file-in-new-pane
" open-with-default-app:open
" file-explorer:move-file
" file-explorer:duplicate-file
" open-with-default-app:show
" editor:toggle-source
" editor:open-search
" editor:open-search-replace
" editor:focus
" editor:toggle-fold-properties
" editor:toggle-fold
" editor:fold-all
" editor:unfold-all
" editor:fold-less
" editor:fold-more
" editor:insert-wikilink
" editor:insert-embed
" editor:insert-link
" editor:insert-tag
" editor:set-heading
" editor:set-heading-0
" editor:set-heading-1
" editor:set-heading-2
" editor:set-heading-3
" editor:set-heading-4
" editor:set-heading-5
" editor:set-heading-6
" editor:toggle-bold
" editor:toggle-italics
" editor:toggle-strikethrough
" editor:toggle-highlight
" editor:toggle-code
" editor:toggle-inline-math
" editor:toggle-blockquote
" editor:toggle-comments
" editor:clear-formatting
" editor:toggle-bullet-list
" editor:toggle-numbered-list
" editor:toggle-checklist-status
" editor:cycle-list-checklist
" editor:insert-callout
" editor:insert-codeblock
" editor:insert-horizontal-rule
" editor:insert-mathblock
" editor:insert-table
" editor:insert-footnote
" editor:indent-list
" editor:unindent-list
" editor:swap-line-up
" editor:swap-line-down
" editor:attach-file
" editor:delete-paragraph
" editor:add-cursor-below
" editor:add-cursor-above
" editor:toggle-spellcheck
" editor:table-row-before
" editor:table-row-after
" editor:table-row-up
" editor:table-row-down
" editor:table-row-copy
" editor:table-row-delete
" editor:table-col-before
" editor:table-col-after
" editor:table-col-left
" editor:table-col-right
" editor:table-col-copy
" editor:table-col-delete
" editor:table-col-align-left
" editor:table-col-align-center
" editor:table-col-align-right
" editor:context-menu
" file-explorer:open
" file-explorer:reveal-active-file
" file-explorer:new-folder
" global-search:open
" switcher:open
" graph:open
" graph:open-local
" graph:animate
" backlink:open
" backlink:open-backlinks
" backlink:toggle-backlinks-in-document
" canvas:new-file
" canvas:export-as-image
" canvas:jump-to-group
" canvas:convert-to-file
" outgoing-links:open
" outgoing-links:open-for-current
" tag-pane:open
" daily-notes
" daily-notes:goto-prev
" daily-notes:goto-next
" insert-template
" insert-current-date
" insert-current-time
" note-composer:merge-file
" note-composer:split-file
" note-composer:extract-heading
" command-palette:open
" bookmarks:open
" bookmarks:bookmark-current-view
" bookmarks:bookmark-current-search
" bookmarks:unbookmark-current-view
" bookmarks:bookmark-current-section
" bookmarks:bookmark-current-heading
" bookmarks:bookmark-all-tabs
" outline:open
" outline:open-for-current
" file-recovery:open
" bases:new-file
" bases:insert
" bases:copy-table
" bases:change-view
" bases:add-view
" bases:add-item
" plugin:obsidian-vimrc-support:927 Uncaught (in promise) Error: obcommand requires exactly 1 parameter
"     at Object.eval [as obcommand] (plugin:obsidian-vimrc-support:927:23)
"     at ExCommandDispatcher._processCommand (vim.js:5147:34)
"     at vim.js:5093:16
"     at e.operation (app.js:1:1608872)
"     at ExCommandDispatcher.processCommand (vim.js:5091:12)
"     at onPromptClose (vim.js:1642:31)
"     at HTMLInputElement.<anonymous> (app.js:1:1614230)
" plugin:obsidian-vimrc-support:926 Available commands: editor:save-file
" editor:download-attachments
" editor:follow-link
" editor:open-link-in-new-leaf
" editor:open-link-in-new-window
" workspace:toggle-pin
" editor:open-link-in-new-split
" editor:focus-top
" editor:focus-bottom
" editor:focus-left
" editor:focus-right
" workspace:split-vertical
" workspace:split-horizontal
" workspace:toggle-stacked-tabs
" workspace:edit-file-title
" workspace:copy-path
" workspace:copy-url
" workspace:undo-close-pane
" workspace:export-pdf
" editor:rename-heading
" workspace:open-in-new-window
" workspace:move-to-new-window
" workspace:next-tab
" workspace:goto-tab-1
" workspace:goto-tab-2
" workspace:goto-tab-3
" workspace:goto-tab-4
" workspace:goto-tab-5
" workspace:goto-tab-6
" workspace:goto-tab-7
" workspace:goto-tab-8
" workspace:goto-last-tab
" workspace:previous-tab
" workspace:new-tab
" workspace:new-window
" workspace:close
" workspace:close-window
" workspace:close-others
" workspace:close-tab-group
" workspace:close-others-tab-group
" workspace:show-trash
" app:go-back
" app:go-forward
" app:open-vault
" theme:toggle-light-dark
" theme:switch
" app:open-settings
" app:show-release-notes
" markdown:toggle-preview
" markdown:add-metadata-property
" markdown:add-alias
" markdown:clear-metadata-properties
" app:delete-file
" app:toggle-ribbon
" editor:toggle-readable-line-length
" app:toggle-left-sidebar
" app:toggle-right-sidebar
" app:toggle-default-new-pane-mode
" app:open-help
" app:reload
" app:show-debug-info
" app:open-sandbox-vault
" window:toggle-always-on-top
" window:zoom-in
" window:zoom-out
" window:reset-zoom
" file-explorer:new-file
" file-explorer:new-file-in-current-tab
" file-explorer:new-file-in-new-pane
" open-with-default-app:open
" file-explorer:move-file
" file-explorer:duplicate-file
" open-with-default-app:show
" editor:toggle-source
" editor:open-search
" editor:open-search-replace
" editor:focus
" editor:toggle-fold-properties
" editor:toggle-fold
" editor:fold-all
" editor:unfold-all
" editor:fold-less
" editor:fold-more
" editor:insert-wikilink
" editor:insert-embed
" editor:insert-link
" editor:insert-tag
" editor:set-heading
" editor:set-heading-0
" editor:set-heading-1
" editor:set-heading-2
" editor:set-heading-3
" editor:set-heading-4
" editor:set-heading-5
" editor:set-heading-6
" editor:toggle-bold
" editor:toggle-italics
" editor:toggle-strikethrough
" editor:toggle-highlight
" editor:toggle-code
" editor:toggle-inline-math
" editor:toggle-blockquote
" editor:toggle-comments
" editor:clear-formatting
" editor:toggle-bullet-list
" editor:toggle-numbered-list
" editor:toggle-checklist-status
" editor:cycle-list-checklist
" editor:insert-callout
" editor:insert-codeblock
" editor:insert-horizontal-rule
" editor:insert-mathblock
" editor:insert-table
" editor:insert-footnote
" editor:indent-list
" editor:unindent-list
" editor:swap-line-up
" editor:swap-line-down
" editor:attach-file
" editor:delete-paragraph
" editor:add-cursor-below
" editor:add-cursor-above
" editor:toggle-spellcheck
" editor:table-row-before
" editor:table-row-after
" editor:table-row-up
" editor:table-row-down
" editor:table-row-copy
" editor:table-row-delete
" editor:table-col-before
" editor:table-col-after
" editor:table-col-left
" editor:table-col-right
" editor:table-col-copy
" editor:table-col-delete
" editor:table-col-align-left
" editor:table-col-align-center
" editor:table-col-align-right
" editor:context-menu
" file-explorer:open
" file-explorer:reveal-active-file
" file-explorer:new-folder
" global-search:open
" switcher:open
" graph:open
" graph:open-local
" graph:animate
" backlink:open
" backlink:open-backlinks
" backlink:toggle-backlinks-in-document
" canvas:new-file
" canvas:export-as-image
" canvas:jump-to-group
" canvas:convert-to-file
" outgoing-links:open
" outgoing-links:open-for-current
" tag-pane:open
" daily-notes
" daily-notes:goto-prev
" daily-notes:goto-next
" insert-template
" insert-current-date
" insert-current-time
" note-composer:merge-file
" note-composer:split-file
" note-composer:extract-heading
" command-palette:open
" bookmarks:open
" bookmarks:bookmark-current-view
" bookmarks:bookmark-current-search
" bookmarks:unbookmark-current-view
" bookmarks:bookmark-current-section
" bookmarks:bookmark-current-heading
" bookmarks:bookmark-all-tabs
" outline:open
" outline:open-for-current
" file-recovery:open
" bases:new-file
" bases:insert
" bases:copy-table
" bases:change-view
" bases:add-view
" bases:add-item
