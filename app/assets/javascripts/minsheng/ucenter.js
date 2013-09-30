$('body.ucenter_suggestion').ready(function(){
  CKEDITOR.replace("suggestion_content");
  $('form#new_suggestion').on('ajax:success', function(event, result){
    $.blockUI({message: result.msg });
    setTimeout($.unblockUI, 2000);
  });
});
