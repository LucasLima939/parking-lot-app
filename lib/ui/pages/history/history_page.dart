import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';
import 'package:parking_lot_app/ui/mixins/loading_manager.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

class HistoryPage extends StatefulWidget {
  final HistoryPresenter presenter;
  const HistoryPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with LoadingManager {
  late String selectedDate;
  @override
  void initState() {
    selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    handleLoading(context, widget.presenter.isLoadingStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Selecione a data:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        final _selectedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              DateFormat('dd/MM/yyyy').parse(selectedDate),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2023),
                        );
                        if (_selectedDate != null) {
                          setState(() {
                            selectedDate =
                                DateFormat('dd/MM/yyyy').format(_selectedDate);
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(child: Text(selectedDate)),
                      ),
                    )
                  ]),
            ),
            Divider(),
            FutureBuilder<IParkingDailyLog?>(
              future: widget.presenter
                  .fetchDailyParkingLot(formattedDate: selectedDate),
              builder: (context, snapshot) {
                var parkingDailyLogModel = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (parkingDailyLogModel == null) {
                  // TODO: ERROR MESSAGE
                  return Center(
                    child: Text('Dados não disponíveis'),
                  );
                } else {
                  List<IVehicleLog> dailyVehicleRegisterHistory =
                      <IVehicleLog>[];
                  if (parkingDailyLogModel.occupiedSpots != null) {
                    dailyVehicleRegisterHistory
                        .addAll(parkingDailyLogModel.occupiedSpots!);
                  }
                  if (parkingDailyLogModel.dailyHistory != null) {
                    dailyVehicleRegisterHistory
                        .addAll(parkingDailyLogModel.dailyHistory!);
                  }

                  if (dailyVehicleRegisterHistory.isEmpty) {
                    // TODO: NO REGISTER MESSAGE
                    return Center(
                      child: Text('Sem registros na data'),
                    );
                  } else {
                    dailyVehicleRegisterHistory.sort(
                        (a, b) => b.entranceTime.compareTo(a.entranceTime));
                    return Expanded(
                      child: ListView(
                        children: dailyVehicleRegisterHistory
                            .map((vehicle) => _vehicleTile(vehicle))
                            .toList(),
                      ),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _vehicleTile(IVehicleLog vehicle) {
    final _timeFormat = DateFormat('HH:mm');
    final _entranceTime = _timeFormat
        .format(DateTime.fromMillisecondsSinceEpoch(vehicle.entranceTime));
    final _exitTime = vehicle.exitTime == null
        ? '-'
        : _timeFormat
            .format(DateTime.fromMillisecondsSinceEpoch(vehicle.exitTime!));

    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: .5))),
      child: ListTile(
          title: Text(vehicle.licensePlate),
          trailing: SizedBox(
            height: 40,
            //width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Entrada: $_entranceTime'),
                SizedBox(height: 5),
                Text('Saída: $_exitTime'),
              ],
            ),
          )),
    );
  }
}
