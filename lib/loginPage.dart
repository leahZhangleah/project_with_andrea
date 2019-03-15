import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({@required this.baseAuth,@required this.onSignedIn});
  final BaseAuth baseAuth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginPageState();
  }
}

enum FormType{
  login,create_account
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  FormType formType = FormType.login;

  bool validateAndSave(){
    FormState formState = formKey.currentState;
    if(formState.validate()){
      formState.save();
      print('typed in info: email $_email,password $_password');
      return true;
    }
    return false;
  }

  void validateAndSubmitWithFirebase(BuildContext context) async {
    if(validateAndSave()){
      if(formType == FormType.login){
        widget.baseAuth.signInWithEmailAndPassword(_email, _password);
      }
      widget.baseAuth.createUserWithEmailAndPassword(_email, _password);
      widget.onSignedIn();
    }
  }


  List<Widget> buildInputWidgets(){
    return [
      new TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Please type in your email address',
          labelText: 'Email',
        ),
        onSaved: (String value) {
          //This optional block of code can be used to run
          //code when the user saves the form.
          _email = value;
        },
        validator: (String value) {
          //validate the string typed by user
          return value.isEmpty ? 'Email can not be empty' : null;
        },
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Please type in your password',
          labelText: 'Password',
        ),
        obscureText: true,
        onSaved: (String value) {
          //This optional block of code can be used to run
          //code when the user saves the form.
          _password = value;
        },
        validator: (String value) {
          //validate the string typed by user
          return value.isEmpty ? 'Password can not be empty' : null;
        },
      ),
    ];
  }

  List<Widget> buildSubmitWidgets(BuildContext context){
    if(formType == FormType.login){
      return [
        new RaisedButton(
          onPressed: (){
            validateAndSubmitWithFirebase(context);
          },
          child: new Text('Login'),
        ),
        new FlatButton(
            onPressed: (){
              moveToRegister();
            }, //todo reset state
            child: new Text('Create a new account')),
      ];
    }
    return [
      new RaisedButton(
        onPressed: (){
          validateAndSubmitWithFirebase(context);
        },
        child: new Text('Create an account'),
      ),
      new FlatButton(
          onPressed: (){
            moveToLogin();
          }, //todo reset state
          child: new Text('Already have an account? Login!')),
    ];
  }

 void moveToRegister(){
    setState(() {
      formType=FormType.create_account;
      formKey.currentState.reset();
    });
 }

 void moveToLogin(){
    setState(() {
      formType=FormType.login;
      formKey.currentState.reset();
    });
 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Sign in'),
      ),
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputWidgets()+buildSubmitWidgets(context),
          ),
        ),
      )
    );


  }
}
