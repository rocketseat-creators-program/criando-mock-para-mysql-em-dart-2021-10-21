import 'package:shelf/shelf.dart';

abstract class Middlewares {

  late Handler innerHandler;

  Handler handler(Handler innerHandler) {
    print('Iniciando Handler');
    this.innerHandler = innerHandler;
    return execute;
  }

  Future<Response> execute(Request request);

}