import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static void ShowMapsFromOneLocationToLocation(
      FromLat, FromLan, ToLat, ToLng) async {
    String mapOption = [
      "saddr=$FromLat,$FromLan",
      'daddr=$ToLat,$ToLng',
      'dir_action=navigate'
    ].join('&');
    final mapUrl = 'https://www.google.com/maps?$mapOption';
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Can\'t open url $mapUrl';
    }
  }
}
