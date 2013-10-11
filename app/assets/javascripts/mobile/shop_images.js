$(document).ready(function(){
  removeUselessCenterPartial = function(){
    if($('._center_partial').length != 1){
      $($('._image_partial').find('._center_partial:first')).remove()
    }
  };

  $('._image_partial').on('click', '#previous_image', function(e){
    e.preventDefault();
    $this = $(this)
    if($this.data('is-previous')){
      url = $(this).data('url');
      $.get(url, {}, function(result){
        $current_image_box = $this.parents('._image_partial');
        $current_center_partial = $current_image_box.find('._center_partial:first');
        $new_html = $('<div></div>');
        $new_html.html(result.html);
        $new_center_partial = $new_html.find('._center_partial');
        $new_center_partial.insertAfter($current_center_partial);
        $current_center_partial.animate({top: '-300px', opacity: 0}, {complete: setTimeout(removeUselessCenterPartial, 200)}).
           next('._center_partial').css({top: '180px', opacity: 0, position: 'relative'}).
           animate({top:'0', opacity: 1}, {complete: setTimeout(removeUselessCenterPartial, 200)});
      });
    return false;
    }
  }).on('click', '#next_image', function(e){
    e.preventDefault();
    $this = $(this)
    if($(this).data('is-next')){
      url = $(this).data('url');
      $.get(url, {}, function(result){
        $current_image_box = $this.parents('._image_partial');
        $current_center_partial = $current_image_box.find('._center_partial:first');
        $new_html = $('<div></div>');
        $new_html.html(result.html);
        $new_center_partial = $new_html.find('._center_partial');
        $new_center_partial.insertAfter($current_center_partial);
        $current_center_partial.animate({bottom: '-300px', opacity: 0}, {complete: setTimeout(removeUselessCenterPartial, 200)}).
           next('._center_partial').css({bottom: '180px', opacity: 0, position: 'relative'}).
           animate({bottom:'0', opacity: 1}, {complete: setTimeout(removeUselessCenterPartial, 200)});
      });
    }
  }).on('click', '._shop_image', function(e){
    e.preventDefault();
    $clone = $(this).clone();
    $clone.find('img').width(400).height(400);
    $.blockUI({
      message: $clone,
      css: {
        top:($(window).height() - 400) /2 + 'px',
        left: ($(window).width() - 400) /2 + 'px',
        width: '400px'
      },
      onOverlayClick: $.unblockUI
    });
  });
})
