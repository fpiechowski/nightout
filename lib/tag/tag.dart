class Tag {
  String name;

  Tag(this.name);

  @override
  bool operator ==(Object other) {
    return other is Tag ? name == other.name : false;
  }

  @override
  int get hashCode => name.hashCode;
}