{View, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'
TimeConverter = require '../lib/time-converter'

module.exports =
class InputPanelView extends View
  @content: ->
    @div class: 'input-block', =>
      @div "Input Date or Timestamp"
      @subview 'miniEditor', new TextEditorView(mini: true, placeholderText: 'YYYY-MM-DD HH:mm:ss or timestamp')

  initialize: ->
    @subscriptions = new CompositeDisposable
    @minitEditor = null
    @panel = null
    @timeConverter = null

  # bind events
  setPanel: (@panel) =>
    # focus
    @subscriptions.add @panel.onDidChangeVisible (visible) =>
      if visible
        @focusMiniEditor()
      else
        atom.views.getView(atom.workspace).focus()

    # bind function to atom events
    @subscriptions.add atom.commands.add @miniEditor.element,
      'core:close': => @panel?.hide()
      'core:cancel': => @panel?.hide()
      'core:confirm': => @confirm()

  focusMiniEditor: =>
    @miniEditor.focus()

  confirm: ->
    unixtime_or_string = @miniEditor.getText()
    @insertConvertedTime(unixtime_or_string)
    @panel?.hide()

  # TEAR DOWN ANY STATE AND DETACH
  destroy: ->
    @subscriptions?.dispose()
    @panel.destroy()
    @timeConverer = null

  insertConvertedTime: (unixtime_or_string) ->
    textEditor = atom.workspace.getActiveTextEditor()
    @timeConverter = new TimeConverter.TimeConverter(unixtime_or_string)
    string = new String(@timeConverter.convert())
    textEditor.insertText(string, autoIndent: true, autoIndentNewline: true)
