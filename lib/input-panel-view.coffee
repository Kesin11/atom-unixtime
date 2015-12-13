{View, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'

module.exports =
class InputPanelView extends View
  @content: ->
    @div =>
      @div "Input Date or Timestamp"
      @subview 'miniEditor', new TextEditorView(mini: true, placeholderText: 'YYYY-MM-DD HH:mm:ss or timestamp')

  initialize: ->
    @subscriptions = new CompositeDisposable

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
    alert(@miniEditor.getText())
    @panel?.hide()

  # TEAR DOWN ANY STATE AND DETACH
  destroy: ->
    @subscriptions?.dispose()
    @panel.destroy()
