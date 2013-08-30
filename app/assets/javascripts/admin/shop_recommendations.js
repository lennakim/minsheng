$('body.shop_recommendations.new, body.shop_recommendations.edit, body.shop_recommendations.create, body.shop_recommendations.update').ready(function(){
  $('#shop_recommendation_start_time, #shop_recommendation_end_time').datetimepicker({
    timeFormat: 'HH:mm:ss',
    addSliderAccess: true,
    sliderAccessArgs: { touchonly: false}
  });
});
