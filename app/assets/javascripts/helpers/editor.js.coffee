class window.Editor
  THEME = 'solarized_light'
  MODE = 'ruby'

  @init: ($editors) ->
    $editors.map (index, element) ->
      new Editor(element)

  constructor: (@element) ->
    @editor = ace.edit(element)
    @_setup(element)

  getValue: ->
    @editor.getSession().getValue()

  insert: (value) ->
    @editor.insert(value)

  clear: ->
    @editor.setValue('')

  _setup: (element) ->
    @editor.setTheme("ace/theme/#{THEME}")
    @editor.getSession().setMode("ace/mode/#{$(element).data('mode') || MODE}")

    if $(element).data('readonly')
      @editor.setReadOnly(true)
      @editor.renderer.hideComposition(true)
