import 'package:equatable/equatable.dart';

enum EmployeeRole {
  admin,
  manager,
  employee;

  String get arabicName {
    switch (this) {
      case EmployeeRole.admin:
        return 'مدير';
      case EmployeeRole.manager:
        return 'مشرف';
      case EmployeeRole.employee:
        return 'موظف';
    }
  }
}

class Employee extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final EmployeeRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Employee({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.createdAt,
    this.updatedAt,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    EmployeeRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        address,
        role,
        createdAt,
        updatedAt,
      ];
}
