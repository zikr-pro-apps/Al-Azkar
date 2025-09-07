import 'package:alazkar/src/core/constants/const.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = "/about";

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AboutScreen(),
    );
  }

  const AboutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "عن التطبيق",
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
          ListTile(
            leading: Image.asset(
              "assets/icons/app.png",
            ),
            title: Text("تطبيق $appName الإصدار $appVersion"),
            subtitle: const Text(
                "تطبيق مجاني خالي من الإعلانات ومفتوح المصدر. مقتبس من تطبيق الأذكار النووية للمهندس حسن الطنطاوي"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.handshake),
            title: Text("نسألكم الدعاء لكل من ساهم في التطبيق ولوالديهم"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.source_outlined),
            title: Text("المصدر"),
            subtitle: Text(
                "كتاب التذكرة بأذكار الحج والعمرة للشيخ محمد اسماعيل المقدم"),
          ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.open_in_browser),
          //   title: const Text("رابط تطبيق الأذكار النووية المفتوح المصدر"),
          //   onTap: () {
          //     openURL("https://github.com/muslimpack/Al-Azkar");
          //   },
          // ),
        ],
      ),
    );
  }
}
