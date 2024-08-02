import 'package:chibikin/state/godfield/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Notifer = GodfieldNotifier;
typedef _State = void;

final godfieldNotifier = NotifierProvider<_Notifer, _State>(
  () {
    return _Notifer();
  }
);