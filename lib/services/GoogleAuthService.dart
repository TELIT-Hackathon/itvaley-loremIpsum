import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService{

  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();

  static Future<bool> isLoggedIn()  => _googleSignIn.isSignedIn();
}