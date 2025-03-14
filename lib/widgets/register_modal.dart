import 'package:epifanie/main.dart';
import 'package:epifanie/utils/capitalize.dart';
import 'package:epifanie/utils/generar_id_usuario.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  _RegisterModalState createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String emailError = "";
  String passwordError = "";
  bool isLoading = false;

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// ✅ **Registra usuario en Supabase**
  Future<void> _registerUser() async {
    setState(() => isLoading = true);
    FocusScope.of(context).unfocus(); // Cierra teclado

    final String fullName = Capitalize().capitalize(fullNameController.text.trim());
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      emailError = emailRegex.hasMatch(email) ? "" : "Email no válido";
      passwordError = password.length < 6
          ? "La contraseña debe tener al menos 6 caracteres"
          : password != confirmPassword
              ? "Las contraseñas no coinciden"
              : "";
    });

    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      _showSnackbar("Corrige los errores antes de continuar", Colors.red);
      setState(() => isLoading = false);
      return;
    }

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'created_at': DateTime.now().toUtc().toIso8601String(),
        },
      );


        await supabase.from('epifanie_users').insert({
          'id': await GenerarIdUsuario().generarIdUsuario(),
          'email': email,
          'full_name': fullName,
          "user_uid": res.user!.id,
        });
      
      _showSnackbar("Registro exitoso. Ingrese a su correo para verificarse", Colors.green);
      Navigator.of(context).pop(); // Cierra modal
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
                          "REGISTRARSE",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                        IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // 📌 Campos del formulario
                    _buildTextField("Nombre Completo", fullNameController, primaryColor),
                    _buildTextField("Correo electrónico", emailController, primaryColor, errorText: emailError),
                    _buildTextField("Contraseña", passwordController, primaryColor, isPassword: true, errorText: passwordError),
                    _buildTextField("Confirmar contraseña", confirmPasswordController, primaryColor, isPassword: true),

                    const SizedBox(height: 20),

                    // 🔥 Botón de enviar
                    ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                          : const Text("REGISTRARSE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
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
