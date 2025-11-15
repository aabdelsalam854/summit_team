import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/app_colors.dart';

enum ButtonType { text, outlined, filled }

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.buttonType = ButtonType.text,
    this.width = 100,
    this.height = 40,
    required this.arrowIconRight,
    required this.arrowIconLeft, this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final ButtonType buttonType;
  final double height;
  final double width;
  final bool arrowIconRight;
  final bool arrowIconLeft;

  final IconData? icon;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: _buildButtonStyle(),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(icon)],
        ),
      ),
    );
  }

  /// Builds the button style based on the selected [buttonType].
  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: buttonType == ButtonType.outlined
              ? BorderSide(color: borderColor ?? AppColors.primary)
              : BorderSide.none,
        ),
      ),
      backgroundColor: WidgetStateProperty.all(
        buttonType == ButtonType.filled
            ? (backgroundColor ?? AppColors.primary)
            : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(textColor ?? Colors.black),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: fontSize, fontWeight: fontWeight, height: 1.47),
      ),
    );
  }

  Widget buildArrowIcon(bool showIcon, IconData iconData) {
    return showIcon
        ? Icon(iconData, color: textColor ?? Colors.black)
        : const SizedBox();
  }
}
