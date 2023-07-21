class Tag {
  int id;
  String name;
  String imageURL;

  Tag({this.id, this.name, this.imageURL});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      imageURL: json['route'],
    );
  }
}

class TagsList {
  final List<Tag> tags;

  TagsList({
    this.tags,
  });

  factory TagsList.fromJson(List<dynamic> json) {

    List<Tag> tags = new List<Tag>();
    tags = json.map((i) => Tag.fromJson(i)).toList();

    return new TagsList(
      tags: tags,
    );
  }
}