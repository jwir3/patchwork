{WorkspaceView} = require 'atom'
Patchwork = require '../lib/patchwork'
fs = require 'fs'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.
describe 'Patchwork', ->

  [patchworkObj, helloWorldFile] = []
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.getModel()
    helloWorldFile = fs.readFileSync("spec/fixtures/helloworld.c", {encoding: 'UTF-8'})

    waitsForPromise ->
      atom.workspace.open('helloworld.c.patch')

    runs ->
      patchworkObj = Patchwork.activate()

  describe "when the patchwork package is loaded", ->
    it "should be able to read the fixture helloworld.c", ->
      expect(helloWorldFile).not.toBe(undefined)

  describe "when the patchwork package is loaded", ->
    it "creates a new Patchwork object which should not be enabled", ->
      expect(patchworkObj).not.toBe(undefined)

  describe "when the patchwork package is enabled", ->
    it "should make the Patchwork object enabled", ->
      atom.commands.dispatch atom.workspaceView.element, 'patchwork:toggle'
      expect(patchworkObj).not.toBe(undefined)

  describe "when the application is first loaded", ->
    it "opens the helloworld.c.patch file", ->
      lines = atom.workspace.getActiveTextEditor().getText().split('\n')

      # Lines 4 - 10 should be preceded by a +
      expect(lines[i][0]).toBe('+') for i in [3..9]

  describe "when the patchwork package is activated", ->
    it "should show the file helloworld.c being the same as helloworld.c.patch", ->
      atom.commands.dispatch atom.workspaceView.element, 'patchwork:toggle'
      patchLines = atom.workspace.getActiveTextEditor().getText().split('\n')
      expectedLines = helloWorldFile.split('\n')
      expect(patchLines.length).toBe(expectedLines.length)
      expect(patchLines[i]).toBe(expectedLines[i]) for i in [0..patchLines.length] by 1
