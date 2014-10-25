get_db_manager = ->
  exDB = ->
    self = this
    @extensionId = arguments[0] or "eojllnbjkomphhmpcpafaipblnembfem"
    @filterList = new Array()
    @_table
    @_query
    self.sendMessage = sendMessage = (data, callback) ->
      chrome.runtime.sendMessage self.extensionId, data, callback
      return

    self.open = (params, callback) ->
      self.sendMessage
        cmd: "open"
        params: params
      , (r) ->
        tn = undefined
        i = 0

        while i < r.length
          tn = r[i]
          i++
        self.__defineGetter__ tn, ->
          self._table = tn
          this

        callback()
        return

      self

    self.close = (callback) ->
      self.sendMessage
        cmd: "close"
        params: {}
      , callback
      self

    self.table = (name) ->
      self._table = name
      self

    self.query = ->
      self._query = arguments
      self

    self.execute = (callback) ->
      self.sendMessage
        cmd: "execute"
        table: self._table
        query: self._query
        filters: self.filterList
      , (result) ->
        if result and result.RUNTIME_ERROR
          console.error result.RUNTIME_ERROR.message
          result = null
        callback result
        return

      self._query = null
      self.filterList = []
      return

    self.getUsageAndQuota = (callback) ->
      self.sendMessage
        cmd: "getUsageAndQuota"
      , callback
      return

    "add update remove get".split(" ").forEach (fn) ->
      self[fn] = (item, callback) ->
        self.sendMessage
          cmd: fn
          table: self._table
          params: item
        , (result) ->
          if result and result.RUNTIME_ERROR
            console.error result.RUNTIME_ERROR.message
            result = null
          callback result
          return

        self

      return

    "all only lowerBound upperBound bound filter desc distinct keys count".split(" ").forEach (fn) ->
      self[fn] = ->
        self.filterList.push
          type: fn
          args: arguments

        self

      return

    return
  "use strict"
  exDB()

db_callback = (r) ->


#body...
test_func = ->
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
  @db_manager = get_db_manager()
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
