import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? customAppBar;
  final List<Widget>? actions;
  final String? title;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  const BaseScaffold(
      {Key? key,
      required this.body,
      this.bottomNavigationBar,
      this.customAppBar,
      this.actions,
      this.extendBody,
      this.extendBodyBehindAppBar,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      appBar: customAppBar ??
          (title != null || actions != null
              ? AppBar(
                  title: title != null ? Text(title!) : null,
                  actions: actions,
                )
              : null),
      body: body,
      bottomNavigationBar: bottomNavigationBar ?? null,
    );
  }
}
