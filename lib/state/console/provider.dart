import 'dart:collection';

import 'package:chibikin/state/console/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Notifier = ConsoleNotifier;
typedef _State = Queue<String>;

final consoleProvider = NotifierProvider<_Notifier, _State>(
  () {
    return _Notifier();
  },
);