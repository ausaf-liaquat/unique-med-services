import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/theme/color.dart';

class MapView extends StatelessWidget {
  var lat;
  var long;
  MapView({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mkid = MarkerId('aa');
    return Container(
      color: AppColorScheme().black6,
      height: 340,
      child: GoogleMap(
          mapType: MapType.hybrid,
          markers: {Marker(position: LatLng(lat, long), markerId: mkid )},
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, long),
            zoom: 14.4746,
          ),
    ),
    );
  }
}
