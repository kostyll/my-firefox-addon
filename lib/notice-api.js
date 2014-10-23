NotesManagement = function(storage_manager_instance,request_manager_instance){
    // Init storage
    // Storage manager needs to implement table->key->value storage with the next methods:
    // - get(table,key,default)
    // - put(table,key,value)
    this.storage_manager = storage_manager_instance;

    // Init http requests engine
    // Request manager needs to implement request->responce model of web-app communications with the next methods:
    // - request(url,method,data) -> string
    this.request_manager = request_manager_instance;
}

//Tags operations ...

NotesManagement.prototype.add_tag = function(tag_name){
    // body...
};

NotesManagement.prototype.remove_tag = function(tag_name){
    // body...
};

NotesManagement.prototype.list_tags = function() {
    // body...
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

NotesManagement.prototype.render_report_by_work = function(work_name){

};
