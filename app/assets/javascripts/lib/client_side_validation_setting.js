window.ClientSideValidations.formBuilders = {
  "ActionView::Helpers::FormBuilder": {
    add: function(element, settings, message) {
      form = $(element[0].form);
      $error_field = element.closest('._parent_tip').siblings('._tip_field');
      if (element.data("valid") !== false && ($error_field.find("label.message[for='" + (element.attr("id")) + "']").length == 0)) {
        errorMessage = $("<label class=\"message\"></label>").attr("for", element.attr("id"));
        errorImage = ('<img src="/assets/images/wrongtips.jpg" width="19" height="19" />');
        $error_field.append(errorImage).append(errorMessage);
        if($error_field.hasClass('_mobile')){$error_field.addClass('wrongtips02');};
      }
      return form.find("label.message[for='" + (element.attr("id")) + "']").text(message);
    },
    remove: function(element, settings) {
      $error_field = element.closest('._parent_tip').siblings('._tip_field');
      if($error_field.hasClass('_mobile')){$error_field.removeClass('wrongtips02');};
      return $error_field.empty();
    }
  }
};
