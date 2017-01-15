module.exports =

  activate: (state) ->
    atom.commands.add 'atom-workspace', 'swap-copy-paste:swap', => @swap()

  swap: ->
    # console.log "Swap copy paste!"

    editor = atom.workspace.getActiveTextEditor()
    if(editor)

      clipboard = atom.clipboard
      clipboardText = clipboard.read()

      for selection in editor.getSelections()
        selectedText = selection.getText()

        clipboard.write(selectedText)
        selection.insertText(clipboardText)
