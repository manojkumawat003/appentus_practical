class LoginData {
  int? id;
  String? name;
  String? email;
  String? password;
  int? mobileNo;
  String? avatar;

  LoginData(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.mobileNo,
      this.avatar});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id']!= null? int.parse(json['id']):json['id'];
    name = json['Name'];
    email = json['email'];
    password = json['password'];
    mobileNo = json['mobileNo']!=null?int.parse(json['mobileNo']):json['mobileNo'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobileNo'] = this.mobileNo;
    data['avatar'] = this.avatar;
    return data;
  }
}
