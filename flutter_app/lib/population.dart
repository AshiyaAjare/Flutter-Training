import 'dart:convert';
import 'package:http/http.dart' as http;

class PopulationEntry {
  final String nation;
  final String year;
  final int population;

  PopulationEntry({
    required this.nation,
    required this.year,
    required this.population,
  });

  factory PopulationEntry.fromJson(Map<String, dynamic> json) {
    return PopulationEntry(
      nation: json['Nation'],
      year: json['Year'],
      population: json['Population'],
    );
  }
}

Future<List<PopulationEntry>> fetchPopulationData() async {
  final url = Uri.parse('https://datausa.io/api/data?drilldowns=Nation&measures=Population');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];
    return data.map((entry) => PopulationEntry.fromJson(entry)).toList();
  } else {
    throw Exception('Failed to load population data');
  }
}
