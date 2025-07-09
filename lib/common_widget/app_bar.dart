import 'package:agent1/common/color_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double logoHeight; // Height of the logo

  const CustomAppBar({
    super.key,
    this.logoHeight = 35.0, // Default logo height
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset(
        "assets/img/logo1.png",
        height: logoHeight,
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Icon(Icons.headset_mic_outlined, color: TColors.primary),
              SizedBox(width: 12),
              Icon(Icons.person_outline, color: TColors.primary),
            ],
          ),
        ),
      ],
    );
  }

  // Set the preferred size for the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
