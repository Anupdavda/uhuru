import 'package:flutter/material.dart';

class AmenitieFilterChips extends StatefulWidget {
  @override
  _AmenitieFilterChipsState createState() => _AmenitieFilterChipsState();
}

class _AmenitieFilterChipsState extends State<AmenitieFilterChips> {
  Widget _filterChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            child: Wrap(
          spacing: 5.0,
          runSpacing: 3.0,
          children: <Widget>[
            FilterChipWidget(chipName: 'Air condition'),
            FilterChipWidget(chipName: 'Ceiling Fan'),
            FilterChipWidget(chipName: 'Ceramic Tiles'),
            FilterChipWidget(chipName: 'Carpet'),
            FilterChipWidget(chipName: 'Furnished'),
            FilterChipWidget(chipName: 'Closet'),
            FilterChipWidget(chipName: 'Elevator'),
            FilterChipWidget(chipName: 'Laundry'),
            FilterChipWidget(chipName: 'Security'),
            FilterChipWidget(chipName: 'Parking'),
            FilterChipWidget(chipName: 'Swimming Pool'),
            FilterChipWidget(chipName: 'Hardwood Floor'),
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
        borderRadius: BorderRadius.circular(50.0),
      ),
      side: BorderSide(
        color: Colors.grey,
        width: _isSelected ? 0 : 1,
      ),
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
