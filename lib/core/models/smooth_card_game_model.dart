import 'package:smooth_game_app/core/enums/smooth_card_game_type.dart';

class SmoothCardGameModel {
  final String uid;
  final int number;
  final SmoothCardGameName name;
  final SmoothCardGameSymbole symbole;
  final SmoothCardGameColor color;
  final String path;

  SmoothCardGameModel({
    required this.uid,
    required this.number,
    required this.name,
    required this.symbole,
    required this.color,
    required this.path,
  });

  factory SmoothCardGameModel.fromJson(json) {
    return SmoothCardGameModel(
      uid: json['uid'],
      number: json['number'],
      name: smoothCardGameNameFromString(json['name']),
      symbole: smoothCardGameSymboleFromString(json['symbole']),
      color: smoothCardGameColorFromString(json['color']),
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'number': number,
      'name': name.name,
      'symbole': symbole.name,
      'color': color.name,
      'path': path,
    };
  }
}
