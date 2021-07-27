  String? validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Email address can't be empty";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return "Invalid email address";
  }

    String? validateName(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Name can't be empty";
    }
    // This is just a regular expression for full name
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");

    if (nameRegExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the name didn't match the regex above.
    return "Invalid Name, Enter full name";
  }

   String? validateMobile(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Please, enter valid mobile number";
    }
    // This is just a regular expression for phone number
   final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");

    if (phoneRegExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the phone number didn't match the regex above.
    return "Invalid Number, Enter correct number";
  }