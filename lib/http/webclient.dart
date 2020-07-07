import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';


final String baseUrl = 'http://192.168.1.108:3000/transacao';
final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
