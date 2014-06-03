{WorkspaceView} = require 'atom'
SwapCopyPaste = require '../lib/swap-copy-paste'

describe "SwapCopyPaste", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspace = atom.workspaceView.model
    activationPromise = atom.packages.activatePackage('swap-copy-paste')
    waitsForPromise ->
      atom.workspace.open()

  describe "when the swap-copy-paste:swap event is triggered", ->
    it "swaps current clipboard content with selection", ->

      editor = atom.workspaceView.getActivePaneItem()
      editor.setText("selectionText")

      selection = editor.getSelection()
      selection.selectAll()
      expect(selection.getText()).toBe "selectionText"

      clipboard = atom.clipboard
      clipboard.write("clipboardText")
      expect(atom.clipboard.read()).toBe "clipboardText"

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'swap-copy-paste:swap'

      waitsForPromise ->
        activationPromise

      expect(editor.getText()).toBe "clipboardText"

      expect(atom.clipboard.read()).toBe "selectionText"
