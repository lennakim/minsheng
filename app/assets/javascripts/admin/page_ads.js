$('body.page_ads_new, body.page_ads_edit').ready(function(){
  $('.datetime').datetimepicker({
    timeFormat: 'HH:mm:ss',
    addSliderAccess: true,
    sliderAccessArgs: { touchonly: false}
  });
});
