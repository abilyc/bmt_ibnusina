class Nasabah {
  String nama;
  String ref;
  String desc;

  Nasabah({this.nama = '', this.ref = '', this.desc = ''});

  Nasabah.fromJson(Map<String, dynamic> json)
      : nama = json['data']['login']['username'],
        ref = json['data']['login']['userId'],
        desc = json['data']['login']['userRole'];

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'ref': ref,
        'desc': desc
      };

}
