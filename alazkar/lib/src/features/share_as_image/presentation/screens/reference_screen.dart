// import 'package:alazkar/src/core/constants/const.dart';
// import 'package:alazkar/src/core/utils/open_url.dart';
import 'package:flutter/material.dart';

class ReferenceScreen extends StatelessWidget {
  static const String routeName = "/reference";

  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => const ReferenceScreen(),
  //   );
  // }

  final String text;
  const ReferenceScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "التعليق",
          style: TextStyle(fontFamily: "Uthmanic"),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 15),
          Text(
            text,
            // textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Kitab",
              fontSize: 25,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
