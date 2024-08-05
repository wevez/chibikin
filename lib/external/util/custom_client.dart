import 'package:http/http.dart' as http;

// CookieとUser-Agent付きのHttpClient
class CustomClient extends http.BaseClient {
  final http.Client _client;

  // final Map<String, String> _defaultHeaders = {
  //   'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0',
  //   'Accept': '*/*',
  //   'Accept-Language': 'en-US,en;q=0.5',
  //   'Accept-Encoding': 'gzip, deflate, br, zstd',
  //   'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //   'X-Requested-With': 'XMLHttpRequest',
  //   'Content-Length': '0',
  //   'Connection': 'keep-alive'
  // };

  final Map<String, String> _cookies = {};

  CustomClient(this._client);

  void _parseCookies(String cookieHeader) {
    final cookies = cookieHeader.split(';');

    for (var cookie in cookies) {
      final parts = cookie.split('=');
      if (parts.length == 2) {
        _cookies[parts[0].trim()] = parts[1].trim();
      }
    }
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // request.headers.addAll(_defaultHeaders);

    if (_cookies.isNotEmpty) {
      request.headers['Cookie'] = _cookies.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('; ');
    }

    return _client.send(request).then((response) {
      final setCookieHeader = response.headers['set-cookie'];
      if (setCookieHeader != null) {
        _parseCookies(setCookieHeader);
      }
      return response;
    });
  }

  @override
  void close() {
    _client.close();
    super.close();
  }
}