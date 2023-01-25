import 'dart:convert';
import 'package:http/http.dart' as http;

 

  Future<String> generateResponse(String prompt) async {
    final apiKey = "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";


    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

   // final responseJson = jsonDecode(response.body);
    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];
  }

