class MyToDoModel {
  int? id;
  late String title;
  late String description;
  late String status;
  late String date;
  MyToDoModel.withId(
      this.id, this.title, this.description, this.status, this.date);
  MyToDoModel(this.title, this.description, this.status, this.date);
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    if (id != null) {
      map["id"] = id;
    }

    map["title"] = title;
    map["description"] = description;
    map["status"] = status;
    map["date"] = date;

    return map;
  }

  // map to model

  MyToDoModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    status = map["status"];
    date = map["date"];
  }
}
