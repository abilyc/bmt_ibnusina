class Customer {
  final String id;
  final String name;
  final String code;
  Customer({required this.id, required this.name, required this.code});

  Customer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        code = json['code'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'code': code};
}
