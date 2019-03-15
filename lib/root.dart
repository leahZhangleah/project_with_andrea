
import 'package:flutter/material.dart';
import 'auth.dart';
import 'home.dart';
import 'loginPage.dart';
enum SignInStatus{
  signedIn, notSignedIn
}
class RootPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _rootPageState();
  }

}

class _rootPageState extends State<RootPage> {
  SignInStatus signInStatus = SignInStatus.notSignedIn;
  MyAuth myAuth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myAuth = new MyAuth();
    myAuth.currentUser().then(
        (String value){
          setState(() {
            signInStatus = value !=null ? SignInStatus.signedIn : SignInStatus.notSignedIn;
          });
          },
    );
  }

  void onSingedIn(){
    setState(() {
      signInStatus = SignInStatus.signedIn;
    });
  }

  void signOut(){
    setState(() {
      signInStatus = SignInStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(signInStatus == SignInStatus.signedIn){
      return new HomePage(myAuth,signOut);
    }
    return new LoginPage(
        baseAuth: myAuth,
        onSignedIn: onSingedIn,);
  }
}