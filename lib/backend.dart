import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "";

class PassApi {
  static String baseUrl = "";

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  static passInput(String? msg) async {
    var response = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": '$msg'}
          ],
          "temperature": 0.7
        }));

    List<String> patterns = [
      "The $msg stood out in the crowd, capturing attention.",
      "The $msg is great",
      "It is good to hear $msg",
      "I never expected to hear $msg now.",
      "As I gazed at the horizon, a feeling of this $msg.",
      "His/her words were like a soothing melody, echoing the essence of $msg.",
      "The room was filled with $msg, creating a warm and welcoming atmosphere.",
      "In the midst of chaos, I found a moment of $msg that brought peace to my soul.",
      "The journey was challenging, but the destination held the promise of $msg.",
      "Under the starlit sky, the world seemed to embrace the magic of $msg.",
      "As the sun dipped below the horizon, it painted the sky with hues of $msg.",
      "I couldn't believe my eyes when I saw the $msg.",
      "A day without $msg is like a day without sunshine.",
      "The beauty of nature is reflected in the colors of $msg.",
      "Sometimes, all you need is a little bit of $msg."
          "Life is like a puzzle, and $msg is the missing piece."
          "The world is full of surprises, and today's surprise is brought to you by $msg."
          "As the sun sets, I find solace in the simplicity of $msg."
    ];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var message = data['choices'][0]['text'];
      return message;
    } else if (msg != '') {
      print(
          "Free attemps exhausted, can pay openAI to continue with API till then developed a basic sentence framing around a word");
      return (patterns.toList()..shuffle()).first;
    } else {
      return ("Could not capture voice! Please re-record");
    }
  }
}
