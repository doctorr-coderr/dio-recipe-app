class Recipe {
 final int id;
 final String name;
 final String image;
 final String cuisine;
 final String difficulty;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.difficulty,
  });


  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      cuisine: json['cuisine'],
      difficulty: json['difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'cuisine': cuisine,
      'difficulty': difficulty,
    };
  }
}