// // models/city_model.dart
// class CityModel {
//   final String id;
//   final String nameAr;
//   final String nameEn;
//   final bool isActive;
//   final DateTime createdAt;

//   CityModel({
//     required this.id,
//     required this.nameAr,
//     required this.nameEn,
//     required this.isActive,
//     required this.createdAt,
//   });

//   factory CityModel.fromJson(Map<String, dynamic> json) {
//     return CityModel(
//       id: json['id'],
//       nameAr: json['name_ar'],
//       nameEn: json['name_en'],
//       isActive: json['is_active'] ?? true,
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name_ar': nameAr,
//       'name_en': nameEn,
//       'is_active': isActive,
//       'created_at': createdAt.toIso8601String(),
//     };
//   }

//   CityModel copyWith({
//     String? id,
//     String? nameAr,
//     String? nameEn,
//     bool? isActive,
//     DateTime? createdAt,
//   }) {
//     return CityModel(
//       id: id ?? this.id,
//       nameAr: nameAr ?? this.nameAr,
//       nameEn: nameEn ?? this.nameEn,
//       isActive: isActive ?? this.isActive,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }