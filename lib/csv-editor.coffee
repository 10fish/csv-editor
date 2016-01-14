CsvEditorView = require './csv-editor-view'
{CompositeDisposable} = require 'atom'

module.exports = CsvEditor =
  csvEditorView: null
  floatPanel: null
  subscriptions: null

  activate: (state) ->
    @csvEditorView = new CsvEditorView(state.csvEditorViewState)
    @floatPanel = atom.workspace.addModalPanel(item: @csvEditorView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'csv-editor:toggle': => @toggle()

  deactivate: ->
    @floatPanel.destroy()
    @subscriptions.dispose()
    @csvEditorView.destroy()

  serialize: ->
    csvEditorViewState: @csvEditorView.serialize()

  toggle: ->
    console.log 'CsvEditor was toggled!'

    if @floatPanel.isVisible()
      @floatPanel.hide()
    else
      @floatPanel.show()
