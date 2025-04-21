import 'dart:convert';

class Log {
  String? dateTime;
  String? location;
  String? studNo;
  String? status;
  String? uid;

  Log(
      {required this.dateTime,
      required this.location,
      required this.studNo,
      required this.status,
      required this.uid});

  // Factory constructor to instantiate object from json format
  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
        dateTime: json['dateTime'],
        location: json['location'],
        studNo: json['studNo'],
        status: json['status'],
        uid: json['uid']);
  }

  static List<Log> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Log>((dynamic d) => Log.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Log log) {
    return {
      'dateTime': log.dateTime,
      'location': log.location,
      'studNo': log.studNo,
      'status': log.status,
      'uid': log.uid
    };
  }
}
