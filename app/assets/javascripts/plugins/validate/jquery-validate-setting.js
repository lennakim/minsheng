// --- mobilephone
$.validator.addMethod("mobile_phone", function(value, element, param) {
    var reg = /^\d{11}$/;
    return this.optional(element) || reg.test(value);
}, $.validator.format("移动电话格式不正确"));

// --- regex
$.validator.addMethod("regex", function(value, element, param) {
    var reg = param;
    return this.optional(element) || reg.test(value);
}, $.validator.format("格式不符合要求"));


$.extend($.validator.messages, {
  required: "必选字段",
  maxlength: $.validator.format("请最多输入{0}位"),
  minlength: $.validator.format("请最少输入{0}位")
});


$.validator.setDefaults({
  errorClass: 'error',
  validClass: 'success',
  errorElement: 'span',
  highlight: function(element) {
    return $(element.form).find("label[for=" + element.id + "]").removeAttr('style');
  },
  errorPlacement: function(error, element) {
    var _ref;
    error.removeAttr('style');
    if ((_ref = element.attr('name')) === 'captcha' || _ref === 'terms') {
      return error.appendTo(element.parent());
    } else {
      return error.insertAfter(element);
    }
  },
  unhighlight: function(element, errorClass, validClass) {
    $error_field = $(element).closest('._parent_tip').siblings('._tip_field');
    if($error_field.hasClass('_mobile')){$error_field.removeClass('wrongtips02');};
    return $error_field.empty();
  },
  showErrors: function(errorMap, errorList) {
    if (errorList.length > 0) {
      $form = $(errorList[0].element.form);
      $element = $(errorList[0].element)
      $error_field = $element.closest('._parent_tip').siblings('._tip_field');
      if($error_field.find("label.message[for='" + ($element.attr("id")) + "']").length == 0){
        errorMessage = $("<label class=\"message\"></label>").attr("for", $element.attr("id"));
        errorImage = ('<img src="/assets/images/wrongtips.jpg" width="19" height="19" />');
        $error_field.append(errorImage).append(errorMessage);
        if($error_field.hasClass('_mobile')){$error_field.addClass('wrongtips02');};
      }
      $form.find("label.message[for='" + ($element.attr("id")) + "']").text(errorList[0].message);
    }else{
       this.defaultShowErrors();
    }
  },
  onclick: false
});
