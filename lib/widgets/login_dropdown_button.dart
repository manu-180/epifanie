import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginDropdownButton extends StatefulWidget {
  const LoginDropdownButton({super.key});

  @override
  _LoginDropdownButtonState createState() => _LoginDropdownButtonState();
}

class _LoginDropdownButtonState extends State<LoginDropdownButton> {
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDropdown, // Cierra al hacer clic fuera
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + size.height,
            width: size.width,
            child: _buildDropdownMenu(),
          ),
        ],
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
    final bgColor = _getInterpolatedColor(color, color.withOpacity(0.2));

    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor, // ✅ Mismo color que el AppBar
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Inicia Sesión",
              style: TextStyle(
              color:Colors.white,
              fontSize: 16  ,
              fontWeight: FontWeight.w100,
              fontFamily: 'Poppins'
            ),
            ),
            const SizedBox(width: 10),
            AnimatedRotation(
              turns: _isDropdownOpen ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FaIcon(FontAwesomeIcons.chevronDown, color: Colors.white, size: 12),
            ),
          ],
        ),
      ),
    );
  }

  Color _getInterpolatedColor(Color start, Color end) {
    return Color.lerp(start, end, 0.3)!; // ✅ Misma interpolación de color que el AppBar
  }

  Widget _buildDropdownMenu() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropdownItem("Como influencer"),
            _buildDropdownItem("Como empresa"),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String text) {
    return InkWell(
      onTap: _closeDropdown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ),
    );
  }
}
