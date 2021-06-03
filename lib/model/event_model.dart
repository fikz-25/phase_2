class Event {
  int? id;
  String? name;
  String? date;
  String? image;
  double? latitude;
  double? longitude;

  Event(
      {this.id,
      this.name,
      this.date,
      this.image,
      this.latitude,
      this.longitude});

  factory Event.fromJSON(Map<String, dynamic> jsonMap) {
    return Event(
        id: jsonMap['id'],
        name: jsonMap['name'],
        date: jsonMap['date'],
        image: jsonMap['image'],
        latitude: jsonMap['latitude'],
        longitude: jsonMap['longitude']);
  }
}
