import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
class FirebaseServices{
  
  final _auth = FirebaseAuth.instance;
  final _googleSiginIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  

  signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSiginIn.signIn();
      if(googleSignInAccount!=null){
        final GoogleSignInAuthentication googleSignInAuthentication = 
              await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken
              );
        await _auth.signInWithCredential(authCredential);
      }
    }  catch(e){
      print(e);
      throw e;
    }
  }

  signOutWithGoogle() async{
    await _auth.signOut();
    await _googleSiginIn.signOut();

  }

  createUserWithEmailAndPassword({required String email, required String password}) {}
}

Future<bool> signInWithEmailAndPassword(
      {required email, required  password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
      );
      return true;
    }catch(e){
      return false;
    }
    

}

Future<bool> createUserWithEmailAndPassword(
      {required email, required  password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
      );
      return true;
    }catch(e){
      print(e);
      return false;
    }
    

}


