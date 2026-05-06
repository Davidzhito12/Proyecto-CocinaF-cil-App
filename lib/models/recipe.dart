class Recipe {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String category;
  final List<String> ingredients;
  final List<String> steps;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.category,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });
}
