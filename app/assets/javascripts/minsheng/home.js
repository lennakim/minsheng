$(document).ready(function(){
  $('body').css({
    'background-image': 'url(/assets/images/index-bg.jpg)',
    'background-repeat': 'repeat-x',
    'background-color': '#dfefff'
  });

  /*屏幕滚动效果开始*/
  lastScroll = 0;
  time = 1000;
  $(window).scroll(function() {
    anchor = $.url.attr("anchor");
    current_scroll = $(window).scrollTop();
    if(anchor.indexOf('#') > 0){
      screen_alp = anchor.slice(-1);
      if(screen_alp != $('.actived').attr('id')){
        current_alp = '';
        $('._screen').removeClass("actived")
        alp_array = ['A', 'B', 'C', 'D', 'E'];
        idx = alp_array.indexOf(screen_alp);
        if(current_scroll > lastScroll){
          current_alp = alp_array[idx + 1];
          if(idx == 0){current_alp = alp_array[1]}
        }else{
          current_alp = alp_array[idx - 1];
          if(idx == alp_array.length - 1){current_alp = alp_array[3]}
        }
        $("body").animate({scrollTop: $('#' + current_alp).position().top}, time);
        setTimeout(function(){$('._screen').removeClass('actived');}, time + 100);
        window.location.href = window.location.href.replace(screen_alp, current_alp);
        $.url.setUrl(window.location.href);
        $('#' + current_alp).addClass('actived');
      }
    }else{
      window.location.href = window.location.href + "#B";
      $.url.setUrl(window.location.href);
      $("body").animate({scrollTop: $('#B').position().top}, time);
      $('#B').addClass('actived');
      setTimeout(function(){$('._screen').removeClass('actived');}, time + 100);
    }
    lastScroll = current_scroll;
  });
  /* 屏幕滚动效果结束 */

  $('#slider').anythingSlider({
    autoPlay: true, autoPlayDelayed: true, autoPlayLocked: true,
    buildStartStop: false, buildArrows: false, resumeDelay: 2000,
    clickControls: 'mouseenter', changeBanner: true,
    changeBannerOption: {remove_class: '#A ._banner_nav a', add_class: '#A .panel', class_name: 'current'}
  });

  $('#A .anythingWindow').css({'border-top': 0, 'border-bottom': 0});
  $('#A .thumbNav').hide();
  $('#A .anythingSlider').css({'padding': 0});

  $('#A ._banner_nav a').on('mouseenter', function(){
    $('#A .thumbNav a.' + $(this).attr('class').split(' ')[0]).trigger('mouseenter');
  });

});
