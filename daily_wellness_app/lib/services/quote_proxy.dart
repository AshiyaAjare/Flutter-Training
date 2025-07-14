import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

// Handler for the /api/quote route
Future<Response> _handleQuoteRequest(Request request) async {
  try {
    final res = await http.get(Uri.parse('https://zenquotes.io/api/random'));
    if (res.statusCode == 200) {
      return Response.ok(res.body, headers: {
        'Content-Type': 'application/json',
      });
    } else {
      return Response.internalServerError(
        body: jsonEncode({'error': 'Failed to fetch quote'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': 'Exception: $e'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

void main() async {
  final handler = Pipeline()
      .addMiddleware(logRequests())        
      
      .addMiddleware(corsHeaders())        
      .addHandler((Request request) {
        if (request.url.path == 'api/quote') {
          return _handleQuoteRequest(request);
        }
        return Response.notFound('Not Found');
      });

  final server = await io.serve(handler, 'localhost', 8080);
  print('Dart proxy running on http://${server.address.host}:${server.port}');
}
