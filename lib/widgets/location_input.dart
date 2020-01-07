import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/screens/map_screen.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput({Key key, this.onSelectPlace}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void showPreview(double lat, double lng) {
    final _staticPreviewURl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = _staticPreviewURl;
    });
  }

  void _getCurrentUserLocation() async {
    try {
       final locData = await Location().getLocation();
        showPreview(locData.latitude, locData.longitude);
    widget.onSelectPlace(locData.latitude, locData.longitude);
   
    } catch (e) {
      print(e);
      return;
    }

  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
     showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 180,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select on map',
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
