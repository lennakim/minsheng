$(document).ready(function(){
  $('._image_partial').on('click', '#previous_image', function(e){
    e.preventDefault();
    if($(this).data('is-previous')){
      url = $(this).data('url');
      $.get(url, {}, function(data){
        $('._image_partial').html(data.html);
      });
    }
  }).on('click', '#next_image', function(e){
    e.preventDefault();
    if($(this).data('is-next')){
      url = $(this).data('url');
      $.get(url, {}, function(data){
        $('._image_partial').html(data.html);
      });
    }
  });
})
