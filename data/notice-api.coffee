get_db_callback = (save_to) ->
  dummy_var = null
  console.log "Getting callback function"
  if !save_to
    save_to = dummy_var
  wrapper = (r) ->
    console.log "Handling db callback"
    console.log "Operation result = "
    console.log r
    save_to = r
    return
  # console.log wrapper
  wrapper

document.test_func = ->
  console.log "test_func entered..."
  return


# https://github.com/aaronpowell/db.js
# or
# http://habrahabr.ru/post/198666/
NotesManagement = (request_manager_instance, ui_manager_instance) ->

  # Init http requests engine
  # Request manager needs to implement request->responce model of web-app communications with the next methods:
  # - request(url,method,data) -> string
  self = @
  self.request_manager = request_manager_instance
  self.table_prefix = String(this)
  self.table_tags = @table_prefix + "tags"
  self.table_jobs = @table_prefix + "jobs"
  self.table_notes = @table_prefix + "notes"
  self.storage_name = "NotesDB"
  self.db_manager = db
  @init_db()
  self.ui_manager = ui_manager_instance
  return

NotesManagement::notice_error = (error_message) ->
# body...

NotesManagement::init_db = ->
  opendb_callback_getter = (obj) ->
    wrapper = (s) ->
      console.log "Handling success connection"
      # console.log "s = "
      # console.log s
      obj.server = s
      # console.log "obj.server"
      # console.log obj.server
      return
    wrapper

  console.log "Opening DB"
  @db_manager.open
    server: @storage_name
    version: 1
    schema:
      table_tags:
        key:
          keyPath: "id"
          autoIncrement: true

        indexes:
          name:
            unique: true

      table_jobs:
        key:
          keyPath: "id"
          autoIncrement: true

        indexes:
          name:
            unique: true

          start: {}
          stop: {}

      table_notes:
        key:
          keyPath: "id"
          autoIncrement: true

        indexes:
          name: {}
          url: {}
          text: {}
          tags: {}
          jobs: {}
  .then(opendb_callback_getter(@))
  # console.log "DB server:"
  # console.log @server
  return


#Tags operations ...

NotesManagement::add_tag = (tag_name) ->
  @server.table_tags.add
    name: tag_name
  .then get_db_callback()
  return

NotesManagement::remove_tag = (tag_name) ->
  @server.table_tags.query("name").only(tag_name).execute (r) ->
    @server.table(@table_tags).remove
      id: r.id
    .then get_db_callback()
    return

  return

NotesManagement::list_tags = (callback) ->
  console.log "calling list_tags"
  tags_query = @server.table_tags.query("name").all().execute()
  tags_query.then(callback, (x) -> console.log "Error")

#TODO: show every tag...
NotesManagement::fuzzy_tags = (tag_name_part) ->
# body...

#Jobs operations

NotesManagement::add_job = (job_nane) ->
  @server.table_jobs.add
    name: job_nane
    start: {}
    stop: {}
  .then get_db_callback()

NotesManagement::remove_job = (job_nane) ->
# body...

NotesManagement::get_jobs = (callback) ->
# body...

NotesManagement::list_jobs = (callback) ->
  console.log "calling list_jobs"
  jobs_query = @server.table_jobs.query("name").all().execute()
  jobs_query.then(callback,(x)-> console.log "Error")

NotesManagement::fuzzy_tags = (job_name_part) ->
# body...


#Selected text management

NotesManagement::save_selected_text = (selected_text) ->
# body...

NotesManagement::get_selections = (callback) ->
# body...

NotesManagement::list_selections = ->
# body...

NotesManagement::fuzzy_selections = (selection_name_part) ->
# body...


#Report composing

NotesManagement::render_report_by_tag = (tag_name) ->
# body...

NotesManagement::render_report_by_job = (job_nane) ->
# body...

# save to document NotesManagement
document.get_notes_management = ->
  console.log "Getting NotesManagement..."
  return NotesManagement
