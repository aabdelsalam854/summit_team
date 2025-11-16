
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/properties/presentation/widgets/property_card_widget.dart';

class LatestPropertiesGrid extends StatelessWidget {
  final List<PropertyModel> properties;

  const LatestPropertiesGrid({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final featuredProperties = properties.where((p) => p.isFeatured).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // ---- حسابات الريسبونسيف ----
        final targetCardWidth = 360;
        int crossAxisCount = (width / targetCardWidth).floor();
        crossAxisCount = crossAxisCount.clamp(3, 6);

        final spacing = 24;
        final totalSpacing = spacing * (crossAxisCount - 1);
        final availableWidth = width - 96 - totalSpacing;
        final itemWidth = availableWidth / crossAxisCount;
        final itemHeight = itemWidth * .85;
        final childAspectRatio = itemWidth / itemHeight;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.invertedStylus,
              },
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: spacing.toDouble(),
                mainAxisSpacing: 24,
              ),
              itemCount: featuredProperties.length,
              itemBuilder: (context, index) {
                return PropertyCardWidget(
                  property: featuredProperties[index],
                  onTap: () {},
                );
              },
            ),
          ),
        );
      },
    );
  }
}
