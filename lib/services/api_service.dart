// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'base_url_service.dart';

// class ApiService {
//   static Future<double> fetchSalinity() async {
//     final baseUrl = BaseUrlService.getBaseUrl();
//     final uri = Uri.parse('$baseUrl/salinity'); // adapt if needed

//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['value'].toDouble(); // assuming JSON { "value": 12.3 }
//     } else {
//       throw Exception('Failed to load salinity data');
//     }
//   }
// }

import 'dart:math';
import 'dart:async';

class ApiService {
  static Future<double> fetchSalinity() async {
    await Future.delayed(const Duration(seconds: 1));

    final random = Random();
    final chance = random.nextDouble();

    // 30% chance of error
    if (chance < 0.3) {
      if (chance < 0.15) {
        throw TimeoutException("La requête a expiré.");
      } else {
        throw Exception("Erreur serveur (500). Veuillez réessayer.");
      }
    }

    // Return random value between 10.0 and 40.0
    return 10.0 + random.nextDouble() * 30.0;
  }
}
