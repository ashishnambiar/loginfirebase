String? validationHandler({
  required String? str,
  required String fieldName,
  bool password = false,
  bool email = false,
  int length = 0,
}) {
  var upper = str!.contains(RegExp(r'[A-Z]'));
  var number = str.contains(RegExp(r'[0-9]'));
  var sp = str.contains(RegExp(r'[!@#$%^&*_+]'));
  bool passValid = upper && number && sp;
  bool emailValid = str.contains(RegExp(r'[a-zA-Z0-9!#$%^&*_+]@[a-z0-9]'));

  if (str == null || str == '') {
    return '$fieldName cannot be empty';
  } else if (str.length < length) {
    return '$fieldName should be longer than $length characters';
  } else if (password && !passValid) {
    return "should Contain atleast one ${!upper ? "Capital Letter" : !number ? "Number" : !sp ? "Special Character" : "???"}";
  } else if (email && !emailValid) {
    return "Enter a valid Email ID";
  } else {
    return null;
  }
}
