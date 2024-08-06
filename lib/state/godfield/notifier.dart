import 'package:chibikin/external/godfield/godfield.dart';
import 'package:chibikin/view/pages/body/godfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<GodfieldThread> threads = [
  GodfieldThread(),
  GodfieldThread(),
  GodfieldThread(),
  GodfieldThread(),
  GodfieldThread(),
  GodfieldThread(),
  GodfieldThread(),
];

Future<bool> refresh(GodfieldThread godfieldThread) async {
  godfieldThread.token = await godfieldThread.generateToken();
  godfieldThread.randomName = '$username ${generateRandomString(3)}';
  debugPrint(godfieldThread.randomName);
  if (godfieldThread.token == null) {
    debugPrint('Failed to create token');
    return false;
  }
  godfieldThread.roomId = await godfieldThread.createRoom(godfieldThread.randomName, password, godfieldThread.token!);
  if (godfieldThread.roomId == null) {
    debugPrint('Failed to create room');
    return false;
  }
  return await godfieldThread.addRoomUser(godfieldThread.randomName, godfieldThread.roomId!, godfieldThread.token!);
}

bool working = false;
// bool changed = false;

String spamMessage = '';
String password = '';
String username = '';
int accountAmount = 0;
int refreshCount = 5;

Future<void> spamLoop() async {
  while (working) {
    debugPrint('hello');
    if (spamMessage.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
      debugPrint('dd');
      for (final godfieldThread in threads) {
        godfieldThread.ok = await refresh(godfieldThread);
      }
      debugPrint('bb');
      refreshCount = 5;
      for (int i = 0; i < refreshCount; i++) {
        debugPrint('aa');
        for (final godfieldThread in threads) {
          if (!godfieldThread.ok) {
            continue;
          }
          final result = await godfieldThread.sendMessage('$spamMessage ${generateRandomString(3)}', godfieldThread.roomId!, godfieldThread.token!);
          if (!result) debugPrint('Failed to send message');
          else debugPrint('Send message');
        }
      }
    } else {
      break;
    }
  }
}

class GodfieldNotifier extends Notifier<void> {
  @override
  void build() {
    spamMessage = ref.watch(spamMessageProvider);
    password = ref.watch(passwordProvider);
    username = ref.watch(usernameProvider);
    accountAmount = ref.watch(accountAmountProvider);
    refreshCount = ref.watch(refreshCountProvider);
    final isWorking = ref.watch(isSpammingProvider);
    
    if (isWorking) {
      if (!working) {
        working = true;
        spamLoop();
      }
    } else {
      working = false;
    }
  }
}