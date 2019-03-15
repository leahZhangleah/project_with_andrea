
import 'package:flutter/material.dart';
import 'auth.dart';
class HomePage extends StatefulWidget{
  MyAuth myAuth;
  VoidCallback signOut;
  HomePage(@required this.myAuth,@required this.signOut);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homePageState();
  }

}

enum MenuOption{
  signOut,random
}
class _homePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Welcome',style: new TextStyle(fontSize: 20.0,color: Colors.white),),
        actions: <Widget>[
          new PopupMenuButton(
              itemBuilder: (BuildContext context)=> <PopupMenuEntry<MenuOption>>[
                new PopupMenuItem(
                    child: new Text('Signout'),
                    value: MenuOption.signOut,
                ),
                new PopupMenuItem(
                    child: new Text('random'),
                    value: MenuOption.random,
                )
              ],
              onSelected:(MenuOption menuOption){
                if(menuOption== MenuOption.signOut){
                  widget.myAuth.signOut();
                  widget.signOut;
                }
              },
          )
        ],
      ),
      body: new Container(
        child: new Text('Welcome'),
      ),
    );
  }
}

