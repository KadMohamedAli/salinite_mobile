import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_url_service.dart';

class ApiService {
  static Future<double> fetchSalinity() async {
    final baseUrl = BaseUrlService.getBaseUrl();
    final uri = Uri.parse('$baseUrl/salinity'); // adapt if needed

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('value')) {
          final valueString = data['value'].toString().replaceAll(
            RegExp('[^0-9.]'),
            '',
          );
          return double.parse(valueString);
        } else {
          throw Exception('Clé "value" absente dans la réponse.');
        }
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException("La requête a expiré.");
    } catch (e) {
      throw Exception("Erreur lors de la récupération de la salinité: $e");
    }
  }
}
