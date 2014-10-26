ok_button = document.getElementById("submit_text_selection")
text_area = document.getElementById("selected_text")
notes_manager = document.get_notes_management()
ok_button.onclick = ->
  console.log "Clicked!"
  text_area.value = ""
  document.test_func()
  console.log notes_manager
  return

self.port.on "show", onShow = ->
  console.log "Entered!"
  return

self.port.on "text-update", (data) ->
  console.log "Handling text-update ..."
  text_area.value = data.text
  console.log data
  return

