
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  
  static final String _jwtSecret = 'RbYKGcVrOG4lQJek9Dy7zWWwIvJ';

  JwtHelper._();

  static String generateJWT(int userId){
    final claim = JwtClaim(
      issuer: 'expert_club',
      subject: userId.toString(),
      expiry: DateTime.now().add(Duration(days: 1)),
      notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      maxAge: const Duration(days: 1),
    );
    return issueJwtHS256(claim, _jwtSecret);
  }

  static JwtClaim getClaims(String authToken) {
    return verifyJwtHS256Signature(authToken, _jwtSecret);
  }

}