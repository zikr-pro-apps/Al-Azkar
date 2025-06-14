import 'package:alazkar/src/core/helpers/azkar_helper.dart';
import 'package:alazkar/src/features/share_as_image/presentation/screens/reference_screen.dart';
import 'package:alazkar/src/features/share_as_image/presentation/screens/share_as_image_screen.dart';
import 'package:alazkar/src/features/zikr_content_viewer/presentation/controller/bloc/zikr_content_viewer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZikrContentViewerBottomAppBar extends StatelessWidget {
  final ZikrContentViewerLoadedState state;
  const ZikrContentViewerBottomAppBar({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: state.activeZikr.footnote.isEmpty
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ReferenceScreen(
                                text: state.activeZikr.footnote,
                              );
                            },
                          ),
                        );
                      },
                child: Row(
                  children: [
                    const Icon(
                      Icons.tab,
                      // color: Colors.white,
                    ),
                    SizedBox.fromSize(size: const Size(10, 1)),
                    const Text(
                      "التعليق",
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  context
                      .read<ZikrContentViewerBloc>()
                      .add(ZikrContentViewerCopyEvent());
                },
                icon: const Icon(Icons.copy),
              ),
              IconButton(
                onPressed: () async {
                  context
                      .read<ZikrContentViewerBloc>()
                      .add(ZikrContentViewerShareEvent());
                },
                icon: const Icon(Icons.share),
              ),
              IconButton(
                onPressed: () async {
                  azkarDBHelper
                      .getContentById(state.activeZikr.id)
                      .then((zikr) {
                    Navigator.push(
                      context,
                      ShareAsImageScreen.route(
                        zikr: zikr,
                        zikrTitle: state.zikrTitle,
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
