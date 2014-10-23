var get_db_manager = function (){
    "use strict";
    function exDB() {
        var self = this;
        this.extensionId = arguments[0] || "eojllnbjkomphhmpcpafaipblnembfem";
        this.filterList = new Array();
        this._table;
        this._query;
        self.sendMessage = function sendMessage(data, callback) {
            chrome.runtime.sendMessage(self.extensionId, data, callback);
        };

        self.open = function (params, callback) {
            self.sendMessage({"cmd": "open", "params": params}, function(r){
                var tn;
                for(var i=0;i< r.length;i++)
                    tn = r[i];
                    self.__defineGetter__(tn,function(){
                        self._table = tn;
                        return this;
                    });
                callback();
            });
            return self;
        };

        self.close = function (callback) {
            self.sendMessage({"cmd": "close", "params": {}}, callback);
            return self;
        }

        self.table = function (name) {
            self._table = name;
            return self;
        };

        self.query = function () {
            self._query = arguments;
            return self;
        };

        self.execute = function (callback) {
            self.sendMessage({"cmd": "execute", "table": self._table, "query": self._query, "filters": self.filterList}, function (result) {
                if (result && result.RUNTIME_ERROR) {
                    console.error(result.RUNTIME_ERROR.message);
                    result = null;
                }
                callback(result);
            });
            self._query = null;
            self.filterList = [];
        };

        self.getUsageAndQuota = function(callback){
            self.sendMessage({"cmd": "getUsageAndQuota"},callback);
        };

        "add update remove get".split(" ").forEach(function (fn) {
            self[fn] = function (item, callback) {
                self.sendMessage({"cmd": fn, "table": self._table, "params": item}, function (result) {
                    if (result && result.RUNTIME_ERROR) {
                        console.error(result.RUNTIME_ERROR.message);
                        result = null;
                    }
                    callback(result);
                });
                return self;
            }
        });

        "all only lowerBound upperBound bound filter desc distinct keys count".split(" ").forEach(function (fn) {
            self[fn] = function () {
                self.filterList.push({type: fn, args: arguments});
                return self;
            }
        });
    };
    return exDB();
};

var db_callback = function (r){
    //body...
};

// https://github.com/aaronpowell/db.js
// or
// http://habrahabr.ru/post/198666/

NotesManagement = function(request_manager_instance){
    // Init http requests engine
    // Request manager needs to implement request->responce model of web-app communications with the next methods:
    // - request(url,method,data) -> string
    this.request_manager = request_manager_instance;

    this.table_prefix = string(this);
    this.table_tags = this.table_prefix + 'tags';
    this.table_jobs = this.table_prefix + 'jobs';
    this.table_notes = this.table_prefix + 'notes';
    this.storage_name = "NotesDB";
    this.db_manager = get_db_manager();
    this.init_db();
}

NotesManagement.prototype.notice_error = function(error_message) {
    // body...
};

NotesManagement.prototype.init_db = function(){
    this.db_manager.open({
        server: this.storage_name,
        version: 1,
        schema: {
            this.table_tags:{
                key:{
                    keyPath: 'id',
                    autoIncrement: true,
                },
                indexes:{
                    name: { unique: true },
                },
            },
            this.table_jobs:{
                key:{
                    keyPath: 'id',
                    autoIncrement: true,
                },
                indexes:{
                    name : { unique: true },
                    start : { },
                    stop : { },
                },
            },
            this.table_notes:{
                key:{
                    keyPath: 'id',
                    autoIncrement: true,
                },
                indexes:{
                    name : { },
                    url : { },
                    text : { },
                    tags : { },
                    jobs : { },
                },
            },
        },
    },function(){});
};

//Tags operations ...

NotesManagement.prototype.add_tag = function(tag_name){
    this.db_manager.table(this.table_tags).add({name:tag_name},db_callback);
};

NotesManagement.prototype.remove_tag = function(tag_name){
    this.db_manager.table(this.table_tags).query("name").only(tag_name).execute(function(r){
        this.db_manager.table(this.table_tags).remove({id:r.id},db_callback);
    });
};

NotesManagement.prototype.list_tags = function(){
    get_tags = function(callback){
        this.db_manager.table(this.table_tags).query("name").all().execute(callback);
        return this.storage_manager.get(this.table_tags);
    };
    this.get_tags();
    //TODO: show every tag...
};

NotesManagement.prototype.fuzzy_tags = function(tag_name_part){
    // body...
};

//Jobs operations

NotesManagement.prototype.add_job = function(job_nane){
    // body...
};

NotesManagement.prototype.remove_job = function(job_nane){
    // body...
};

NotesManagement.prototype.get_jobs = function(callback){
    // body...
};

NotesManagement.prototype.list_jobs = function(){
    // body...
};

NotesManagement.prototype.fuzzy_tags = function(job_name_part){
    // body...
};

//Selected text management

NotesManagement.prototype.save_selected_text = function(selected_text){
    // body...
};

NotesManagement.prototype.get_selections = function(callback){
    // body...
};

NotesManagement.prototype.list_selections = function(){
    // body...
};

NotesManagement.prototype.fuzzy_selections = function(selection_name_part){
    // body...
};

//Report composing

NotesManagement.prototype.render_report_by_tag = function(tag_name){
    // body...
};

NotesManagement.prototype.render_report_by_job = function(job_nane){
    // body...
};
