import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/mixins/ui_error_mixin.dart';
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

class _CreateExitModalState extends State<CreateExitModal> with UiErrorMixin {
  late String? _selectedSpot = widget.selectedSpot;
  late GlobalKey<ScaffoldState> _modalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    handleError(_modalScaffoldKey.currentState?.context,
        widget.presenter.messageStream);
  }

  @override
  Widget build(BuildContext context) {
    bool _enableButton = _selectedSpot?.isNotEmpty ?? false;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _modalScaffoldKey,
          body: Padding(
            padding: EdgeInsets.all(15),
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
                  onTap: () async {
                    final _success = await widget.presenter.createExit(
                        spot: _selectedSpot!,
                        exitTimestamp: DateTime.now().millisecondsSinceEpoch);
                    if (_success) {
                      widget.onSuccess();
                    }
                  }),
              Expanded(child: Container()),
            ]),
          ),
        ),
      ),
    );
  }
}
