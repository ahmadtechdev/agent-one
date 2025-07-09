import 'package:agent1/common/color_extension.dart';
import 'package:flutter/material.dart';


enum RoundButtonType { bgPrimary, textPrimary }

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final RoundButtonType type;
  final double fontSize;
  final Color? color;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize = 16,
    this.type = RoundButtonType.bgPrimary,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ??
        (type == RoundButtonType.bgPrimary ? TColors.primary : TColors.white);
    final textColor = type == RoundButtonType.bgPrimary
        ? TColors.white
        : (color ?? TColors.primary);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: type == RoundButtonType.bgPrimary
              ? null
              : Border.all(color: TColors.primary, width: 1),
          color: buttonColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
