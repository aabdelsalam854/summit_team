import 'package:flutter/material.dart';
import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      color: AlessamyColors.black,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterIcon(Icons.facebook),
              // SizedBox(width: 28),
              _buildFooterIcon(Icons.chat),
              // SizedBox(width: 28),
              _buildFooterIcon(Icons.phone),
              // SizedBox(width: 28),
              _buildFooterIcon(Icons.email),
            ],
          ),
          // SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 1,
              width: 220,
              color: AlessamyColors.primaryGold.withValues(alpha: 0.3),
            ),
          ),
          // SizedBox(height: 28),
          Text(
            AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.rightsReserved),
            style: TextStyle(
              fontSize: 15,
              color: AlessamyColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AlessamyColors.primaryGold.withValues(alpha: 0.3),
        ),
      ),
      child: Icon(icon, color: AlessamyColors.primaryGold, size: 26),
    );
  }
}
