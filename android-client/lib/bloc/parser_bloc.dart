import 'package:bloc/bloc.dart';
import '../models/parser_source.dart';
import '../services/Parsers/parser_store.dart';

abstract class ParserEvent {}
class LoadParsers extends ParserEvent {}
class AddParser extends ParserEvent {
  final String name;
  final String regex;
  AddParser(this.name, this.regex);
}

abstract class ParserState {}
class ParserInitial extends ParserState {}
class ParserLoaded extends ParserState {
  final List<ParserSource> parsers;
  ParserLoaded(this.parsers);
}

class ParserBloc extends Bloc<ParserEvent, ParserState> {
  final ParserStore store;
  ParserBloc(this.store) : super(ParserInitial()) {
    on<LoadParsers>((event, emit) async {
      final parsers = await store.all();
      emit(ParserLoaded(parsers));
    });
    on<AddParser>((event, emit) async {
      await store.insert(ParserSource(name: event.name, regex: event.regex));
      final parsers = await store.all();
      emit(ParserLoaded(parsers));
    });
  }
}
