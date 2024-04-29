class ModelUser {
  String? id;
  String? user;
  String? password;

  ModelUser({this.id, this.user, this.password});

  ModelUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['password'] = this.password;
    return data;
  }
}
