import 'package:flutter/material.dart';

class LocatioInput extends StatefulWidget {
  LocatioInput({Key key}) : super(key: key);

  @override
  _LocatioInputState createState() => _LocatioInputState();
}

class _LocatioInputState extends State<LocatioInput> {
  String _previewImageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 180,
          
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
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select on map',
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
