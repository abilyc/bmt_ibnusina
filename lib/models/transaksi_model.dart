class Trx {
  final String? ref;
  final String? desc;
  final int? amount;
  final String? date;
  final String? timestamp;

  Trx({this.ref, this.desc, this.amount, this.date, this.timestamp});

  Trx.fromJson(Map<String,dynamic> json) : ref = json['ref'],
  desc = json['desc'], amount = json['amount'], date = json['date'], timestamp = json['timestamp'];


}
