import 'package:chibikin/state/console/provider.dart';
import 'package:chibikin/state/godfield/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postIdProvider = StateProvider((ref) {
  return '';
});
final isSpammingProvider = StateProvider((ref) {
  return false;
});

class DannaBody extends ConsumerWidget {
  const DannaBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postId = ref.watch(postIdProvider);
    final isSpamming = ref.watch(isSpammingProvider);
    final isSpammingString = isSpamming ? 'Stop spam' : 'Start spam';
    final console = ref.watch(consoleProvider);
    ref.watch(godfieldNotifier);

    return Expanded(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Post ID',
                  ),
                  onChanged: (value) {
                    ref.read(postIdProvider.notifier).state = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(isSpammingProvider.notifier).state = !isSpamming;
                },
                child: Text(isSpammingString),
              ),
              SizedBox(height: 8,),
              Text(
                'Console',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8,),
              Container(
                width: 500,
                height: 500,
                color: Colors.black,
                // child: SingleChildScrollView(
                child: ListView(
                  children: console.map((log) {
                    return Text(
                      log,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}