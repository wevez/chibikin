import 'package:chibikin/view/pages/body/godfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bodyProvider = StateProvider((ref) {
  return GodFieldBody();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = ref.watch(bodyProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('a'),
      // ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            color: Colors.blue,
            child: ListView(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      'Godfield',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    ref.read(bodyProvider.notifier).state = GodFieldBody();
                  },
                ),
              ],
            ),
          ),
          body,
        ],
      )
    );
  }
}