//item
class Item {
  int? id;
  String name;

  Item({this.id, required this.name});

  // Convert Item to Map (for SQLite)
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Extract Item from Map (from SQLite)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
    );
  }
}