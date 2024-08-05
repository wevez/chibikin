import 'package:http/http.dart' as http;

class DannaThread {
  Future<bool> sendSine(String postId) async {
    final headers = {
      'accept': '*/*',
      'accept-language': 'ja-JP,ja;q=0.9,en-US;q=0.8,en;q=0.7,ru;q=0.6',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'origin': 'https://danna-shine.com',
      'priority': 'u=1, i',
      'referer': 'https://danna-shine.com/',
      'sec-ch-ua': '"Chromium";v="124", "Google Chrome";v="124", "Not-A.Brand";v="99"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
      'x-requested-with': 'XMLHttpRequest'
    };

    final body = {
      'action': 'question_vote_up',
      'id': postId,
    };

    final response = await http.post(
      Uri.parse('https://danna-shine.com/cms/wp-admin/admin-ajax.php'),
      headers: headers,
      body: body,
    );

    return response.statusCode == 200;
  }
}