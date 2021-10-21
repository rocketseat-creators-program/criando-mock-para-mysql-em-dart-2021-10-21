import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:backend_sign_in/application/middleware/security/security_middleware.dart';
import 'package:backend_sign_in/modules/products/products_controller.dart';
import 'package:backend_sign_in/modules/sign_in/sign_in_controller.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = '0.0.0.0';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  final router = Router();
  router.mount('/sign-in/', SignInController().router);
  router.mount('/products/', ProductsController().router);

  var handler = const shelf.Pipeline()
      .addMiddleware(SecurityMiddleware().handler)
      // .addMiddleware((innerHandler){
      //   print('Criando Primeiro middleware');
      //   return (shelf.Request request) async {
      //     print('Executando meu middleware');
      //     final response = await innerHandler(request);
      //     print('finalizando meu middleware');
      //     return response;
      //   };
      // })
      // .addMiddleware(shelf.logRequests())
      .addHandler(router);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
