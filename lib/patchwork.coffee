module.exports =
  class Patchwork
    enabled = false
    @activate: -> new Patchwork()
    constructor: ->
      # Create root element
      # @element = document.createElement('div')
      # @element.classList.add('patchwork',  'overlay', 'from-top')

      # Register command that toggles this view
      atom.commands.add 'atom-workspace', 'patchwork:toggle': => @toggle()

    # Returns an object that can be retrieved when package is activated
    # serialize: ->

    # Tear down any state and detach
    destroy: ->
      @element.remove()

    toggle: ->
      editor = atom.workspace.getActiveTextEditor()
      editorText = editor.getText()
      leadingPlusRe = /^(\s)*\+/mg;
      textWithoutPatch = editorText.replace(leadingPlusRe, "");
      editor.setText(textWithoutPatch)

  # serialize: ->
  #   patchworkViewState: @patchworkView.serialize()

  # isEnabled: ->
  #   return @patchworkView isEnabled
