// models/location_models.dart

import 'package:flutter/material.dart';

// ==================== City Model ====================
class CityModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final bool isActive;
  final DateTime createdAt;

  CityModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.isActive,
    required this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  CityModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CityModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ==================== District Model ====================
class DistrictModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String cityId; // Foreign Key → City
  final bool isActive;
  final DateTime createdAt;

  DistrictModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.cityId,
    required this.isActive,
    required this.createdAt,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      cityId: json['city_id'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'city_id': cityId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  DistrictModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? cityId,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return DistrictModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      cityId: cityId ?? this.cityId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ==================== Property Category Model ====================
class PropertyCategoryModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final int order;
  final bool isActive;
  final IconData icon;
  final DateTime createdAt;

  PropertyCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
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
      case 'hotel':
        return Icons.hotel;
      case 'factory':
        return Icons.factory;
      case 'agriculture':
        return Icons.agriculture;
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
    if (icon == Icons.hotel) return 'hotel';
    if (icon == Icons.factory) return 'factory';
    if (icon == Icons.agriculture) return 'agriculture';
    return 'home';
  }

  PropertyCategoryModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    int? order,
    bool? isActive,
    IconData? icon,
    DateTime? createdAt,
  }) {
    return PropertyCategoryModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ==================== Property Model ====================
class PropertyModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String districtId; // Foreign Key → District
  final String categoryId; // Foreign Key → PropertyCategory
  final double price;
  final double area;
  final int bedrooms;
  final int bathrooms;
  final int floor;
  final bool hasParking;
  final bool hasElevator;
  final bool hasGarden;
  final bool isActive;
  final List<String> images;
  final String ownerName;
  final String ownerPhone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  PropertyModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.districtId,
    required this.categoryId,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.floor,
    required this.hasParking,
    required this.hasElevator,
    required this.hasGarden,
    required this.isActive,
    required this.images,
    required this.ownerName,
    required this.ownerPhone,
    required this.createdAt,
    this.updatedAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      districtId: json['district_id'],
      categoryId: json['category_id'],
      price: (json['price'] as num).toDouble(),
      area: (json['area'] as num).toDouble(),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      floor: json['floor'] ?? 0,
      hasParking: json['has_parking'] ?? false,
      hasElevator: json['has_elevator'] ?? false,
      hasGarden: json['has_garden'] ?? false,
      isActive: json['is_active'] ?? true,
      images: List<String>.from(json['images'] ?? []),
      ownerName: json['owner_name'] ?? '',
      ownerPhone: json['owner_phone'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'district_id': districtId,
      'category_id': categoryId,
      'price': price,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'floor': floor,
      'has_parking': hasParking,
      'has_elevator': hasElevator,
      'has_garden': hasGarden,
      'is_active': isActive,
      'images': images,
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  PropertyModel copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? districtId,
    String? categoryId,
    double? price,
    double? area,
    int? bedrooms,
    int? bathrooms,
    int? floor,
    bool? hasParking,
    bool? hasElevator,
    bool? hasGarden,
    bool? isActive,
    List<String>? images,
    String? ownerName,
    String? ownerPhone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      districtId: districtId ?? this.districtId,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      area: area ?? this.area,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      floor: floor ?? this.floor,
      hasParking: hasParking ?? this.hasParking,
      hasElevator: hasElevator ?? this.hasElevator,
      hasGarden: hasGarden ?? this.hasGarden,
      isActive: isActive ?? this.isActive,
      images: images ?? this.images,
      ownerName: ownerName ?? this.ownerName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}