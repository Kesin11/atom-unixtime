AtomUnixtimeView = require './atom-unixtime-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomUnixtime =
  atomUnixtimeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomUnixtimeView = new AtomUnixtimeView(state.atomUnixtimeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomUnixtimeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomUnixtimeView.destroy()

  serialize: ->
    atomUnixtimeViewState: @atomUnixtimeView.serialize()

  toggle: ->
    console.log 'AtomUnixtime was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
