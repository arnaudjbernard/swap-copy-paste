module.exports =

  activate: (state) ->
    atom.workspaceView.command "swap-copy-paste:swap", => @swap()

  swap: ->
    # console.log "Swap copy paste!"

    editor = atom.workspace.activePaneItem
    if(editor)
      selection = editor.getSelection()
      selectedText = selection.getText()

      clipboard = atom.clipboard
      clipboardText = clipboard.read()

      clipboard.write(selectedText)
      selection.insertText(clipboardText)
