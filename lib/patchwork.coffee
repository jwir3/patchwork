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
      textLines = textWithoutPatch.split('\n')
      finalLines = []

      ###
      We don't worry about the newline at the end of the file - atom always
      puts in a trailing newline, so we just skip it.
      ###
      for i in [0..textLines.length-1] by 1
        if !textLines[i] || textLines[i].search(/^(\s)*-(.*)$/g) == -1
          finalLines.push(textLines[i])

      editor.setText(finalLines.join('\n'))
