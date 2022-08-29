class Customer {
  final String id;
  final String name;
  final String code;
  final int balance;
  Customer({required this.id, required this.name, required this.code, required this.balance});

  Customer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        balance = json['balance'],
        code = json['code'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'code': code, 'balance': balance};
}
