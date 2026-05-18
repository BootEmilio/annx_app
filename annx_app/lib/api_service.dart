import 'dart:convert';
import 'package:http/http.dart' as http;
import 'categoria.dart';
import 'alimento.dart';

class ApiService {
  final String baseUrl = "https://nutri-annx.onrender.com"; // cambia esto

  Future<List<Categoria>> obtenerCategorias() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/grupos'),
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData
          .map((item) => Categoria.fromJson(item))
          .toList();
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  
Future<List<Alimento>> obtenerAlimentosPorGrupo(int grupoId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/api/alimentos/grupo/$grupoId'),
  );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);

    return data.map((e) => Alimento.fromJson(e)).toList();
  } else {
    throw Exception('Error al cargar alimentos');
  }
}

}