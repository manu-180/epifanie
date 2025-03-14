import 'package:supabase_flutter/supabase_flutter.dart';


class GenerarIdUsuario {
  Future<int> generarIdUsuario() async {
  final supabase = Supabase.instance.client;

  final respuesta = await supabase
      .from("epifanie_users")
      .select('id')
      .order("id", ascending: false)
      .limit(1);

  // Si la tabla está vacía, devuelve 1
  if (respuesta.isEmpty) {
    return 1;
  }

  // Si hay datos, suma 1 al ID más alto
  final idUnico = respuesta[0]["id"] + 1;
  return idUnico;
}

}