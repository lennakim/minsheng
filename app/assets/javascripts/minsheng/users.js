$("body.users.upload_image").ready(function(){
  $("#user_image_url").change(function(){
    $this = this;
    var jcrop_api, boundx, boundy;
    if ($this.files && $this.files[0]) {
      reader = new FileReader();
      reader.onload = function (e) {
        $('#show_image').attr('src', e.target.result);
        $('#preview').attr('src', e.target.result);
        $('#show_image').attr('style', '');
        $('#show_image').removeData('Jcrop');
        $('.jcrop-holder').remove();
        $("#show_image").Jcrop({
          setSelect:[0, 0, 100, 100],
          minSize: [100, 100],
          maxSize: [300, 300],
          allowSelect: false,
          onSelect: updatePreview,
          aspectRatio:1
        },function(){
          bounds=this.getBounds();
          boundx=bounds[0];
          boundy=bounds[1];
          jcrop_api=this;
        });
      };
      reader.readAsDataURL($this.files[0]);
    };
    function updatePreview(c){
      $('#top').val(c.x);
      $('#left').val(c.y);
      $('#width').val(c.w);
      $('#height').val(c.h);

      if(parseInt(c.w)>0){
        var rx=100/c.w;
        var ry=100/c.h;
        $("#preview").css({
          width:Math.round(rx*boundx)+"px",
          height:Math.round(ry*boundy)+"px",
          marginLeft:"-"+Math.round(rx*c.x)+"px",
          marginTop:"-"+Math.round(ry*c.y)+"px"
        });
      };
    };
  });
});

