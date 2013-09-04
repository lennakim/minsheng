$("body.users.upload_image").ready(function(){
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
});

