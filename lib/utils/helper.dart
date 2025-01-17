// import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

String? emailValidator(
    String? value, String? validationError) {
  value = value.toString().trim();

  if (value == 'null' || value.isEmpty) {
    return validationError ?? "this_field_cannot_be_empty";
  } else if (!value.contains("@") || !value.contains(".")) {
    return 'This email is invalid.';
  } else if (value.contains(" ")) {
    return 'email_should_not_contain_white_space';
  }
  return null;
}

String? passwordValidator(
    String? value, String? validationError) {
  value = value.toString().trim();
  if (value == 'null' || value.isEmpty) {
    return validationError ?? "this_field_cannot_be_empty";
  } else if (value.length < 6) {
    return "password_must_be_at_least_6_characters";
  }
  return null;
}

String? phoneValidator(
    String? value, String? validationError) {
  value = value.toString().trim();
  if (value == 'null' || value.isEmpty) {
    return validationError ?? "this_field_cannot_be_empty";
  } else {
    return null;
  }
}

String? simpleValidator(
    String? value, String? validationMsg) {
  value = value.toString().trim();
  if (value == 'null' || value.isEmpty) {
    return validationMsg ?? "this_field_cannot_be_empty";
  }
  return null;
}

String? recordValidator(
    String? value, String? type, String? validationMsg, int? lastRead) {
  value = value.toString().trim();
  if (value == 'null' || value.isEmpty) {
    return validationMsg ?? "this_field_cannot_be_empty";
  }
  if (value == "0") {
    return validationMsg ?? "Data tidak boleh 0";
  }
  if (type == "Add a certain number of pages." && int.parse(value) <= lastRead!) {
    return validationMsg ?? "Data tidak boleh kurang dari halaman terakhir dibaca";
  }
  return null;
}

String? userNameValidator(
    String value, String validationMsg) {
  value = value.toString().trim();
  if (value == 'null' || value.isEmpty) {
    return validationMsg ?? "this_field_cannot_be_empty";
  } else if (value.length >= 30) {
    return validationMsg ??
        "username_may_not_be_longer_than_30_character";
  }
  return null;
}

String? budgetValidator(
    String value, String validationError) {
  value = value.toString().trim();

  if (value == 'null' || value.isEmpty) {
    return validationError ?? "this_field_cannot_be_empty";
  } else if (!value.contains(".")) {
    return 'This amount is invalid.';
  } else if (value.contains(" ")) {
    return 'amount_should_not_contain_white_space';
  }
  return null;
}

String? capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}
//
// String? formatTimeAgo(String datetimeString) {
//   final dateTime = DateTime.parse(datetimeString);
//   final now = DateTime.now();
//   final difference = now.difference(dateTime);
//
//   return timeago.format(now.subtract(difference));
// }

String? formatTimeDefault(String datetimeString) {
  final dateTime = DateTime.parse(datetimeString);

  return DateFormat("MMMM dd, yyyy KK:mm a").format(dateTime);
}

String? getVideoIdFromUrl(String url) {
  Uri uri = Uri.parse(url);
  String? videoId = uri.queryParameters['v'];
  return videoId;
}