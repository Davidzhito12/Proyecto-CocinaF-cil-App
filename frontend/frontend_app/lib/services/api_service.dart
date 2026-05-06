import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:5000/api/recetas";

  Future<List<dynamic>> obtenerRecetas() async {
    final response = await http.get(Uri.parse('$baseUrl/recetas'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar recetas');
    }
  }
}
