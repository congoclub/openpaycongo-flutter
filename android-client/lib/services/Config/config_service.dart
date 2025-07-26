import 'package:shared_preferences/shared_preferences.dart';
import '../../models/server_config.dart';

class ConfigService {
  static const _domainKey = 'domain';
  static const _apiKeyKey = 'apiKey';
  static const _hmacKey = 'hmacKey';

  Future<void> save(ServerConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_domainKey, config.domain);
    await prefs.setString(_apiKeyKey, config.apiKey);
    await prefs.setString(_hmacKey, config.hmacKey);
  }

  Future<ServerConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    return ServerConfig(
      domain: prefs.getString(_domainKey) ?? '',
      apiKey: prefs.getString(_apiKeyKey) ?? '',
      hmacKey: prefs.getString(_hmacKey) ?? '',
    );
  }
}
