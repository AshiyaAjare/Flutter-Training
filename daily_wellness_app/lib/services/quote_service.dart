import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static const String _baseUrl = 'https://zenquotes.io/api/random';

  static Future<String> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data[0]['q'] ?? 'Keep going!';
      } else {
        return 'Believe in yourself and all that you are!';
      }
    } catch (e) {
      return 'Every day is a fresh start!';
    }
  }
}

