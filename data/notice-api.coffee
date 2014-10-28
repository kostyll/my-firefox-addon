db_callback = (r) ->
  #body...

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
  @request_manager = request_manager_instance
  @table_prefix = String(this)
  @table_tags = @table_prefix + "tags"
  @table_jobs = @table_prefix + "jobs"
  @table_notes = @table_prefix + "notes"
  @storage_name = "NotesDB"
  @db_manager = db
  @init_db()
  @ui_manager = ui_manager_instance
  return

NotesManagement::notice_error = (error_message) ->
# body...

NotesManagement::init_db = ->
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
  , db_callback
  return


#Tags operations ...

NotesManagement::add_tag = (tag_name) ->
  @db_manager.table(@table_tags).add
    name: tag_name
  , db_callback
  return

NotesManagement::remove_tag = (tag_name) ->
  @db_manager.table(@table_tags).query("name").only(tag_name).execute (r) ->
    @db_manager.table(@table_tags).remove
      id: r.id
    , db_callback
    return

  return

NotesManagement::list_tags = ->
  get_tags = (callback) ->
    @db_manager.table(@table_tags).query("name").all().execute callback
    return

  @get_tags db_callback
  return


#TODO: show every tag...
NotesManagement::fuzzy_tags = (tag_name_part) ->
# body...

#Jobs operations

NotesManagement::add_job = (job_nane) ->
# body...

NotesManagement::remove_job = (job_nane) ->
# body...

NotesManagement::get_jobs = (callback) ->
# body...

NotesManagement::list_jobs = ->
# body...

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
