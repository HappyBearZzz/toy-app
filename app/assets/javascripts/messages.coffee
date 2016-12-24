# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
$ ->
  url = window.location.href 
  words = url.split('/')
  if words[words.length-2] == "enter_chat"
    activity_id = words[words.length-1]
    socket = new WebSocket ("ws://#{window.location.host}/chat_group/" + activity_id)
    flag = true
  else if words[words.length-2] == "two_chat"
    user_id = words[words.length-1]
    socket = new WebSocket ("ws://#{window.location.host}/chat_onetoone/" + user_id)
    flag = false

  socket.onmessage = (event) ->
    if event.data.length
      $("#output").append "#{event.data}<br>"

  $("body").on "submit", "form.chat", (event) ->
    event.preventDefault()
    $input = $("#content")
    if socket.readyState == socket.OPEN
      socket.send $input.val()
      $input.val(null)
    else
      alert "链接还没有打开"
    
  $("body").on "submit", "form.twochat", (event) ->
    event.preventDefault()
    $input = $("#content")
    if socket.readyState == socket.OPEN
      socket.send $input.val()
      $input.val(null)
    else
      alert "链接还没有打开"