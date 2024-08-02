import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spamMessageProvider = StateProvider((ref) {
  return '';
});
final passwordProvider = StateProvider((ref) {
  return '';
});
final usernameProvider = StateProvider((ref) {
  return '';
});
const maxAccountAmount = 100;
final accountAmountProvider = StateProvider((ref) {
  final accountAmountPercentage = ref.watch(accountAmountPercentageProvider);
  return (maxAccountAmount * accountAmountPercentage).toInt();
});
final accountAmountPercentageProvider = StateProvider((ref) {
  return 1.0;
});
final isSpammingProvider = StateProvider((ref) {
  return false;
});

class GodFieldBody extends ConsumerWidget {
  const GodFieldBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAmount = ref.watch(accountAmountProvider);
    final isSpamming = ref.watch(isSpammingProvider);
    final isSpammingString = isSpamming ? 'Stop spam' : 'Start spam';

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
                    hintText: 'Spam Message',
                  ),
                  onChanged: (value) {
                    ref.read(spamMessageProvider.notifier).state = value;
                  },
                ),
              ),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  onChanged: (value) {
                    ref.read(passwordProvider.notifier).state = value;
                  },
                ),
              ),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                  onChanged: (value) {
                    ref.read(usernameProvider.notifier).state = value;
                  },
                ),
              ),
              SizedBox(height: 16,),
              Text(
                'Account amount: $accountAmount',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 500,
                child: Slider(
                  value: ref.watch(accountAmountPercentageProvider),
                  onChanged: (value) {
                    ref.read(accountAmountPercentageProvider.notifier).state = value;
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
                  children: [
                    Text(
                      ' a',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}