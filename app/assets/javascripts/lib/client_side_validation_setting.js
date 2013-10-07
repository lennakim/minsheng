window.ClientSideValidations.formBuilders = {
  "ActionView::Helpers::FormBuilder": {
    add: function(element, settings, message) {
      console.log('bbbbbbb');
      // var form, labelErrorField;
      form = $(element[0].form);
      $error_field = element.closest('._parent_tip').siblings('._tip_field');
      // if (element.data("valid") !== false && (form.find("label.message[for='" + (element.attr("id")) + "']").length != null)) {
      //   labelErrorField = $("<label class=\"message\"></label>").attr("for", element.attr("id"));
      //   element.closest(".field").addClass("field-error").append(labelErrorField);
      // }
      // return form.find("label.message[for='" + (element.attr("id")) + "']").text(message);
      console.log('aaaaaaaaaaa');
      if (element.data("valid") !== false && ($error_field.find("label.message[for='" + (element.attr("id")) + "']").length == 0)) {
        errorMessage = $("<label class=\"message\"></label>").attr("for", element.attr("id"));
        errorImage = ('<img src="/assets/images/wrongtips.jpg" width="19" height="19" />');
        $error_field.append(errorImage).append(errorMessage);
      }
      return form.find("label.message[for='" + (element.attr("id")) + "']").text(message);
    },
    remove: function(element, settings) {
      return element.closest('._parent_tip').siblings('._tip_field').empty();
    }
  }
};
