$("body.mobile_sign_up").ready(function(){
  $("#sendCaptchaCodeBtn").click(function(){
      var mobile = $("#user_mobile").val();
      var url = $(this).attr("url");

      $.ajax({
        url: url,
        type: 'GET',
        data: { mobile: mobile },
        success: function(data){
          alert(data.message)
        }
      });
  });

  $("#verifyBtn").bind('click',function(){
      var mobile = $("#user_mobile").val();
      var captcha_code = $("#captcha_code").val();
      var url = $(this).attr("url");

      $.ajax({
        url: url,
        type: 'GET',
        data: { captcha_code: captcha_code, mobile: mobile },
        success: function(data){
          alert(data.message)
        }
      });
    });
});

$("body.mobile_reset_password_page").ready(function(){
  $("#sendPasswordTokenBtn").click(function(){
    var mobile = $("#mobile").val();
    var url = $(this).attr("url");

    $.ajax({
      url: url,
      type: 'GET',
      data: { mobile: mobile },
      success: function(data){
        alert(data.message)
      }
    });
  });
});