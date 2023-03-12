import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/login_page.dart';
import '../global_store.dart';
import "../login/authentication.dart";

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
                        ? GestureDetector(
                            onTap: () {
                              showModalSideSheet(
                                  context: context,
                                  barrierDismissible: true,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  body: SafeArea(
                                      child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                globalStore.user!.displayName!,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                globalStore.user!.email!,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: Image.network(
                                                    globalStore.user!.photoURL!,
                                                    width: 90,
                                                  )),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Authentication.signOut(
                                                            context: context)
                                                        .then((value) => Navigator
                                                            .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        SignInScreen()),
                                                                (route) =>
                                                                    false));
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.red),
                                                  child: const Text("Sign out"))
                                            ],
                                          ))));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10000),
                              child: Image.network(
                                globalStore.user!.photoURL!,
                                height: 34,
                              ),
                            ))
                        : const CircleAvatar(
                            maxRadius: 17,
                            child: Text("A"),
                          )
                  ],
                )));
  }
}
