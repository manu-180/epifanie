import 'package:epifanie/widgets/register_dropdown_button.dart';
import 'package:epifanie/widgets/login_dropdown_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
 

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: color, // ✅ Mismo color interpolado para AppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Epifanie",
            style: TextStyle(
              color:Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              fontFamily: 'Orbitron'
            ),
          ),
          Row(
            children: [
              RegisterDropdownButton(),
              const SizedBox(width: 10),
              LoginDropdownButton(),
            ],
          ),
        ],
      ),
    );
  }

}
