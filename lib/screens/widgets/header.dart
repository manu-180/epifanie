import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme.primary;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Stack(
        children: [
          // Fondo con degradado
          Container(
            width: double.infinity,
            height: isMobile ? size.height * 0.75 : size.height * 0.85,
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
                 SizedBox(height: isMobile? size.height * 0.1: size.height * 0.08), // Espaciado superior

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
                isMobile? SizedBox(height: size.width * 0.1) : 
                 SizedBox(height: size.width * 0.025),

                // Botones
                isMobile?
                Column(
                  children: [
                    _customButton("SOY UNA MARCA", color, context),
                     SizedBox(height: size.width * 0.034),
                    _customButton("SOY UN INFLUENCER", color, context),
                  ],
                ):
                Row(
                  children: [
                    _customButton("SOY UNA MARCA", color, context),
                     SizedBox(width: size.width * 0.015),
                    _customButton("SOY UN INFLUENCER", color, context),
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
  Widget _customButton(String text, Color color, BuildContext context) {

    final size = MediaQuery.of(context).size;

    final isMobile = size.width < 800;

    return SizedBox(
      width: isMobile ? size.width * 0.5: size.width * 0.15 ,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.08),
          ),
          padding:  isMobile ? EdgeInsets.symmetric(horizontal: size.width * 0.035, vertical: size.width * 0.035):
          EdgeInsets.symmetric(horizontal: 0, vertical: size.width * 0.015),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}