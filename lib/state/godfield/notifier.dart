import 'package:chibikin/external/godfield/godfield.dart';
import 'package:chibikin/view/pages/body/godfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<GodfieldThread> threads = [];

class GodfieldNotifier extends Notifier<void> {
  @override
  () build() {
    final spamMessage = ref.watch(spamMessageProvider);
    final password = ref.watch(passwordProvider);
    final username = ref.watch(usernameProvider);
    final accountAmount = ref.watch(accountAmountProvider);
    final isWorking = ref.watch(isSpammingProvider);
    debugPrint('$spamMessage $password $username $accountAmount $isWorking');
    // NOTE: ここでconsoleProviderにprintすると死ぬ
    // if (isWorking) {
    //   ref.read(consoleProvider.notifier).add('$spamMessage $password $username $accountAmount $isWorking');
    // }
    return ();
  }
}