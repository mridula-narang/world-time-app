import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  late String time; // time in that location
  String flag; // URL to an asset flag icon
  String url; // location URL for API endpoint
  late bool isDaytime; //true or false if day time or not

  WorldTime({required this.location, required this.flag, required this.url}) {
    getTime();
  }

  // Asynchronous code example
  Future<void> getTime() async {
    try {
      // Make the request
      http.Response response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 6);

      List<String> offsetParts = offset.split(':');
      int hour = int.parse(offsetParts[0]);
      int min = int.parse(offsetParts[1]);

      // Create a DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: hour, minutes: min));

      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    } catch (error) {
      // Handle any error that occurs during the API request
      print('Error: $error');
      time = 'Failed to get time';
    }
  }
}




