import 'dart:async';

mixin Validators {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (isEmailAddressValid(email)) {
      sink.add(email);
    } else {
      sink.addError("Email is not valid");
    }
  });

  final passwordValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError("Password length should be greater than 4 chars.");
    }
  });

  static bool isEmailAddressValid(String email) {
    RegExp exp = new RegExp(
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );
    return exp.hasMatch(email.trim());
    // we trim to remove trailing white spaces
  }

  final requiredTextValidator = StreamTransformer<String, String>.fromHandlers(handleData: (text, sink) {
     if (text.isNotEmpty) {
      sink.add(text);
    } else {
      sink.addError("This field requires some input");
    }
  });
}
