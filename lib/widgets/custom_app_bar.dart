import 'package:epifanie/widgets/login_dropdown_button.dart';
import 'package:epifanie/widgets/login_modal.dart';
import 'package:epifanie/widgets/register_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:epifanie/widgets/register_modal.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _openRegisterModal() {
    showDialog(
      context: context,
      builder: (context) => const RegisterModal(),
    );
  }

  void _openLoginModal() {
    showDialog(
      context: context,
      builder: (context) => const LoginModal(),
    );
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);


    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        right: 20,
        width: 300,
        child: Material(
          color: Colors.transparent,
          child: _buildDropdownMenu(),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isDropdownOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return AppBar(
      backgroundColor: color,
      title: const Text(
        "Epifanie",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'Orbitron',
        ),
      ),
      actions: [
        isMobile ?
        IconButton(
          icon: AnimatedRotation(
            turns: _isDropdownOpen ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: const Icon(Icons.expand_more, color: Colors.white),
          ),
          onPressed: _toggleDropdown,
        ):Row(
            children: [
              RegisterDropdownButton(),
              const SizedBox(width: 10),
              LoginDropdownButton(),
            ],
          ),
      ],
    );
  }

  /// **🔥 Widget del menú desplegable**
  Widget _buildDropdownMenu() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDropdownItem("Registrate como influencer", false),
          _buildDropdownItem("Registrate como empresa", false),
          _buildDropdownItem("Inicia sesión como influencer",true),
          _buildDropdownItem("Inicia sesión como empresa",true),
        ],
      ),
    );
  }

  /// **🔥 Opción individual en el desplegable**
  Widget _buildDropdownItem(String text, bool login) {
    return InkWell(
      onTap: () {
        _closeDropdown();
        login? _openLoginModal() : _openRegisterModal();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ),
    );
  }
}

