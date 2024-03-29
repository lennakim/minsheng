$("body.rates_new, body.rates_edit").ready(function(){
  var options = {
    bigStarsPath: '/assets/jRating/stars.png',
    mallStarsPath: '/assets/jRating/small.png',
    type : 'big',
    decimalLength: 0,
    length: 5,
    rateMax: 5,
    showRateInfo: false,
    sendRequest: false,
    step: true,
    canRateAgain: true,
    nbRates: 100,
    onClick: function(element, rate){
      $("#rate_rank").val(rate);
    }
  }

  $("#rate_star").jRating(options);
});

$("body.rates_index, body.rates_show, #shop_rates_container").ready(function(){
  var options = {
    bigStarsPath: '/assets/jRating/stars.png',
    smallStarsPath: '/assets/jRating/small.png',
    type : 'big',
    decimalLength: 0,
    length: 5,
    rateMax: 5,
    showRateInfo: false,
    sendRequest: false,
    step: true,
    isDisabled: true
  }

  $(".star").jRating(options);
});
