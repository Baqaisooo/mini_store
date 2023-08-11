class UserModel {

  late final bool status;
  late final String message;
  late final UserData data;

  UserModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    if(json['data'] != null){
      data = UserData.fromJson(json['data']);
    }
  }

}

class UserData {

  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int points;
  late final int credit;
  late final String token;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points']?? 0;
    credit = json['credit']?? 0;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['image'] = image;
    _data['points'] = points;
    _data['credit'] = credit;
    _data['token'] = token;
    return _data;
  }
}