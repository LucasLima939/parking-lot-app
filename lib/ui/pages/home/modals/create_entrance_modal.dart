import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/mixins/keyboard_manager.dart';
import 'package:parking_lot_app/ui/mixins/ui_error_mixin.dart';
import 'package:parking_lot_app/ui/pages/home/components/custom_text_form_field.dart';
import 'package:parking_lot_app/ui/pages/home/components/confirm_button.dart';
import 'package:parking_lot_app/ui/pages/home/components/spot_dropdown_button.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

class CreateEntranceModal extends StatefulWidget {
  final HomePresenter presenter;
  final String? selectedSpot;
  final List<String> availableSpots;
  final VoidCallback onSuccess;
  const CreateEntranceModal(
      {this.selectedSpot,
      required this.presenter,
      required this.availableSpots,
      required this.onSuccess,
      Key? key})
      : super(key: key);

  @override
  State<CreateEntranceModal> createState() => _CreateEntranceModalState();
}

class _CreateEntranceModalState extends State<CreateEntranceModal>
    with KeyboardManager, UiErrorMixin {
  late String _licensePlate = '';
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
    bool _enableButton =
        _licensePlate.isNotEmpty && (_selectedSpot?.isNotEmpty ?? false);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Container(
          height: MediaQuery.of(context).size.height * .4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            key: _modalScaffoldKey,
            resizeToAvoidBottomInset: false,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Column(children: [
                Stack(
                  children: [
                    Center(
                        child: Text(
                      'Entrada',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    onTap: () async {
                      hideKeyboard(context);
                      final _success = await widget.presenter.createEntrance(
                          license: _licensePlate,
                          spot: _selectedSpot!,
                          entranceTimestamp:
                              DateTime.now().millisecondsSinceEpoch);
                      if (_success) {
                        widget.onSuccess();
                      }
                    }),
                Expanded(child: Container()),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
