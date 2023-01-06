import 'package:smooth_game_app/core/enums/smooth_user_status.dart';

class SmoothUser {
  final String userId;
  final String pseudo;
  final String? name;
  final String? lastname;
  final String? email;
  final String? gender;
  final SmoothUserStatusModel status;
  final DateTime? lastConnexion;

  SmoothUser({
    required this.userId,
    required this.pseudo,
    this.name,
    this.lastname,
    this.email,
    this.gender,
    this.status = const SmoothUserStatusModel(),
    this.lastConnexion,
  });

  factory SmoothUser.fromJson(json) {
    //print(json);
    return SmoothUser(
      userId: json['userId'].toString(),
      name: json['name'].toString(),
      lastname: json['lastname'].toString(),
      email: json['email'].toString(),
      gender: json['gender'].toString(),
      pseudo: json['pseudo'].toString(),
      lastConnexion:
          json['lastConnexion'] != null ? DateTime.parse(json['lastConnexion']) : DateTime.now(),
      status: json['status'] != null
          ? SmoothUserStatusModel.fromJson(json['status'])
          : const SmoothUserStatusModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId.toString().trim(),
      'pseudo': pseudo.toString().trim(),
      'name': name.toString().trim(),
      'lastname': lastname.toString().trim(),
      'email': email.toString().trim(),
      'gender': gender.toString().trim(),
      'lastConnexion': lastConnexion.toString(),
      'status': status.toJson(),
    };
  }
}
