ok_button = document.getElementById("submit_text_selection")
text_area = document.getElementById("selected_text")
text_title = document.getElementById("selected_text_title")
text_url = document.getElementById("selected_text_url")
notes_manager_class = document.get_notes_management()
notes_manager = new notes_manager_class null,null

console.log "notes_manager:"
console.log notes_manager

tags = notes_manager.list_tags()
jobs = notes_manager.list_jobs()

ok_button.onclick = ->
  console.log "Clicked!"
  text_area.value = ""
  document.test_func()
  console.log notes_manager
  console.log tags
  console.log jobs
  return

self.port.on "show", onShow = ->
  console.log "Entered!"
  return

self.port.on "text-update", (data) ->
  console.log "Handling text-update ..."
  text_area.value = data.text
  text_url.value = data.url
  text_title.value = data.title
  console.log data
  # saving to index
  return
