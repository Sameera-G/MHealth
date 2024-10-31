import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchTasks(String jobRole, String apiKey) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: json.encode({
      'prompt': 'Generate tasks for the job role of $jobRole.',
      'max_tokens': 100,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return List<String>.from(data['choices'][0]['text']
        .split('\n')
        .where((task) => task.isNotEmpty));
  } else {
    throw Exception('Failed to load tasks');
  }
}
