import 'package:chibikin/external/util/custom_client.dart';
import 'package:http/http.dart';

class GodfieldThread {
  bool _isWorking = false;
  String _spamMessage;
  GodfieldThread(this._spamMessage);
  final CustomClient client = CustomClient(Client());
  void setWorking(bool working) {
    _isWorking = working;
  }
  void setSpamMessage(String message) {
    _spamMessage = message;
  }
  Future<void> start() async {
    while (true) {
      if (!_isWorking) {
        // final res = await client.get(Uri.parse('https://example.com/'));
        return;
      }
    }
  }
}