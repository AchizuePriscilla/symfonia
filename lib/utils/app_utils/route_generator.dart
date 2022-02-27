import 'package:flutter/material.dart';
import 'package:symfonia_task/presentation/views/history_view.dart';
class RouteGenerator {
  static const String historyViewRoute = '/history-view';

  static final routes = <String, WidgetBuilder>{
    historyViewRoute: (_) => const HistoryView()
  };
}
