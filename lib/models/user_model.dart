import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? userCode;
  int? personId;
  String? userPassword;
  String? token;
  String? deviceId;
  String? lastLogin;
  UserModel({
    this.id,
    this.userCode,
    this.personId,
    this.userPassword,
    this.token,
    this.deviceId,
    this.lastLogin,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, userCode: $userCode, personId: $personId, userPassword: $userPassword, token: $token, deviceId: $deviceId, lastLogin: $lastLogin)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userCode': userCode,
      'personId': personId,
      'userPassword': userPassword,
      'token': token,
      'deviceId': deviceId,
      'lastLogin': lastLogin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      userCode: map['user_code'] != null ? map['user_code'] as String : null,
      personId: map['person_id'] != null ? map['person_id'] as int : null,
      userPassword:
          map['user_password'] != null ? map['user_password'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      deviceId: map['device_id'] != null ? map['device_id'] as String : null,
      lastLogin: map['last_login'] != null ? map['last_login'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
