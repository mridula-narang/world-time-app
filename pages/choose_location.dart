import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations =[
    WorldTime(url: 'Europe/London', location: 'London', flag: 'london.jpg'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'chicago.jpg'),
    WorldTime(url: 'America/Los_Angeles', location: 'Los Angeles', flag: 'la.jpg'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'bangkok.jpg'),
    WorldTime(url: 'Asia/Kolkata', location: 'India', flag: 'india.jpg'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'seoul.jpg'),
    WorldTime(url: 'Europe/Madrid', location: 'Madrid', flag: 'madrid.jpg'),
    WorldTime(url: 'Europe/Prague', location: 'Prague', flag: 'prague.jpg'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigate to home screen
    Navigator.pop(context,{
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDaytime,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Choose a location'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
