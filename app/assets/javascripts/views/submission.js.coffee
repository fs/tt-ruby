class window.SubmissionView
  SYMBOL = '▪'
  LENGTH = 3
  DELAY = 300

  constructor: (@$form) ->
    @$submissionSourceCode = @$form.find('#submission_source_code')
    @$resultPrompt = @$form.find('#result_prompt')
    @$dotsLoader = @$resultPrompt.find('.dots')
    @$result = @$form.find('#result')
    @_initializeEditors()
    @_bindEvents()

  _bindEvents: ->
    @$form
      .on 'ajax:before', @_copySourceCode
      .on 'ajax:success', @_connectToStream
      .on 'ajax:error', @_showErrors

  _connectToStream: (event, data, status, xhr) =>
    source = new EventSource(xhr.getResponseHeader('Location'))
    source.onmessage = @_handleConnection
    source.onerror = -> source.close()

  _showErrors: (event, xhr) =>
    @_hideResultPrompt()

    $.each xhr.responseJSON.errors,
      (index, error) => @resultEditor.insert("#{error}\n")

  _handleConnection: (e) =>
    @_hideResultPrompt()
    @resultEditor.insert("#{e.data}\n")

  _initializeEditors: ->
    [testTask, @sourceCodeEditor, @resultEditor] = Editor.init($('.code-editor'))

  _copySourceCode: =>
    @_showResultPrompt()
    @resultEditor.clear()
    @$submissionSourceCode.val(@sourceCodeEditor.getValue())

  _showResultPrompt: =>
    @$resultPrompt.removeClass('hidden')

    clearTimeout(@dotsLoader) if @dotsLoader?
    @dotsLoader = setInterval(@_updateDots, DELAY)

  _hideResultPrompt: =>
    clearTimeout(@dotsLoader) if @dotsLoader?
    @$resultPrompt.addClass('hidden')

  _updateDots: =>
    text = @$dotsLoader.text()

    if text.length == LENGTH
      text = SYMBOL
    else
      text = text + SYMBOL

    @$dotsLoader.text(text)
