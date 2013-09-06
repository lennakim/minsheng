$('body.notices_new, body.notices_edit, body.notices_create, body.notices_update').ready(function(){
  $('#notice_start_time, #notice_end_time').datetimepicker();
  CKEDITOR.replace("notice_content");
});
