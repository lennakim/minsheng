$(document).ready(function(){
  $("#button_to_close").click(function(){
    $("#control_buttons").hide();
    $("#button_to_open").show();
  });
  $("#button_to_open").click(function(){
    $(this).hide();
    $("#control_buttons").show();
  });
});