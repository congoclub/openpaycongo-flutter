class ParserSource {
  final int? id;
  final String name;
  final String regex;

  ParserSource({this.id, required this.name, required this.regex});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'regex': regex,
      };

  factory ParserSource.fromMap(Map<String, dynamic> map) => ParserSource(
        id: map['id'] as int?,
        name: map['name'] ?? '',
        regex: map['regex'] ?? '',
      );
}
