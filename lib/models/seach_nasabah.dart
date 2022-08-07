class Nasabah {
  String? id;
  String? nama;

  Nasabah({this.nama, this.id});

  Nasabah.fromJson(Map<String, dynamic> json)
      : nama = json['data']['customer'][0]['name'],
        id = json['data']['customer'][0]['id'];

  Map<String, dynamic> toJson() => {'id':id,'nama': nama};
}
