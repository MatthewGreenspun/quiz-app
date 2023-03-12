import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../global_store.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStore>(
        builder: (_, globalStore, __) => Observer(
            builder: (_) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 8),
                    const Text(
                      'AP Computer Science A',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    globalStore.user != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10000),
                            child: Image.network(
                              globalStore.user!.photoURL!,
                              height: 34,
                            ),
                          )
                        : const CircleAvatar(
                            maxRadius: 17,
                            child: Text("A"),
                          )
                  ],
                )));
  }
}
