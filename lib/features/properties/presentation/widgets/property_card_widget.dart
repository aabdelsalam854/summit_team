import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

/// ---------------------------------------------------------------------------
///  🟥 PropertyCardWidget — الكارد الرئيسي للعقار
/// ---------------------------------------------------------------------------
class PropertyCardWidget extends StatelessWidget {
  const PropertyCardWidget({super.key, required this.property, this.onTap});

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
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // الصورة مع AspectRatio
            Expanded(
              // fit: FlexFit.loose,
              flex: 2,
              child: PropertyImageWidget(property: property),
            ),

            // المحتوى
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: ItemCardDetails(property: property),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCardDetails extends StatelessWidget {
  const ItemCardDetails({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // PropertyPriceWidget(price: property.price),
          FittedBox(
            fit: BoxFit.scaleDown,
            // fit: BoxFit.fitHeight,
            child: Text(
              "${property.title} ${property.description}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.styleSemiBold18(context),
            ),
          ),         Flexible(
            fit: FlexFit.loose,
            child: const SizedBox(height: 8)),
          Text(
            _formatPrice(property.price),
            style: AppStyles.styleBold18(context),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: const SizedBox(height: 8)),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AlessamyColors.mediumGray,
              ),
              const SizedBox(width: 4),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  property.location,
                  style: AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: AlessamyColors.textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Flexible(
                fit: FlexFit.loose,
                child: PropertySpecificationsWidget(property: property),
              ),
            ],
          ),
        ],
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
///  🟩 PropertyImageWidget — ويدجت الصورة
/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
///  🟩 PropertyImageWidget — ويدجت الصورة
/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
///  🟩 PropertyImageWidget — ويدجت الصورة
/// ---------------------------------------------------------------------------
class PropertyImageWidget extends StatelessWidget {
  const PropertyImageWidget({
    super.key,
    required this.property,
    this.isNarrow = false,
  });

  final PropertyModel property;
  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // الارتفاع يكون نسبة من العرض المتاح
        final imageHeight = constraints.maxWidth * 0.65;

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: SizedBox(
            // height: imageHeight.clamp(150, 220),
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: property.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AlessamyColors.lightGray,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AlessamyColors.lightGray,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: isNarrow ? 32 : 48,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
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
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AlessamyColors.primaryGold.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(_formatPrice(price), style: AppStyles.styleBold18(context)),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AlessamyColors.darkGray),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppStyles.styleRegular12(
            context,
          ).copyWith(color: AlessamyColors.textSecondary),
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
        // PropertySpecItemWidget(
        //   icon: Icons.bed_outlined,
        //   text: '${property.bedrooms}',
        // ),
        // const SizedBox(width: 16),
        // PropertySpecItemWidget(
        //   icon: Icons.bathroom_outlined,
        //   text: '${property.bathrooms}',
        // ),
        // const SizedBox(width: 16),
        PropertySpecItemWidget(
          icon: Icons.square_foot_outlined,
          text: '${property.area.toInt()} م²',
        ),
      ],
    );
  }
}
