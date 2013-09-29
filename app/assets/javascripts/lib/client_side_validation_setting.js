window.ClientSideValidations.formBuilders = {
  "ActionView::Helpers::FormBuilder": {
    add: function(element, settings, message) {
      var form, labelErrorField;
      form = $(element[0].form);
      if (element.data("valid") !== false && (form.find("label.message[for='" + (element.attr("id")) + "']").length != null)) {
        labelErrorField = $("<label class=\"message\"></label>").attr("for", element.attr("id"));
        element.closest(".field").addClass("field-error").append(labelErrorField);
      }
      return form.find("label.message[for='" + (element.attr("id")) + "']").text(message);
    },
    remove: function(element, settings) {
      return element.closest(".field").removeClass("field-error").find("label.message").remove();
    }
  }
};
