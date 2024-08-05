import 'package:chibikin/external/godfield/godfield.dart';
import 'package:chibikin/view/pages/body/godfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<GodfieldThread> threads = [
  GodfieldThread('', '', '', 0),
  GodfieldThread('', '', '', 0),
  GodfieldThread('', '', '', 0),
  GodfieldThread('', '', '', 0),
  GodfieldThread('', '', '', 0),
];

class GodfieldNotifier extends Notifier<void> {
  @override
  () build() {
    final spamMessage = ref.watch(spamMessageProvider);
    final password = ref.watch(passwordProvider);
    final username = ref.watch(usernameProvider);
    final accountAmount = ref.watch(accountAmountProvider);
    final isWorking = ref.watch(isSpammingProvider);
    debugPrint('$spamMessage $password $username $accountAmount $isWorking');
    // threads.add(GodfieldThread(spamMessage, password, username, 10));
    // threads.forEach((thread) {
    //   thraed.start();
    // })
    if (spamMessage.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
      threads.forEach((godfieldThread) {
        godfieldThread.setSpamMessage(spamMessage);
        godfieldThread.setPassword(password);
        godfieldThread.setName(username);
        godfieldThread.setWorking(isWorking);
        godfieldThread.setRefreshCount(10);
        godfieldThread.start();
      });
    }
    // NOTE: ここでconsoleProviderにprintすると死ぬ
    // if (isWorking) {
    //   ref.read(consoleProvider.notifier).add('$spamMessage $password $username $accountAmount $isWorking');
    // }
    return ();
  }
}