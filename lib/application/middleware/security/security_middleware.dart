import 'dart:convert';

import 'package:backend_sign_in/application/helpers/jwt_helper.dart';
import 'package:backend_sign_in/application/middleware/middlewares.dart';
import 'package:backend_sign_in/application/middleware/security/security_skip_url.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';

class SecurityMiddleware extends Middlewares {
  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/sign-in/', method: 'POST'),
  ];

  @override
  Future<Response> execute(Request request) async {
    
    try {
      final urlRequest = SecuritySkipUrl(
        url: '/${request.url.path}',
        method: request.method,
      );
      
      // Urls que não deve ser autenticadas
      if (skipUrl.contains(urlRequest)) {
        return innerHandler(request);
      }
      
      final authHeader = request.headers['Authorization'];
      
      if(authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }
      final authHeaderContent = authHeader.split(' ');

      if(authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authToken);

      claims.validate();

      final claimsMap = claims.toJson();

      final userId = claimsMap['sub'];

      if(userId == null) {
        throw JwtException.invalidToken;
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authToken
      };
      
      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch(e) {
      print(e);
      return Response.forbidden(jsonEncode({}));
    }
  }
}
