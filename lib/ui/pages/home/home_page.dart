import 'package:flutter/material.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/mixins/loading_manager.dart';
import 'package:parking_lot_app/ui/mixins/ui_error_mixin.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_entrance_modal.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_exit_modal.dart';
import 'package:parking_lot_app/ui/pages/home/views/parking_spots_view.dart';
import 'package:parking_lot_app/ui/utils/constants/total_parking_spots.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  const HomePage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LoadingManager, UiErrorMixin {
  @override
  void initState() {
    handleError(context, widget.presenter.messageStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estacionamento Seu João"),
        centerTitle: true,
        actions: [
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pushNamed('/history');
              },
              child: Icon(Icons.history),
            ),
          ),
        ],
      ),
      body: FutureBuilder<IParkingDailyLog?>(
          future: widget.presenter.fetchDailyParkingLot(),
          builder: (context, snapshot) {
            var _dailyParkingLog = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (_dailyParkingLog == null) {
              //TO-DO error message
              return Center(
                child: Text('Sem dados disponíveis, tente novamente.'),
              );
            } else {
              return ParkingSpotsView(
                  parkingDailyLog: _dailyParkingLog,
                  presenter: widget.presenter);
            }
          }),
    );
  }
}
