import 'package:equatable/equatable.dart';

enum EmployeeRole {
  admin('مدير', 'admin'),
  accountant('محاسب', 'accountant'),
  employee('موظف', 'employee');
  


  final String arabicName;
  final String value;

  const EmployeeRole(this.arabicName, this.value);
}

class Employee extends Equatable {
  final String? id;
  final String name;
  final String phone;
  final String address;
  final EmployeeRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Employee({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.role,
    required this.createdAt,
    this.updatedAt,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    EmployeeRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
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
    phone,
    address,
    role,
    createdAt,
    updatedAt,
  ];
}