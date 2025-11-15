/// نموذج العقار (Property Model)
class PropertyModel {
  final String id;
  final String code; // كود العقار (مثل: 5008)
  final String title;
  final String description;
  final double price; // أصل العقد أو ثمن الكاش
  final String location; // المنطقة (B11)
  final String city; // المدينة (Madinaty)
  final String imageUrl;
  final List<String> images;
  final PropertyType type;
  final PropertyPurpose purpose; // Category: Sale/Rent/Resale
  final int bedrooms; // غرف نوم
  final int bathrooms; // حمام
  final double area; // المساحة بالمتر المربع
  final bool isFeatured;
  final String? agentName;
  final String? agentPhone;
  final DateTime createdAt;

  // معلومات إضافية للعقار
  final String? group; // مجموعة
  final String? building; // عمارة
  final String? unit; // وحدة
  final int? floor; // الدور
  final PropertyCategory? category; // Apt Resale, Villa Sale, etc.
  final DeliveryStatus? deliveryStatus; // RTM, Ready, Under Construction
  final String? viewDirection; // الواجهة (فيو وايد جاردن)
  final double? gardenArea; // مساحة الجاردن/تراس
  final DateTime? reservationDate; // تاريخ الحجز
  final int? installmentMonths; // مدة القسط بالشهور
  final double? downPayment; // مدفوعات
  final double? overPrice; // أوفر برايس
  final String? installmentDetails; // تفاصيل الأقساط
  final String? notes; // ملاحظات

  const PropertyModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.city,
    required this.imageUrl,
    this.images = const [],
    required this.type,
    required this.purpose,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFeatured = false,
    this.agentName,
    this.agentPhone,
    required this.createdAt,
    this.group,
    this.building,
    this.unit,
    this.floor,
    this.category,
    this.deliveryStatus,
    this.viewDirection,
    this.gardenArea,
    this.reservationDate,
    this.installmentMonths,
    this.downPayment,
    this.overPrice,
    this.installmentDetails,
    this.notes,
  });

  // تحويل من JSON
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      code: json['code'] as String? ?? '',
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      location: json['location'] as String,
      city: json['city'] as String,
      imageUrl: json['imageUrl'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      type: PropertyType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PropertyType.apartment,
      ),
      purpose: PropertyPurpose.values.firstWhere(
        (e) => e.name == json['purpose'],
        orElse: () => PropertyPurpose.sale,
      ),
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      area: (json['area'] as num).toDouble(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      agentName: json['agentName'] as String?,
      agentPhone: json['agentPhone'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      group: json['group'] as String?,
      building: json['building'] as String?,
      unit: json['unit'] as String?,
      floor: json['floor'] as int?,
      category: json['category'] != null
          ? PropertyCategory.values.firstWhere(
              (e) => e.name == json['category'],
              orElse: () => PropertyCategory.aptResale,
            )
          : null,
      deliveryStatus: json['deliveryStatus'] != null
          ? DeliveryStatus.values.firstWhere(
              (e) => e.name == json['deliveryStatus'],
              orElse: () => DeliveryStatus.rtm,
            )
          : null,
      viewDirection: json['viewDirection'] as String?,
      gardenArea: json['gardenArea'] != null
          ? (json['gardenArea'] as num).toDouble()
          : null,
      reservationDate: json['reservationDate'] != null
          ? DateTime.parse(json['reservationDate'] as String)
          : null,
      installmentMonths: json['installmentMonths'] as int?,
      downPayment: json['downPayment'] != null
          ? (json['downPayment'] as num).toDouble()
          : null,
      overPrice: json['overPrice'] != null
          ? (json['overPrice'] as num).toDouble()
          : null,
      installmentDetails: json['installmentDetails'] as String?,
      notes: json['notes'] as String?,
    );
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'city': city,
      'imageUrl': imageUrl,
      'images': images,
      'type': type.name,
      'purpose': purpose.name,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'isFeatured': isFeatured,
      'agentName': agentName,
      'agentPhone': agentPhone,
      'createdAt': createdAt.toIso8601String(),
      'group': group,
      'building': building,
      'unit': unit,
      'floor': floor,
      'category': category?.name,
      'deliveryStatus': deliveryStatus?.name,
      'viewDirection': viewDirection,
      'gardenArea': gardenArea,
      'reservationDate': reservationDate?.toIso8601String(),
      'installmentMonths': installmentMonths,
      'downPayment': downPayment,
      'overPrice': overPrice,
      'installmentDetails': installmentDetails,
      'notes': notes,
    };
  }

  // نسخ مع تعديل
  PropertyModel copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    double? price,
    String? location,
    String? city,
    String? imageUrl,
    List<String>? images,
    PropertyType? type,
    PropertyPurpose? purpose,
    int? bedrooms,
    int? bathrooms,
    double? area,
    bool? isFeatured,
    String? agentName,
    String? agentPhone,
    DateTime? createdAt,
    String? group,
    String? building,
    String? unit,
    int? floor,
    PropertyCategory? category,
    DeliveryStatus? deliveryStatus,
    String? viewDirection,
    double? gardenArea,
    DateTime? reservationDate,
    int? installmentMonths,
    double? downPayment,
    double? overPrice,
    String? installmentDetails,
    String? notes,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      city: city ?? this.city,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      type: type ?? this.type,
      purpose: purpose ?? this.purpose,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      area: area ?? this.area,
      isFeatured: isFeatured ?? this.isFeatured,
      agentName: agentName ?? this.agentName,
      agentPhone: agentPhone ?? this.agentPhone,
      createdAt: createdAt ?? this.createdAt,
      group: group ?? this.group,
      building: building ?? this.building,
      unit: unit ?? this.unit,
      floor: floor ?? this.floor,
      category: category ?? this.category,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      viewDirection: viewDirection ?? this.viewDirection,
      gardenArea: gardenArea ?? this.gardenArea,
      reservationDate: reservationDate ?? this.reservationDate,
      installmentMonths: installmentMonths ?? this.installmentMonths,
      downPayment: downPayment ?? this.downPayment,
      overPrice: overPrice ?? this.overPrice,
      installmentDetails: installmentDetails ?? this.installmentDetails,
      notes: notes ?? this.notes,
    );
  }
}

/// أنواع العقارات
enum PropertyType {
  apartment('شقة'),
  villa('فيلا'),
  duplex('دوبلكس'),
  penthouse('بنتهاوس'),
  studio('استوديو'),
  townhouse('تاون هاوس'),
  land('أرض'),
  commercial('تجاري');

  final String arabicName;
  const PropertyType(this.arabicName);
}

/// الغرض من العقار
enum PropertyPurpose {
  sale('للبيع'),
  rent('للإيجار'),
  both('للبيع والإيجار');

  final String arabicName;
  const PropertyPurpose(this.arabicName);
}

/// فئة العقار (Category)
enum PropertyCategory {
  aptResale('شقة ريسيل'),
  aptSale('شقة بيع'),
  villaSale('فيلا بيع'),
  villaResale('فيلا ريسيل'),
  duplexSale('دوبلكس بيع'),
  duplexResale('دوبلكس ريسيل'),
  penthouseSale('بنتهاوس بيع'),
  penthouseResale('بنتهاوس ريسيل'),
  townhouseSale('تاون هاوس بيع'),
  townhouseResale('تاون هاوس ريسيل');

  final String arabicName;
  const PropertyCategory(this.arabicName);
}

/// حالة الاستلام
enum DeliveryStatus {
  rtm('جاهز للسكن - RTM'),
  ready('جاهز'),
  underConstruction('تحت الإنشاء'),
  semiFinished('نصف تشطيب'),
  finished('تشطيب كامل');

  final String arabicName;
  const DeliveryStatus(this.arabicName);
}
