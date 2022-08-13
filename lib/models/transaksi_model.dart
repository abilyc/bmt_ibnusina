class Trx {
  final String? type;
  final String? ref;
  final String? desc;
  final int? amount;
  final String? date;
  final String? timestamp;

  Trx({this.type, this.ref, this.desc, this.amount, this.date, this.timestamp});

  Trx.fromJson(Map<String,dynamic> json, String mode) : type = mode, ref = json['ref'],
  desc = json['desc'], amount = json['amount'], date = json['date'], timestamp = json['timestamp'];


}
