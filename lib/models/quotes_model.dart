class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }
}
