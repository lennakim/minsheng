$('body.notices.new, body.notices.edit').ready(function(){
  $('#notice_issue_time').datetimepicker({
    timeFormat: 'HH:mm:ss',
    addSliderAccess: true,
    sliderAccessArgs: { touchonly: false}
  });
  CKEDITOR.replace("notice_content");
});
