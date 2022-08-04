// ignore: file_names
class Models {
  final String? ctln;
  final String? date;
  final String? part;
  final String? agency;
  final String? datemade;
  final String? ext;
  final String? status;
  final String? remarks;

  Models(
      {required this.ctln,
      required this.date,
      required this.part,
      required this.agency,
      required this.datemade,
      required this.ext,
      required this.status,
      required this.remarks});

  Models.fromJson(Map<String, dynamic> json)
      : ctln = json['ctln'],
        date = json['date'],
        part = json['part'],
        agency = json['agency'],
        datemade = json['datemade'],
        ext = json['ext'],
        status = json['status'],
        remarks = json['remarks'];

  Map<String, dynamic> toJson() => {
        'ctln': ctln,
        'DateNow': date,
        'part': part,
        'agency': agency,
        'datemade': datemade,
        'ext': ext,
        'status': status,
        'remarks': remarks
      };

  factory Models.fromRTDB(Map<String, dynamic> data) {
    return Models(
        ctln: data['ctln'] ?? "No",
        date: data['DateNow'] ?? "No",
        part: data['Particulars'] ?? "No",
        agency: data['Agency'] ?? "No",
        datemade: data['DateMade'] ?? "No",
        ext: data['ext'],
        status: data['status'],
        remarks: data['remarks']);
  }
}
