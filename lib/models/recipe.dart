class Recipe {
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String category;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.category,
    required this.ingredients,
    required this.steps,
  });
}
