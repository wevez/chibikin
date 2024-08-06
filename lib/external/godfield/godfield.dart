import 'dart:convert';
import 'dart:math';

import 'package:chibikin/external/util/custom_client.dart';
import 'package:http/http.dart';

class GodfieldThread {
  // String _spamMessage;
  // String _password;
  // String _name;
  // int _refreshCount;
  // int _sendCount = 0;
  // String? _token = null;
  String? token;
  String? roomId;
  String randomName='';
  bool ok = false;
  GodfieldThread();
  final CustomClient client = CustomClient(Client());
  // Future<void> start() async {
  //   final username = "$_name ${generateRandomString(3)}";
  //   // if (await isUsernameDuplicated(username)) {
  //   //   debug("ランダムユーザー名 [$username] が重複しているため、ユーザー名を再生成します");
  //   //   generatedUsernames.remove(username);
  //   //   startMain();
  //   //   return;
  //   // }
  //   int retryCount = 0;
  //   final token = await generateToken();
  //   // generatedUsernames.add(username);
  //   if (token != null) {
  //     debugPrint("<$username> トークンを生成しました");
  //     final roomId = await createRoom(username, _password, token);
  //     if (roomId != null) {
  //       // if (await isUsernameDuplicated(username, true)) {
  //       //   debug("ランダムユーザー名 [$username] が重複しているため、ユーザー名を再生成します");
  //       //   generatedUsernames.remove(username);
  //       //   startMain();
  //       //   return;
  //       // }
  //       // userDatasForRemove.add(Triple(roomId, token, username));
  //       // updateTitle();
  //       debugPrint("<$username> 部屋を作成しました");
  //       final doAddRoomUser = await addRoomUser(username, roomId, token);
  //       if (doAddRoomUser) {
  //         debugPrint("<$username> 部屋に参加しました");
  //         var canceller = false;
  //         while (true) {
  //           // if (!_isWorking) return;
  //           if (canceller || retryCount >= _refreshCount) {
  //             debugPrint("<$username> 新しいアカウントにリフレッシュします");
  //             final doRemoveUser = await removeUser(roomId, token);
  //             if (doRemoveUser) {
  //               debugPrint("<$username> 部屋を退出しました");
  //               // generatedUsernames.remove(username);
  //               // userDatasForRemove.remove(Triple(roomId, token, username));
  //               // updateTitle();
  //             }
  //             // startMain();
  //             return;
  //           }
  //           final doSendMessage = await sendMessage('$_spamMessage ${generateRandomString(5)}', roomId, token);
  //           if (doSendMessage) {
  //             retryCount += 1;
  //             debugPrint("<$username> メッセージを送信しました [$_spamMessage] (x$retryCount)");
  //           } else {
  //             canceller = true;
  //             debugPrint('failed to send messsage');
  //           }
  //         }
  //       } else {
  //         // generatedUsernames.remove(username);
  //         // startMain();
  //         return;
  //       }
  //     } else {
  //       debugPrint("無効なユーザー名 [$username] が検出されたため、全スパマーの動作を停止します");
  //       // stopTask();
  //       return;
  //     }
  //   } else {
  //     debugPrint("<$username> トークンの生成に失敗しました");
  //   }
  // }
  Future<String?> generateToken() async {
    final headers = {
      'authority': 'securetoken.googleapis.com',
      'accept': '*/*',
      'accept-language': 'ja,en-US;q=0.9,en;q=0.8',
      'content-type': 'application/x-www-form-urlencoded',
      'origin': 'https://godfield.net',
      'referer': 'https://godfield.net/',
      'sec-ch-ua': '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'x-client-data': 'CJG2yQEIpLbJAQipncoBCPeUywEIlqHLAQjvmM0BCIWgzQEIou7NAQiD8M0BGKfqzQE=',
      'x-client-version': 'Chrome/JsCore/8.10.0/FirebaseCore-web',
    };

    final form = {
      'grant_type': 'refresh_token',
      'refresh_token': 'AMf-vBwT2W6HzKVweOopgMNeL2uZy0l_k4kIefACye_rv41Cknxgjdc-0JzZVB2chTYpQ3lGKapTTRIpfk5pLK0upVGBzjjkbgTGvVeh8XlqgyFML4-JOf_NLwaP9fn6KMiyTUlHVcmuL9TlBsXdXhwUvvUHb9ARNupchiGyOgZap6omQMExSxw',
    };

    final uri = Uri.https('www.googleapis.com', '/identitytoolkit/v3/relyingparty/signupNewUser', {
      'key': 'AIzaSyCBvMvZkHymK04BfEaERtbmELhyL8-mtAg',
    });

    final response = await client.post(uri, headers: headers, body: form);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['idToken'] as String?;
    } else {
      return null;
    }
  }
  Future<String?> createRoom(String username, String aikotoba, String token) async {
    final headers = {
      'accept': '*/*',
      'accept-language': 'ja,en-US;q=0.9,en;q=0.8',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
      'origin': 'https://godfield.net',
      'priority': 'u=1, i',
      'referer': 'https://godfield.net/',
      'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Opera";v="112"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0'
    };

    final body = jsonEncode({
      'mode': 'hidden',
      'password': aikotoba,
      'userName': username,
    });

    final response = await client.post(
      Uri.parse('https://asia-northeast1-godfield.cloudfunctions.net/createRoom'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['roomId'] as String?;
    } else {
      return null;
    }
  }
  Future<bool> addRoomUser(String username, String roomId, String token) async {
    final headers = {
      'accept': '*/*',
      'accept-language': 'ja,en-US;q=0.9,en;q=0.8',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
      'origin': 'https://godfield.net',
      'priority': 'u=1, i',
      'referer': 'https://godfield.net/',
      'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Opera";v="112"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0'
    };

    final body = jsonEncode({
      'mode': 'hidden',
      'roomId': roomId,
      'userName': username,
    });

    final response = await client.post(
      Uri.parse('https://asia-northeast1-godfield.cloudfunctions.net/addRoomUser'),
      headers: headers,
      body: body,
    );

    return response.statusCode == 200;
  }
  Future<bool> sendMessage(String message, String roomId, String token) async {
    final headers = {
      'accept': '*/*',
      'accept-language': 'ja,en-US;q=0.9,en;q=0.8',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
      'origin': 'https://godfield.net',
      'priority': 'u=1, i',
      'referer': 'https://godfield.net/',
      'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Opera";v="112"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0'
    };

    final body = jsonEncode({
      'mode': 'hidden',
      'roomId': roomId,
      'text': message,
    });

    final response = await client.post(
      Uri.parse('https://asia-northeast1-godfield.cloudfunctions.net/setComment'),
      headers: headers,
      body: body,
    );

    return response.statusCode == 200;
  }
  Future<bool> removeUser(String roomId, String token) async {
    final headers = {
      'accept': '*/*',
      'accept-language': 'ja,en-US;q=0.9,en;q=0.8',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
      'origin': 'https://godfield.net',
      'priority': 'u=1, i',
      'referer': 'https://godfield.net/',
      'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Opera";v="112"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0'
    };

    final body = jsonEncode({
      'mode': 'hidden',
      'roomId': roomId,
    });

    final response = await client.post(
      Uri.parse('https://asia-northeast1-godfield.cloudfunctions.net/removeRoomUser'),
      headers: headers,
      body: body,
    );

    return response.statusCode == 200;
  }
}

String generateRandomString(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random();
  return List.generate(length, (index) => chars[rand.nextInt(chars.length)]).join('');
}