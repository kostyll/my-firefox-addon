ok_button = document.getElementById("submit_text_selection")
text_area = document.getElementById("selected_text")
text_title = document.getElementById("selected_text_title")
text_url = document.getElementById("selected_text_url")

selected_tags = $("#selected_tags")
selected_tags.tagsinput

selected_jobs = $("#selected_jobs")

all_tags = $("#all_tags")
all_jobs = $("#all_jobs")

notes_manager_class = document.get_notes_management()
notes_manager = new notes_manager_class null,null

clear_input = (input) ->
  input_type = typeof input
  # console.log "typeof input = "
  # console.log input_type
  if input_type != "string"
    # console.log "Inputed Array ..."
    input.map (x) ->
      # console.log "Cleaning item ..."
      if x.tagsinput
        x.tagsinput "removeAll"
      else
        x.value = ""
      # console.log "Done"
      return
  else
    input.value = ""
  return

# console.log "notes_manager:"
# console.log notes_manager

# tags = notes_manager.list_tags()
# jobs = notes_manager.list_jobs()

process_selected_text = (text,title,url,tags,jobs) ->
  # process current items
  notes_manager.save_selection
    text: text
    url: url
    title: title
    tags: tags
    jobs: jobs

show_tag_items = (tags_items,all_items_div,selected_items_div) ->
  # display tags
  console.log tags_items
  $(all_items_div).text("")
  tags_items.map (item,index,arr) ->
    button = document.createElement('a')
    $(button).addClass("btn btn-small btn-primary")
    .html(item.name)
    .appendTo(all_items_div)
    .click () ->
      console.log "Selected"
      console.log item
      selected_items_div.tagsinput 'add', item.name

      return
    return

show_tags = (tags) ->
  show_tag_items tags,all_tags,selected_tags

show_jobs = (jobs) ->
  show_tag_items jobs,all_jobs,selected_jobs

ok_button.onclick = ->
  console.log "Clicked!"

  iNewText = text_area.value
  iNewTitle = text_title.value
  iNewUrl = text_url.value
  tags = selected_tags.tagsinput('items')
  jobs = selected_jobs.tagsinput('items')

  tags.map (item,index,arr) ->
    notes_manager.add_tag(item)
  jobs.map (item,index,arr) ->
    notes_manager.add_job(item)

  notes_manager.list_tags(show_tags)
  notes_manager.list_jobs(show_jobs)

  process_selected_text iNewText,iNewTitle,iNewUrl,tags,jobs

  console.log "Tags = "
  console.log tags
  console.log "jobs = "
  console.log jobs

  console.log "Clear inputs..."
  clear_input [
    text_area,
    text_url,
    text_title,
    selected_tags,
    selected_jobs
  ]

  test_jaml(iNewTitle)
  return

self.port.on "show", onShow = ->
  console.log "Entered!"
  return

test_jaml = (text) ->
  Jaml.register 'test',(text) ->
    h1("test with jaml " +text)
  html = Jaml.render "test",text
  console.log "Rendered html by jaml"
  console.log html
  $("#test_div").empty().append(String(html))
  return

self.port.on "text-update", (data) ->
  console.log "Handling text-update ..."
  text_area.value = data.text
  text_url.value = data.url
  text_title.value = data.title
  console.log data
  # saving to index
  return

notes_manager.list_tags(show_tags)
notes_manager.list_jobs(show_jobs)
