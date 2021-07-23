import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDay = false;
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      http.Response response =
          await http.get('http://worldtimeapi.org/api/timezone/$url');
      Map data = convert.jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(0, 3);
      String offsetMinute = data['utc_offset'].substring(4, 6);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));

      isDay = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Error loading time $e');
      time = 'Could not get time data';
    }
  }
}
