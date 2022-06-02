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
    //handleLoading(context, widget.presenter.isLoadingStream);
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
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.center,
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 4),
                            children: totalParkingSpots.map((spot) {
                              final _isOccupied = _occupiedSpots.contains(spot);
                              return _spotChip(
                                  onTap: () async {
                                    if (_isOccupied) {
                                      await _showCreateExitModal(
                                          occupiedSpots: _occupiedSpots,
                                          spot: spot);
                                    } else {
                                      await _showCreateEntranceModal(
                                          availableSpots: _availableSpots,
                                          spot: spot);
                                    }
                                  },
                                  label: spot,
                                  isOccupied: _isOccupied);
                            }).toList(),
                          ),
                        )
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
                                onTap: () async {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2023));
                                  // await _showCreateExitModal(
                                  //     occupiedSpots: _occupiedSpots);
                                }),
                            _bottomNavBarButton(
                                color: Theme.of(context).primaryColor,
                                title: 'Entrada',
                                onTap: () async {
                                  await _showCreateEntranceModal(
                                      availableSpots: _availableSpots);
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

  Future _showCreateExitModal(
          {String? spot, required List<String> occupiedSpots}) async =>
      await _showModalBottomSheet(CreateExitModal(
        selectedSpot: spot,
        presenter: widget.presenter,
        occupiedSpots: occupiedSpots,
        onSuccess: () {
          setState(() {});
        },
      ));

  Future _showCreateEntranceModal(
          {String? spot, required List<String> availableSpots}) async =>
      await _showModalBottomSheet(CreateEntranceModal(
        selectedSpot: spot,
        availableSpots: availableSpots,
        presenter: widget.presenter,
        onSuccess: () {
          setState(() {});
        },
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

  Widget _spotChip(
          {required Function() onTap,
          required String label,
          required bool isOccupied}) =>
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isOccupied
                      ? Theme.of(context).primaryColor
                      : Colors.white),
              child: Center(child: Text(label)),
            ),
          ),
        ),
      );

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
