import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  void signInWithEmailAndPassword(String email, String password);
  void createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class MyAuth extends BaseAuth{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void createUserWithEmailAndPassword(String email, String password) async {
    // TODO: implement CreateUserWithEmailAndPassword
    try{
      FirebaseUser firebaseUser = await firebaseAuth.
      createUserWithEmailAndPassword(email: email, password: password);
      print(firebaseUser.uid);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Future<String> currentUser() async {
    // TODO: implement currentUser
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    return firebaseUser.uid;
  }

  @override
  void signInWithEmailAndPassword(String email, String password) async {
    // TODO: implement signInWithEmailAndPassword
    try{
      FirebaseUser firebaseUser = await firebaseAuth.
      signInWithEmailAndPassword(email: email, password: password);
      print(firebaseUser.uid);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement singOut
    return firebaseAuth.signOut();
  }

}