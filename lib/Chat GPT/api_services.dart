import 'dart:convert';

import 'package:http/http.dart' as http;

String apikey = "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";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apikey'
  };

  static sendMeaasage(String? message) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": "$message",
          "max_tokens": 100,
          "temperature": 0,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": ["Human:", "AI:"]
        }));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
    } else {
      // ignore: avoid_print
      print("failed to fetch data");
    }
  }
}
