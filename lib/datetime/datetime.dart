import 'package:intl/intl.dart';
//return todays  date time as yyymmdd for eg. 2023

String todayDateYYYYMMDD() {
  //today
  var dateTimeObject = DateTime.now();

  //year in the formart

  String year = dateTimeObject.year.toString();
  //month in the formart
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  //final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

//convert the string into Datetime object
DateTime createDateTimeObjet(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);

  return dateTimeObject;
}

//convert the datetime object into string

String convertDatetimeObjectyyyymmdd(DateTime datetime) {
  //year in the formart

  String year = datetime.year.toString();
  //month in the formart
  String month = datetime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = datetime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  //final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
