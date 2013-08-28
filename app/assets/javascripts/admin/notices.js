$('body.notices.new, body.notices.edit, body.notices.create, body.notices.update').ready(function(){
  $('#notice_issue_time, #notice_finish_time').datetimepicker({
    timeFormat: 'HH:mm:ss',
    addSliderAccess: true,
    sliderAccessArgs: { touchonly: false}
  });
  CKEDITOR.replace("notice_content");
});
