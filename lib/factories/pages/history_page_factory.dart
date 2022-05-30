import 'package:flutter/material.dart';
import 'package:parking_lot_app/factories/presenters/history_presenter_factory.dart';
import 'package:parking_lot_app/ui/pages/history/history_page.dart';

Widget makeHistoryPage() => HistoryPage(makeHistoryPresenter());
