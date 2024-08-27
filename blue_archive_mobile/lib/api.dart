import 'dart:convert';
import 'package:http/http.dart' as http;

class BlueArchiveApi {
  static const String baseUrl = 'https://api-blue-archive.vercel.app/api/';

  static Future<List<dynamic>> fetchCharacters() async {
    final response = await http.get(Uri.parse('${baseUrl}characters'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: $data'); // Debug print
      if (data is Map && data.containsKey('data')) {
        return data['data'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  static Future<List<dynamic>> fetchSchools() async {
    final response = await http.get(Uri.parse('${baseUrl}schools'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: $data'); // Debug print
      if (data is Map && data.containsKey('data')) {
        return data['data'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load schools');
    }
  }
}
