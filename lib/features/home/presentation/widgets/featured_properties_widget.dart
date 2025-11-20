
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/properties/presentation/widgets/property_card_widget.dart';

class FeaturedPropertiesWidget extends StatelessWidget {
  final List<PropertyModel> properties;

  const FeaturedPropertiesWidget({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          cacheExtent: 1200,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: properties.length,
          separatorBuilder: (_, __) => const SizedBox(width: 24),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 340,
              child: PropertyCardWidget(
                property: properties[index],
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
