import 'package:epifanie/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  LoginModalState createState() => LoginModalState();
}

class LoginModalState extends State<LoginModal> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailError = "";
  String passwordError = "";
  bool isLoading = false;

  /// ✅ **Registra usuario en Supabase**
  Future<void> _iniciarUser() async {
    setState(() => isLoading = true);
    FocusScope.of(context).unfocus(); // Cierra teclado

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    setState(() {
      passwordError = password.length < 6
          ? "La contraseña debe tener al menos 6 caracteres"
              : "";
    });

    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      _showSnackbar("Corrige los errores antes de continuar", Colors.red);
      setState(() => isLoading = false);
      return;
    }

    try {
     await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);

          } on AuthException catch (e) {
      _showSnackbar(e.message, Colors.red);
    } catch (e) {
      _showSnackbar("Error inesperado: $e", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color,
      duration: const Duration(seconds: 7),),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                width: constraints.maxWidth > 500 ? 500 : constraints.maxWidth * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔥 Título con botón de cerrar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Inicia Sesión",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                        IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // 📌 Campos del formulario
                    _buildTextField("Correo electrónico", emailController, primaryColor, errorText: emailError),
                    _buildTextField("Contraseña", passwordController, primaryColor, isPassword: true, errorText: passwordError),

                    const SizedBox(height: 20),

                    // 🔥 Botón de enviar
                    ElevatedButton(
                      onPressed: _iniciarUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                          : const Text("Inicia sesión", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildTextField(String hint, TextEditingController controller, Color primaryColor,
      {bool isPassword = false, String? errorText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 2), borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          errorText: errorText?.isEmpty == true ? null : errorText,
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
