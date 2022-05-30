import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

class HistoryPage extends StatefulWidget {
  final HistoryPresenter presenter;
  const HistoryPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
