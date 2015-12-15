_ = require 'underscore-plus'
path = require 'path'

describe "InputPanelView", ->
  [workspaceElement, activationPromise, editor] = []
  # open project and fixture file
  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    atom.project.setPaths([path.join(__dirname, 'fixtures')])
    activationPromise = atom.packages.activatePackage('atom-unixtime')

    waitsForPromise ->
      atom.workspace.open('fixture.coffee')

    runs  ->
      jasmine.attachToDOM(workspaceElement)
      editor = atom.workspace.getActiveTextEditor()

  it "should not be inputPanelView exists in bottomPanel", ->
    # Before the activation event the view is not on the DOM
    expect(workspaceElement.querySelector('.input-block')).not.toExist()

  describe "when the 'atom-unixtime:Insert converted time' event is triggered", ->
    beforeEach ->
      # activate
      atom.commands.dispatch workspaceElement, 'atom-unixtime:Insert converted time'

      waitsForPromise ->
        activationPromise

    it "should be inputPanelView attached to bottomPanel", ->
      expect(workspaceElement.querySelector('.input-block')).toExist()

    it "should be visble inputBlockElement", ->
      inputBlockElement = workspaceElement.querySelector('.input-block')
      expect(inputBlockElement).toBeVisible()

    describe "when input text to inputView.miniEditor and confirm", ->
      unixtime = '1420038000'
      date_string = "2015-01-01 00:00:00"

      beforeEach ->
      # get miniEditor
        inputPanel = _.find(atom.workspace.getBottomPanels(), (panel) ->
          return panel.visible == true
        )
        inputView = inputPanel.item

        # input and confirm
        inputView.miniEditor.setText(date_string)
        atom.commands.dispatch inputView.miniEditor.element, 'core:confirm'

      it "should be written converted text in active editor", ->
        expect(editor.getText()).toEqual(unixtime)

      it "should be hide bottom panel after confirm", ->
        inputBlockElement = workspaceElement.querySelector('.input-block')
        expect(inputBlockElement).not.toBeVisible()
