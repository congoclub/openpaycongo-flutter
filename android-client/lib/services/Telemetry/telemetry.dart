import 'package:opentelemetry_api/opentelemetry_api.dart';
import 'package:opentelemetry_sdk/opentelemetry_sdk.dart';

class Telemetry {
  Telemetry._();
  static final Telemetry instance = Telemetry._();

  late final Tracer tracer;

  Future<void> init() async {
    final exporter = ConsoleSpanExporter();
    final provider = TracerProvider(
      processors: [SimpleSpanProcessor(exporter)],
      resource: Resource([ResourceAttributes.serviceName: 'opencongopay']),
    );
    tracer = provider.getTracer('opencongopay');
    globalTracerProvider = provider;
  }
}
