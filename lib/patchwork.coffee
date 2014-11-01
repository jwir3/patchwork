PatchworkView = require './patchwork-view'

module.exports =
  patchworkView: null

  activate: (state) ->
    @patchworkView = new PatchworkView(state.patchworkViewState)

  deactivate: ->
    @patchworkView.destroy()

  serialize: ->
    patchworkViewState: @patchworkView.serialize()
