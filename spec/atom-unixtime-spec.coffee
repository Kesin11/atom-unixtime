AtomUnixtime = require '../lib/atom-unixtime'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomUnixtime", ->
  [workspaceElement, activationPromise] = []
  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-unixtime')

  describe "when the 'atom-unixtime:show' event is triggered", ->
    it "should be notify notification", ->
      # add test for notification maybe
