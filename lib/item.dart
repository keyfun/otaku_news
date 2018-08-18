class Item {
  final String title;
  final String description;
  final String link;
  final String date;
  final String enclosureUrl = null; // optional for BT

  Item(this.title, this.description, this.link, this.date);
}