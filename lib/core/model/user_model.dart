import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? phoneNumber;

  @HiveField(4)
  final String? photoUrl;

  @HiveField(5)
  final DateTime? lastSeen;

  @HiveField(6)
  final String? status;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.photoUrl,
    this.lastSeen,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? "",
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'],
        status: json['status'],
        photoUrl: json['photoUrl'],
        lastSeen:
            json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'status': status,
      'photoUrl': photoUrl,
      'lastSeen': lastSeen?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props =>
      [id, name, email, phoneNumber, photoUrl, lastSeen, status];
}
