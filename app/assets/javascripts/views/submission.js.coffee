class window.SubmissionView
  constructor: (@$form) ->
    @$submissionSourceCode = @$form.find('#submission_source_code')
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
    $.each xhr.responseJSON.errors,
      (index, error) => @resultEditor.insert("#{error}\n")

  _handleConnection: (e) =>
    @resultEditor.insert("#{e.data}\n")

  _initializeEditors: ->
    [testTask, @sourceCodeEditor, @resultEditor] = Editor.init($('.code-editor'))

  _copySourceCode: =>
    @resultEditor.clear()
    @$submissionSourceCode.val(@sourceCodeEditor.getValue())
