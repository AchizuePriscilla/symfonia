import 'package:flutter/material.dart';

import '../shared/shared.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return const Center(child: EmptyWidget());
    });
  }
}
