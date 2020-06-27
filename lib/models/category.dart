class Category {
  int id;
  String name;

  Category(this.id, this.name);

  static List<Category> getData() {
    return <Category>[
      Category(1, 'Category1'),
      Category(1, 'Category2'),
      Category(1, 'Category3'),
      Category(1, 'Category4'),
      Category(1, 'Category5'),
    ];
  }
}