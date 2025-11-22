// models/property_category_model.dart
import 'package:flutter/material.dart';

class PropertyCategoryModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String cityId;
  final int order; // ترتيب عرض الكاتيجوري
  final bool isActive;
  final IconData icon;
  final DateTime createdAt;

  PropertyCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.cityId,
    required this.order,
    required this.isActive,
    required this.icon,
    required this.createdAt,
  });

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      cityId: json['city_id'],
      order: json['order'] ?? 0,
      isActive: json['is_active'] ?? true,
      icon: _getIconFromString(json['icon']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'city_id': cityId,
      'order': order,
      'is_active': isActive,
      'icon': _getIconString(icon),
      'created_at': createdAt.toIso8601String(),
    };
  }

  static IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'apartment':
        return Icons.apartment;
      case 'villa':
        return Icons.villa;
      case 'store':
        return Icons.store;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'weekend':
        return Icons.weekend;
      case 'business':
        return Icons.business;
      case 'warehouse':
        return Icons.warehouse;
      case 'cottage':
        return Icons.cottage;
      default:
        return Icons.home;
    }
  }

  static String _getIconString(IconData icon) {
    if (icon == Icons.apartment) return 'apartment';
    if (icon == Icons.villa) return 'villa';
    if (icon == Icons.store) return 'store';
    if (icon == Icons.local_hospital) return 'local_hospital';
    if (icon == Icons.weekend) return 'weekend';
    if (icon == Icons.business) return 'business';
    if (icon == Icons.warehouse) return 'warehouse';
    if (icon == Icons.cottage) return 'cottage';
    return 'home';
  }

  PropertyCategoryModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? cityId,
    int? order,
    bool? isActive,
    IconData? icon,
    DateTime? createdAt,
  }) {
    return PropertyCategoryModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      cityId: cityId ?? this.cityId,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}