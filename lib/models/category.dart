class Category {
  String id;
  String name;

  Category(this.id, this.name);

  static List<Category> getData() {
    return <Category>[
      Category('Work', 'Work'),
      Category('Religion', 'Religion'),
      Category('Utility', 'Utility'),
      Category('School', 'School'),
      Category('Others', 'Others'),
    ];
  }
}