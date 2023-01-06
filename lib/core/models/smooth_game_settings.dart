import 'package:flutter/material.dart';

enum SmoothGameCardBackType {
  premium,
  classic,
  black,
  challenger,
  osef,
}

SmoothGameCardBackType smoothGameCardBackFromJson(String json) {
  switch (json) {
    case 'premium':
      return SmoothGameCardBackType.premium;
    case 'classic':
      return SmoothGameCardBackType.classic;
    case 'black':
      return SmoothGameCardBackType.black;
    case 'challenger':
      return SmoothGameCardBackType.challenger;
    case 'osef':
      return SmoothGameCardBackType.osef;
    default:
      return SmoothGameCardBackType.classic;
  }
}

enum SmoothRole {
  admin,
  superAdmin,
  viewer,
  player,
}

enum SmoothPermission {
  read,
  edit,
  delete,
}

SmoothPermission smoothPermissionFronJson(String json) {
  switch (json) {
    case 'read':
      return SmoothPermission.read;
    case 'edit':
      return SmoothPermission.edit;
    case 'delete':
      return SmoothPermission.delete;
    default:
      return SmoothPermission.read;
  }
}

class SmoothGameSettings {
  final String gameSettingsId;
  final Color gameColor;
  final SmoothGameCardBackType cardBackType;
  final bool allowViewersButton;
  final List<SmoothPermission> playersPermissions;

  SmoothGameSettings({
    required this.gameSettingsId,
    required this.gameColor,
    required this.cardBackType,
    required this.allowViewersButton,
    required this.playersPermissions,
  });

  factory SmoothGameSettings.fromJson(json) {
    return SmoothGameSettings(
      gameSettingsId: json['gameSettingsId'].toString(),
      gameColor: json['gameColor'] as Color,
      cardBackType: smoothGameCardBackFromJson(json['cardBackType']),
      allowViewersButton: json['allowViewersButton'],
      playersPermissions: (json['playersPermissions'] as List).map((e) => smoothPermissionFronJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'gameSettingsId': gameSettingsId,
      'gameColor': gameColor,
      'cardBackType': cardBackType.name,
      'allowViewersButton': allowViewersButton,
      'playersPermissions': playersPermissions.map((perm) => perm.name).toList(),
    };
  }
}
