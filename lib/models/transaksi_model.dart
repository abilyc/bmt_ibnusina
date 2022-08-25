class Trx {
  final String? type;
  final String? ref;
  final int? amount;
  final String? date;

  Trx({this.type, this.ref, this.amount, this.date});

  Trx.fromJson(Map<String,dynamic> json) : type = json['type'], ref = json['ref'], amount = json['amount'], date = json['date'];


}
