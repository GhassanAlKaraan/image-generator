import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<String> makeApiCall(String input) async {
    String result = "Bad Input";
    if (input.isEmpty) return result;

    final url = Uri.parse(
        'https://api.forgeai.com/v1/apps/666f534686f1794e0369114f/view/run');
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': 'YOUR_API_KEY'
    };
    final body = jsonEncode({
      "user_inputs": {
        "Node_Name_6": {"value": input}
      }
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        result = jsonResponse['user_outputs']['Node_Name_13']['value'][0];

        return result;
      } else {
        result = 'Sorry, Http Error Code:${response.statusCode}';
        return result;
      }
    } catch (e) {
      result = 'Error: $e';
      return result;
    }
  }
}
