import 'package:flutter/material.dart';

class RoomBathroomChips extends StatefulWidget {
  @override
  _RoomBathroomChipsState createState() => _RoomBathroomChipsState();
}

class _RoomBathroomChipsState extends State<RoomBathroomChips> {
  Widget _filterChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            child: Wrap(
          spacing: 25.0,
          runSpacing: 3.0,
          children: <Widget>[
            FilterChipWidget(chipName: 'Any'),
            FilterChipWidget(chipName: '1'),
            FilterChipWidget(chipName: '2'),
            FilterChipWidget(chipName: '3'),
            FilterChipWidget(chipName: '4'),
            FilterChipWidget(chipName: '5+'),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _filterChips();
  }
}

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  FilterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.black,
        fontSize: 18.0,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(color: Colors.grey,width: _isSelected ? 0 : 1,),
      backgroundColor: Colors.transparent,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.blue[900],
    );
  }
}
