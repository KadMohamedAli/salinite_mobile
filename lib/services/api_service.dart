import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_url_service.dart';

class ApiService {
  static Future<double> fetchSalinity() async {
    final baseUrl = BaseUrlService.getBaseUrl();
    final uri = Uri.parse('$baseUrl/salinity'); // adapt if needed

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['value'].toDouble(); // assuming JSON { "value": 12.3 }
    } else {
      throw Exception('Failed to load salinity data');
    }
  }
}
