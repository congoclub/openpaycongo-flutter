class SmsPattern {
  final String source;
  final String regex;
  const SmsPattern({required this.source, required this.regex});

  factory SmsPattern.fromMap(Map<String, dynamic> map) {
    return SmsPattern(source: map['source'] ?? '', regex: map['regex'] ?? '');
  }

  Map<String, dynamic> toMap() => {'source': source, 'regex': regex};
}
