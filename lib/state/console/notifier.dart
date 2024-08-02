import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const maxQueueSize = 20;

class ConsoleNotifier extends Notifier<Queue<String>> {
  final Queue<String> _queue = Queue();

  @override
  Queue<String> build() {
    return _queue;
  }

  void add(String log) {
    _queue.addLast(log);
    if (_queue.length > maxQueueSize) _queue.removeFirst();
    state = _queue;
  }
}