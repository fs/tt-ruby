class window.SubmissionView
  constructor: (@$form) ->
    @_bindEvents()

  _bindEvents: ->
    @$form
      .on 'ajax:success', @_connectToStream
      .on 'ajax:error', @_showErrors

  _connectToStream: (event, data, status, xhr) =>
    source = new EventSource(xhr.getResponseHeader('Location'))
    source.onmessage = @_handleConnection
    source.onerror = -> source.close()

  _showErrors: (event, xhr) ->
    $.each xhr.responseJSON.errors,
      (index, error) -> console.log(error)

  _handleConnection: (e) ->
    console.log(e.data)

