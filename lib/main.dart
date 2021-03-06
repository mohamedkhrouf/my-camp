import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/services/login.dart';

import 'screens/index/mainScreen/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _fb = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _fb,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('You have an error ! ${snapshot.error.toString()}');
                return Text('Something went wrong!');
              } else if (snapshot.hasData) {
                return FutureBuilder(

                    builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                      if (FirebaseAuth.instance.currentUser == null){
                        User user = snapshot.data; // this is your user instance
                        /// is because there is user already logged
                        return LogIn();
                      }
                      /// other way there is no user logged.
                      return Index();
                    }
                ) ;
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
