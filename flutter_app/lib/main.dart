import 'package:flutter/material.dart';
import 'population.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PopulationScreen());
  }
}

class PopulationScreen extends StatefulWidget {
  const PopulationScreen({super.key});
  @override
  State<PopulationScreen> createState() => _PopulationScreenState();
}

class _PopulationScreenState extends State<PopulationScreen> {
  List<PopulationEntry> _data = [];
  bool _dataFetched = false;

  void _fetchData() async {
    try {
      final result = await fetchPopulationData();  // 👈 This comes from the service
      setState(() {
        _data = result;
        _dataFetched = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showDataDialog() {
    if (_data.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fetched Data'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final entry = _data[index];
              return ListTile(
                title: Text('${entry.nation} - ${entry.year}'),
                subtitle: Text('Population: ${entry.population}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('US Population Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _fetchData, child: const Text('Fetch Data')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _dataFetched ? _showDataDialog : null,
              child: const Text('Show Result'),
            ),
          ],
        ),
      ),
    );
  }
}
