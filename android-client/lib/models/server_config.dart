class ServerConfig {
  final String domain;
  final String apiKey;
  final String hmacKey;

  ServerConfig({required this.domain, required this.apiKey, required this.hmacKey});

  Map<String, String> toMap() => {
        'domain': domain,
        'apiKey': apiKey,
        'hmacKey': hmacKey,
      };

  factory ServerConfig.fromMap(Map<String, dynamic> map) => ServerConfig(
        domain: map['domain'] ?? '',
        apiKey: map['apiKey'] ?? '',
        hmacKey: map['hmacKey'] ?? '',
      );
}
