import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

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

  void validateAndSubmitWithFirebase() async {
    if(validateAndSave()){
      if(formType == FormType.login){
        try{
          FirebaseUser firebaseUser = await FirebaseAuth.instance.
          signInWithEmailAndPassword(email: _email, password: _password);
          print(firebaseUser.uid);
        }
        catch(e){
          print(e);
        }
      }
      try{
        FirebaseUser firebaseUser = await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: _email, password: _password);
        print(firebaseUser.uid);
      }
      catch (e){
        print(e);
      }
    }
  }

  void switchBtwLoginAndCreate(){
    if(formType == FormType.login){
      setState(() {
        formKey.currentState.reset();
        formType= FormType.create_account;
      });
    }
    setState(() {
      formKey.currentState.reset();
      formType= FormType.login;
    });
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

  List<Widget> buildSubmitWidgets(){
    if(formType == FormType.login){
      return [
        new RaisedButton(
          onPressed: (){
            validateAndSubmitWithFirebase();
          },
          child: new Text('Login'),
        ),
        new FlatButton(
            onPressed: (){
              switchBtwLoginAndCreate();
            }, //todo reset state
            child: new Text('Create a new account.')),
      ];
    }
    return [
      new RaisedButton(
        onPressed: (){
          validateAndSubmitWithFirebase();
        },
        child: new Text('Create a new account'),
      ),
      new FlatButton(
          onPressed: (){
            switchBtwLoginAndCreate();
          }, //todo reset state
          child: new Text('Already have an account? Login.')),
    ];

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildInputWidgets()+buildSubmitWidgets(),
        ),
      ),
    );


  }
}
