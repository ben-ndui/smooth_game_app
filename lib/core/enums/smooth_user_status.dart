import 'package:flutter/material.dart';

enum SmoothUserStatus {
  online,
  offline,
  invisible,
}

SmoothUserStatus smoothUserStatusFromJson(String str) {
  switch (str) {
    case 'online':
      return SmoothUserStatus.online;
    case 'offline':
      return SmoothUserStatus.offline;
    case 'invisible':
      return SmoothUserStatus.invisible;
    default:
      return SmoothUserStatus.online;
  }
}

class SmoothUserStatusModel {
  final SmoothUserStatus status;

  const SmoothUserStatusModel({this.status = SmoothUserStatus.online});

  factory SmoothUserStatusModel.fromJson(json) {
    return SmoothUserStatusModel(
      status: smoothUserStatusFromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'status': status.name,
    };
  }

  Color getUserStatus(){
    switch(status){

      case SmoothUserStatus.online:
        return Colors.green;
      case SmoothUserStatus.offline:
        return Colors.red;
      case SmoothUserStatus.invisible:
        return Colors.grey;
      default:
        return Colors.green;
    }
  }
}
