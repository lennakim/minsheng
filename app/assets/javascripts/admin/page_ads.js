$('body.page_ads_new, body.page_ads_edit, body.page_ads_create, body.page_ads_update').ready(function(){
  $('.datetime').datetimepicker({
    timeFormat: 'HH:mm:ss',
    addSliderAccess: true,
    sliderAccessArgs: { touchonly: false}
  });
});
