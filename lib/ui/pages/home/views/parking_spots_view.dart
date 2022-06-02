import 'package:flutter/material.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_entrance_modal.dart';
import 'package:parking_lot_app/ui/pages/home/modals/create_exit_modal.dart';
import 'package:parking_lot_app/ui/utils/constants/total_parking_spots.dart';

class ParkingSpotsView extends StatefulWidget {
  final HomePresenter presenter;
  final IParkingDailyLog parkingDailyLog;
  ParkingSpotsView(
      {Key? key, required this.parkingDailyLog, required this.presenter})
      : super(key: key);

  @override
  State<ParkingSpotsView> createState() => _ParkingSpotsViewState();
}

class _ParkingSpotsViewState extends State<ParkingSpotsView> {
  late final _occupiedSpots = widget.parkingDailyLog.occupiedSpots
          ?.map((spot) => spot.occupiedSpot)
          .toList() ??
      <String>[];

  late final _availableSpots = List<String>.from(totalParkingSpots)
    ..removeWhere((spot) => _occupiedSpots.contains(spot));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _chipTitle(
                            'Total: ${widget.parkingDailyLog.totalSpots}'),
                        _chipTitle(
                            'Ocupadas: ${widget.parkingDailyLog.occupiedSpots?.length ?? 0}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 4),
                      children: totalParkingSpots.map((spot) {
                        final _isOccupied = _occupiedSpots.contains(spot);
                        return _spotChip(
                            onTap: () async {
                              if (_isOccupied) {
                                await _showCreateExitModal(
                                    occupiedSpots: _occupiedSpots, spot: spot);
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
            )),
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
                        await _showCreateExitModal(
                            occupiedSpots: _occupiedSpots);
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

  Future _showCreateExitModal(
          {String? spot, required List<String> occupiedSpots}) async =>
      await _showModalBottomSheet(CreateExitModal(
        selectedSpot: spot,
        presenter: widget.presenter,
        occupiedSpots: occupiedSpots,
        onSuccess: () {
          Navigator.pop(context);
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
          Navigator.pop(context);
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
}
