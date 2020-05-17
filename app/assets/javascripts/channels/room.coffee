document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#messages').data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages').append data['message']
      current_user_id = $('#messages').data('user_id')
      message_user_id = $('.message-user:last-child').data('message_user_id')
      if current_user_id == message_user_id
        $('.message-user:last-child').addClass('force-message-right')
      else
        $('.message-user:last-child').addClass('force-message-left')
      # Called when there's incoming data on the websocket for this channel

    speak: (message) ->
      @perform 'speak', message: message

    $(document).on 'keypress', '[data-behavior=room_speaker]', (event) ->
      if event.keyCode is 13
        App.room.speak event.target.value
        event.target.value = ''
        event.preventDefault()
