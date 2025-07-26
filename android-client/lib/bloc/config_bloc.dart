import 'package:bloc/bloc.dart';
import '../models/server_config.dart';
import '../services/Config/config_service.dart';

abstract class ConfigEvent {}
class LoadConfig extends ConfigEvent {}
class SaveConfig extends ConfigEvent {
  final ServerConfig config;
  SaveConfig(this.config);
}

abstract class ConfigState {}
class ConfigInitial extends ConfigState {}
class ConfigLoaded extends ConfigState {
  final ServerConfig config;
  ConfigLoaded(this.config);
}

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigService service;
  ConfigBloc(this.service) : super(ConfigInitial()) {
    on<LoadConfig>((event, emit) async {
      final c = await service.load();
      emit(ConfigLoaded(c));
    });
    on<SaveConfig>((event, emit) async {
      await service.save(event.config);
      emit(ConfigLoaded(event.config));
    });
  }
}
