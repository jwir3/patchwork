{WorkspaceView} = require 'atom'
Patchwork = require '../lib/patchwork'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Patchwork", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('patchwork')

  describe "when the patchwork:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.patchwork')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'patchwork:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.patchwork')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'patchwork:toggle'
        expect(atom.workspaceView.find('.patchwork')).not.toExist()
