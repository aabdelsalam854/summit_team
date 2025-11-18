import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

/// ---------------------------------------------------------------------------
///  🟥 PropertyCardWidget — الويجت الرئيسي لبطاقة العقار
/// ---------------------------------------------------------------------------
class PropertyCardWidget extends StatelessWidget {
  const PropertyCardWidget({
    super.key,
    required this.property,
    this.onTap,
  });

  final PropertyModel property;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AlessamyColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// صورة العقار
            PropertyImageWidget(property: property),

            /// تفاصيل العقار
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// السعر
                  PropertyPriceWidget(price: property.price),

                  SizedBox(height: 8),

                  /// العنوان
                  Text(
                    property.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AlessamyColors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4),

                  /// الموقع
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AlessamyColors.mediumGray,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${property.location}, ${property.city}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AlessamyColors.textLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// المواصفات (غرف - حمامات - مساحة)
                  PropertySpecificationsWidget(property: property),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  🟩 PropertyImageWidget — ويدجت صورة العقار
/// ---------------------------------------------------------------------------
class PropertyImageWidget extends StatelessWidget {
  const PropertyImageWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// الصورة
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            property.imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 180,
                color: AlessamyColors.lightGray,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 48,
                  color: AlessamyColors.mediumGray,
                ),
              );
            },
          ),
        ),

        /// Badge للعقارات المميزة
        if (property.isFeatured)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AlessamyColors.warning,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'مميز',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AlessamyColors.white,
                ),
              ),
            ),
          ),

        /// Badge لنوع العقار (بيع / إيجار)
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: property.purpose == PropertyPurpose.sale
                  ? AlessamyColors.primaryGold
                  : AlessamyColors.success,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              property.purpose.arabicName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AlessamyColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  🟦 PropertyPriceWidget — ويدجت السعر
/// ---------------------------------------------------------------------------
class PropertyPriceWidget extends StatelessWidget {
  const PropertyPriceWidget({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AlessamyColors.primaryGold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _formatPrice(price),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AlessamyColors.primaryGold,
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} مليون جنيه';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ألف جنيه';
    } else {
      return '${price.toStringAsFixed(0)} جنيه';
    }
  }
}

/// ---------------------------------------------------------------------------
///  🟨 PropertySpecItemWidget — عنصر واحد من المواصفات
/// ---------------------------------------------------------------------------
class PropertySpecItemWidget extends StatelessWidget {
  const PropertySpecItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AlessamyColors.darkGray),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: AlessamyColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  🟧 PropertySpecificationsWidget — صف كامل بالمواصفات
/// ---------------------------------------------------------------------------
class PropertySpecificationsWidget extends StatelessWidget {
  const PropertySpecificationsWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PropertySpecItemWidget(icon: Icons.bed_outlined, text: '${property.bedrooms}'),
        SizedBox(width: 16),
        PropertySpecItemWidget(icon: Icons.bathroom_outlined, text: '${property.bathrooms}'),
        SizedBox(width: 16),
        PropertySpecItemWidget(
          icon: Icons.square_foot_outlined,
          text: '${property.area.toInt()} م²',
        ),
      ],
    );
  }
}
