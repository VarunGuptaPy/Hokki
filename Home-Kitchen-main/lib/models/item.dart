class Item {
  Map<String, dynamic> Monday;
  Map<String, dynamic> Tuesday;
  Map<String, dynamic> Wednesday;
  Map<String, dynamic> Thursday;
  Map<String, dynamic> Friday;
  Map<String, dynamic> Saturday;
  Map<String, dynamic> Sunday;
  String price;
  List<dynamic> addons;
  Item({
    required this.Wednesday,
    required this.Monday,
    required this.Thursday,
    required this.Tuesday,
    required this.Friday,
    required this.Sunday,
    required this.Saturday,
    required this.addons,
    required this.price,
  });
  Map<String, dynamic> toMap() => {
        'Monday': Monday,
        'Tuesday': Tuesday,
        'Wednesday': Wednesday,
        'Thursday': Thursday,
        'Friday': Friday,
        'Saturday': Saturday,
        'Sunday': Sunday,
        'addons': addons,
        'price': price,
      };
  static Item fromMap(Map<String, dynamic> data) {
    return Item(
        price: data['price'],
        addons: data['addons'],
        Monday: data['Monday'],
        Tuesday: data['Tuesday'],
        Wednesday: data['Wednesday'],
        Thursday: data['Thursday'],
        Friday: data['Friday'],
        Sunday: data['Sunday'],
        Saturday: data['Saturday']);
  }
}
