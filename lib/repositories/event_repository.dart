import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phase_1/model/event_model.dart';

class EventRepository {
  Future<List<Event>> getEvents() async {
    Uri url = Uri.parse("https://my-json-server.typicode.com/Fikz-25/event/db");
    var response = await http.get(url);

    var jsonObject = json.decode(response.body);
    List<dynamic> listEvent = (jsonObject as Map<String, dynamic>)["event"];

    print(listEvent);
    List<Event> events = [];
    for (int i = 0; i < listEvent.length; i++) {
      events.add(Event.fromJSON(listEvent[i]));
    }
    return events;
  }
}
