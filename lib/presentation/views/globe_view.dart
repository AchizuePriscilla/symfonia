import 'package:flutter/material.dart';
import 'package:symfonia_task/presentation/shared/shared.dart';

class GlobeView extends StatelessWidget {
  const GlobeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return const Center(child: EmptyWidget());
    });
  }
}
