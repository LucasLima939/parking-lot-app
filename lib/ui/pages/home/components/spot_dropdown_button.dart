import 'package:flutter/material.dart';

class SpotDropdownButton extends StatelessWidget {
  final void Function(String?) onChanged;
  final List<String> spots;
  final String? selectedSpot;
  SpotDropdownButton(
      {Key? key,
      required this.onChanged,
      required this.spots,
      required this.selectedSpot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: .5),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Stack(children: [
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF000000),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButton<String>(
            value: selectedSpot,
            isExpanded: true,
            elevation: 16,
            icon: Container(),
            underline: Container(),
            style: TextStyle(color: Theme.of(context).primaryColor),
            hint: Text('Vaga'),
            onChanged: (value) => onChanged(value),
            menuMaxHeight: 300,
            items: _spotsList(spots),
          ),
        ),
      ]),
    );
  }

  List<DropdownMenuItem<String>> _spotsList(spots) {
    final _sortedSpots = List<String>.from(spots)..sort();
    return _sortedSpots.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
