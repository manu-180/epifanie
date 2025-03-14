import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme.primary;

    return Stack(
        children: [
          // Fondo con degradado
          Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 222, 230, 252), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80), // Espaciado superior

                // Texto principal
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Plataforma de\n",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      TextSpan(
                        text: "Influencer\nmarketing",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: color, // Color rosa
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Descripción
                const Text(
                  "Epifanie es la plataforma de influencers líder en conectar\n"
                  "anunciantes con influencers. Crea, gestiona y mide campañas\n"
                  "de éxito con las mejores estrategias de marketing.",
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.black54,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600
                    ),
                ),
                const SizedBox(height: 20),

                // Botones
                Row(
                  children: [
                    _customButton("SOY UNA MARCA", color),
                    const SizedBox(width: 15),
                    _customButton("SOY UN INFLUENCER", color),
                  ],
                ),
              ],
            ),
          ),

          // Imágenes decorativas
         
        ],
      );
    
  }

  /// **Botón personalizado**
  Widget _customButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}