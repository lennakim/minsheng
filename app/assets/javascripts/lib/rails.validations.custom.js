clientSideValidations.validators.remote['user'] = function(element, options) {
  console.log('aaaaaaaaa');
  if ($.ajax({
    url: '/validators/user',
    data: { id: 1 },
    // async *must* be false
    async: false
  }).status == 404) { return options.message; }
}
