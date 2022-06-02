import 'package:flutter/material.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/mixins/loading_manager.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_entrance_modal.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_exit_modal.dart';
import 'package:parking_lot_app/ui/utils/constants/total_parking_spots.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  const HomePage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LoadingManager {
  @override
  void initState() {
    super.initState();
    handleLoading(context, widget.presenter.isLoadingStream);
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
              return Container();
            } else {
              final _occupiedSpots = _dailyParkingLog.occupiedSpots
                      ?.map((spot) => spot.occupiedSpot)
                      .toList() ??
                  <String>[];

              final _availableSpots = List<String>.from(totalParkingSpots)
                ..removeWhere((spot) => _occupiedSpots.contains(spot));

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _chipTitle(
                                  'Total: ${_dailyParkingLog.totalSpots}'),
                              _chipTitle(
                                  'Ocupadas: ${_dailyParkingLog.occupiedSpots?.length ?? 0}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: .5),
                        color: Colors.black,
                        width: double.infinity,
                        child: Row(
                          children: [
                            _bottomNavBarButton(
                                color: Colors.white,
                                title: 'Saída',
                                onTap: _showCreateExitModal),
                            _bottomNavBarButton(
                                color: Theme.of(context).primaryColor,
                                title: 'Entrada',
                                onTap: () async {
                                  final _success =
                                      await _showCreateEntranceModal(
                                          spots: _availableSpots);
                                  if (_success) setState(() {});
                                })
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              );
            }
          }),
    );
  }

  _showCreateExitModal({String? spot}) async =>
      await _showModalBottomSheet(CreateExitModal(selectedSpot: spot));

  _showCreateEntranceModal({String? spot, required List<String> spots}) async =>
      await _showModalBottomSheet(CreateEntranceModal(
        selectedSpot: spot,
        availableSpots: spots,
        presenter: widget.presenter,
      ));

  Future<void> _showModalBottomSheet(Widget modal) async {
    await showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(.1),
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => modal);
  }

  Widget _chipTitle(String title) => Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(5),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget _bottomNavBarButton(
          {required String title,
          required Color color,
          required Function() onTap}) =>
      Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height * .1,
          color: color,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Center(child: Text(title)),
          ),
        ),
      );
}
