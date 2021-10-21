import 'dart:async';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'products_controller.g.dart';

class ProductsController {

   @Route.get('/')
   Future<Response> find(Request request) async {
      return Response.ok(jsonEncode({
        'nome': 'Produto X',
        'valor': 250.00,
        'UserId': request.headers['user']
      }), headers: {'content-type': 'application/json'});
   }

   Router get router => _$ProductsControllerRouter(this);
}