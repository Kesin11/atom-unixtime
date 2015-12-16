AtomUnixtimeView = require './atom-unixtime-view'
InputPanelView = require './input-panel-view.coffee'
{CompositeDisposable, Notification} = require 'atom'
{TimeConverter} = require '../lib/time-converter'

module.exports = AtomUnixtime =
  atomUnixtimeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomUnixtimeView = new AtomUnixtimeView(state.atomUnixtimeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomUnixtimeView.getElement(), visible: false)

    @inputPanelView = new InputPanelView()
    @inputPanel = atom.workspace.addBottomPanel(item: @inputPanelView, visible:false)
    @inputPanelView.setPanel(@inputPanel)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:Show converted time': =>
      @convert_time()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-unixtime:Insert converted time': =>
      @input_time()

    @editor = atom.workspace.getActiveTextEditor()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomUnixtimeView.destroy()
    @inputPanelView.destroy()

  serialize: ->
    atomUnixtimeViewState: @atomUnixtimeView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  convert_time: ->
    unixtime_or_string = @editor?.getSelectedText()
    @timeConverter = new TimeConverter(unixtime_or_string)
    converted_text = @timeConverter.convert()

    return atom.notifications.addInfo(converted_text.toString()) if converted_text
    return atom.notifications.addError("Cannot convert '#{unixtime_or_string}'. Please select unixtime_or_string")

  input_time: ->
    @inputPanel.show()
