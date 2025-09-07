import 'package:alazkar/src/core/constants/const.dart';
import 'package:alazkar/src/core/models/zikr.dart';
import 'package:alazkar/src/core/utils/zikr_renderer.dart';
import 'package:alazkar/src/features/zikr_content_viewer/presentation/controller/bloc/zikr_content_viewer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZikrItemCard extends StatelessWidget {
  final Zikr zikr;
  const ZikrItemCard({
    super.key,
    required this.zikr,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<ZikrContentViewerBloc>()
            .add(ZikrContentViewerDecreaseEvent(zikr));
      },
      onLongPress: () {
        final String fullSource = zikr.fullSource;
        if (fullSource.isEmpty) {
          return;
        }
        final SnackBar snackBar = SnackBar(
          content: Text(fullSource),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      },
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.15,
              child: Text(
                zikr.count == 0 ? "تم" : zikr.count.toString(),
                style: TextStyle(
                  fontSize: 250,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Kitab",
                  color: appThemeColor,
                ),
              ),
            ),
          ),
          ListView(
            // physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              ...renderZikrItem(zikr),
              if (zikr.fadl.isNotEmpty) ...[
                const SizedBox(height: 50),
                Text(
                  zikr.fadl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Kitab",
                    fontSize: 30,
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
