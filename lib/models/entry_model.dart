import 'dart:convert';

class Entry {
  bool fever;
  bool feel_fever;
  bool muscle_pain;
  bool cough;
  bool colds;
  bool sore_throat;
  bool diff_breathing;
  bool diarrhea;
  bool no_taste;
  bool no_smell;
  bool contact;
  String studNo;
  String status;
  String date;

  Entry(
      {required this.fever,
      required this.feel_fever,
      required this.muscle_pain,
      required this.cough,
      required this.colds,
      required this.sore_throat,
      required this.diff_breathing,
      required this.diarrhea,
      required this.no_taste,
      required this.no_smell,
      required this.contact,
      required this.studNo,
      required this.status,
      required this.date
      });
  // Factory constructor to instantiate object from json format
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        fever: json['fever'],
        feel_fever: json['feel_fever'],
        muscle_pain: json['muscle_pain'],
        cough: json['cough'],
        colds: json['colds'],
        sore_throat: json['sore_throat'],
        diff_breathing: json['diff_breathing'],
        diarrhea: json['diarrhea'],
        no_taste: json['no_taste'],
        no_smell: json['no_smell'],
        contact: json['contact'],
        studNo: json['studNo'],
        status: json['status'],
        date: json['date']);
  }

  static List<Entry> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Entry>((dynamic d) => Entry.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Entry entry) {
    return {
      'fever': entry.fever,
      'feel_fever': entry.feel_fever,
      'muscle_pain': entry.muscle_pain,
      'cough': entry.cough,
      'colds': entry.colds,
      'sore_throat': entry.sore_throat,
      'diff_breathing': entry.diff_breathing,
      'diarrhea': entry.diarrhea,
      'no_taste': entry.no_taste,
      'no_smell': entry.no_smell,
      'contact': entry.contact,
      'studNo': entry.studNo,
      'status': entry.status,
      'date': entry.date
    };
  }
}
