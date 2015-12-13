AtomUnixtimeView = require './atom-unixtime-view'
InputPanelView = require './input-panel-view.coffee'
{CompositeDisposable} = require 'atom'

module.exports = AtomUnixtime =
  atomUnixtimeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomUnixtimeView = new AtomUnixtimeView(state.atomUnixtimeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomUnixtimeView.getElement(), visible: false)

    @inputPanelView = new InputPanelView()
    @inputPanel = atom.workspace.addBottomPanel(item: @inputPanelView, visible:false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:convert_time': =>
      @convert_time()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:input_time': =>
      @input_time()

    @editor = atom.workspace.getActiveTextEditor()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomUnixtimeView.destroy()

  serialize: ->
    atomUnixtimeViewState: @atomUnixtimeView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  convert_time: ->
    @atomUnixtimeView.setTime(@editor?.getSelectedText())
    @toggle()

  input_time: ->
    @inputPanelView.setPanel(@inputPanel)
    @inputPanel.show()
