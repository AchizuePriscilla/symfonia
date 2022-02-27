import 'package:flutter/material.dart';
import 'package:symfonia_task/presentation/shared/palette.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) builder;
  final Color? backgroundColor;
  final AppBar? appBar;
  final Widget? drawer;
  final bool resizeToAvoidBottomInset;
  final Function? onWillPop;
  final Function? onTap;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const ResponsiveWidget({
    Key? key,
    required this.builder,
    this.scaffoldKey,
    this.appBar,
    this.drawer,
    this.backgroundColor,
    this.onWillPop,
    this.onTap,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      Size constraints = Size(constraint.maxWidth, constraint.maxHeight);
      return WillPopScope(
        onWillPop: () {
          if (onWillPop != null) {
            onWillPop!();
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          child: Scaffold(
            key: scaffoldKey,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
            backgroundColor: Palette.offWhite,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBar,
            drawer: drawer,
            body: Builder(
              builder: (context) => builder(context, constraints),
            ),
          ),
        ),
      );
    });
  }
}
