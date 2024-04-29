class ModelCucian {
  String? id;
  String? cucian;
  String? harga;

  ModelCucian({this.id, this.cucian, this.harga});

  ModelCucian.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cucian = json['cucian'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cucian'] = this.cucian;
    data['harga'] = this.harga;
    return data;
  }
}
