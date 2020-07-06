class Category {
  String id;
  String name;

  Category(this.id, this.name);

  static List<Category> getData() {
    return <Category>[
      Category('Category1', 'Category1'),
      Category('Category2', 'Category2'),
      Category('Category3', 'Category3'),
      Category('Category4', 'Category4'),
      Category('Category5', 'Category5'),
    ];
  }
}