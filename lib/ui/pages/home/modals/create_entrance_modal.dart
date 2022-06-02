import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/components/custom_text_form_field.dart';
import 'package:parking_lot_app/ui/pages/home/components/confirm_button.dart';
import 'package:parking_lot_app/ui/pages/home/components/spot_dropdown_button.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

class CreateEntranceModal extends StatefulWidget {
  final HomePresenter presenter;
  final String? selectedSpot;
  final List<String> availableSpots;
  const CreateEntranceModal(
      {this.selectedSpot,
      required this.presenter,
      required this.availableSpots,
      Key? key})
      : super(key: key);

  @override
  State<CreateEntranceModal> createState() => _CreateEntranceModalState();
}

class _CreateEntranceModalState extends State<CreateEntranceModal> {
  late String _licensePlate = '';
  late String? _selectedSpot = widget.selectedSpot;

  @override
  Widget build(BuildContext context) {
    bool _enableButton =
        _licensePlate.isNotEmpty && (_selectedSpot?.isNotEmpty ?? false);
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
              'Entrada',
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
        CustomTextFormField(
            onChanged: (text) => setState(() {
                  _licensePlate = text;
                }),
            title: 'Placa'),
        SizedBox(height: 30),
        SpotDropdownButton(
          spots: widget.availableSpots,
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
            onTap: () async => await widget.presenter.createEntrance(
                  license: _licensePlate,
                  spot: _selectedSpot!,
                  entranceTimestamp: DateTime.now().millisecondsSinceEpoch,
                )),
        Expanded(child: Container()),
      ]),
    );
  }
}
