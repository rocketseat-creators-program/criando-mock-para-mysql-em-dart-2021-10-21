import 'dart:async';
import 'dart:convert';
import 'package:backend_sign_in/application/exceptions/user_not_found_exception.dart';
import 'package:backend_sign_in/application/helpers/jwt_helper.dart';
import 'package:backend_sign_in/modules/sign_in/dtos/sign_in_request.dart';
import 'package:backend_sign_in/repositories/users/user_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'sign_in_controller.g.dart';

class SignInController {
  final _repository = UserRepository();

  @Route.post('/')
  Future<Response> login(Request request) async {
    try {
      print('Executando Login');
      final body = await request.readAsString();
      final signInRq = SignInRequest.fromJson(body);

      final userResult = await _repository.login(signInRq);
      print('Finalizando Login');
      return Response.ok(
          jsonEncode({
            'token_type': 'Bearer',
            'access_token': JwtHelper.generateJWT(userResult.id),
          }),
          headers: {'content-type': 'application/json'});
    } on UserNotFoundException {
      return Response.forbidden(
          jsonEncode({'message': 'Usuário ou senha inválidos'}),
          headers: {'content-type': 'application/json'});
    } catch (e) {
      print(e);
      return Response.internalServerError();
    }
  }

  Router get router => _$SignInControllerRouter(this);
}
