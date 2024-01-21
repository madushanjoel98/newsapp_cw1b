String getDate() {
  DateTime today = DateTime.now();

  // Format the date as a string using the desired format
  String formattedDate = "${today.year}-${_twoDigits(today.month)}-${_twoDigits(today.day-1)}";
print(formattedDate);
 return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}
