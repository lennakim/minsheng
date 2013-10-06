$("body.users_upload_image").ready(function(){
  window.ClientSideValidations.validators.remote['user'] = function(element, options) {
    console.log('aaaaaaaaa');
    if ($.ajax({
      url: '/validators/user',
      data: { id: 1 },
      // async *must* be false
      async: false
    }).status == 404) { return options.message; }
  }


  $( "#account_tabs" ).tabs();

  $('#update_password').on('ajax:success', function(event, result){
    $.blockUI({message: result.msg});
    setTimeout($.unblockUI, 2000);
  });

  $('#user_province_id').on('change', function(){
    url = $(this).closest('p').data('url');
    province_id = parseInt($(this).val());
    $.get(url, {type: 'city', province_id: province_id}, function(result){
      options = '';
      $.each(result, function(k, v){
        options += "<option value=" + v.id + ">" + v.name + "</option>";
      });
      $('#user_city_id').html(options);
      $('#user_community_id').html('');
    });
  });

  $('#user_city_id').on('change', function(){
    url = $(this).closest('p').data('url');
    city_id = parseInt($(this).val());
    $.get(url, {type: 'community', city_id: city_id}, function(result){
      options = '';
      $.each(result, function(k, v){
        options += "<option value=" + v.id + ">" + v.name + "</option>";
      });
      $('#user_community_id').html(options);
    });
  });

  $("#send_mobile_code").on('click', function(event){
    mobile = $("#user_mobile").val();
    url = $(this).attr("href");
    $.get(url, {mobile: mobile}, function(result){
      $.blockUI({message: result.msg});
      setTimeout($.unblockUI, 2000);
    });
    return false;
  });

  $("#verify_mobile_code").on('click', function(event){
      mobile = $("#user_mobile").val();
      code = $("#code").val();
      url = $(this).attr("href");
      $.get(url, {verify_code: code}, function(result){
        $.blockUI({message: result.msg});
        setTimeout($.unblockUI, 2000);
      });
      return false;
    });

  $("#user_image").change(function(){
    if (this.files && this.files[0]) {
      reader = new FileReader();
      reader.onload = function (event) {
        $('#preview').attr('src', event.target.result);
        $('.jcrop-holder').remove();
        $('#show_image').attr({'style': '', 'src': event.target.result}).removeData('Jcrop').
          Jcrop({
            setSelect:[0, 0, 100, 100],
            minSize: [100, 100],
            maxSize: [300, 300],
            allowSelect: false,
            aspectRatio: 1,
            onSelect: function(coords){
              $('#top').val(coords.x);
              $('#left').val(coords.y);
              $('#width').val(coords.w);
              $('#height').val(coords.h);
            }
          });
      };
      reader.readAsDataURL(this.files[0]);
    };
  });

  city_id = $('#user_city_id').closest('p').data('city-id');
  if(city_id != '')
    $('#user_province_id').trigger('change');
    city_selected = 'option[value="'+ city_id + '"]';
    setTimeout("$('#user_city_id').find(city_selected).prop('selected','selected')", 100);
    community_id = $('#user_community_id').closest('p').data('community-id');
    if(community_id != '')
      setTimeout("$('#user_city_id').trigger('change')", 110);
      community_selected = 'option[value="'+ community_id + '"]';
      setTimeout("$('#user_community_id').find(community_selected).prop('selected','selected')", 10);
});

