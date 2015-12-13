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

    # イベントを登録する
    # 表示したときにフォーカス、閉じたらエディタにフォーカス
  setPanel: (@panel) =>
    @subscriptions.add @panel.onDidChangeVisible (visible) =>
      if visible
        @focusMiniEditor()
      else
        atom.views.getView(atom.workspace).focus()

    @subscriptions.add atom.commands.add @element,
      'core:close': => @panel?.hide()
      'core:cancel': => @panel?.hide()

  focusMiniEditor: =>
    @miniEditor.focus()

  onConfirm: ->
    alert(@miniEditor.getText())

  # TEAR DOWN ANY STATE AND DETACH
  destroy: ->
    @subscriptions?.dispose()
    @div.remove()
