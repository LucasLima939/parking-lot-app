import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/pages/home/components/confirm_button.dart';
import 'package:parking_lot_app/ui/pages/home/components/spot_dropdown_button.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

class CreateExitModal extends StatefulWidget {
  final String? selectedSpot;
  final HomePresenter presenter;
  final List<String> occupiedSpots;
  final VoidCallback onSuccess;
  const CreateExitModal(
      {this.selectedSpot,
      required this.presenter,
      required this.occupiedSpots,
      required this.onSuccess,
      Key? key})
      : super(key: key);

  @override
  State<CreateExitModal> createState() => _CreateExitModalState();
}

class _CreateExitModalState extends State<CreateExitModal> {
  late String? _selectedSpot = widget.selectedSpot;

  @override
  Widget build(BuildContext context) {
    bool _enableButton = _selectedSpot?.isNotEmpty ?? false;

    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(children: [
        Stack(
          children: [
            Center(
                child: Text(
              'Saída',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: .9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.close)),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        SpotDropdownButton(
          spots: widget.occupiedSpots,
          selectedSpot: _selectedSpot,
          onChanged: (spot) => setState(() {
            if (spot != null) {
              _selectedSpot = spot;
            }
          }),
        ),
        Expanded(child: Container()),
        ConfirmButton(
            isEnabled: _enableButton,
            onTap: () async => await widget.presenter.createExit(
                spot: _selectedSpot!,
                exitTimestamp: DateTime.now().millisecondsSinceEpoch,
                onSuccess: () {
                  Navigator.pop(context);
                  widget.onSuccess();
                })),
        Expanded(child: Container()),
      ]),
    );
  }
}
