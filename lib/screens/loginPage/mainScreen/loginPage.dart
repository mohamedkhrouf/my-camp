import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:my_camp/screens/homePage/mainScreen/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 50);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlutterLogin(
      title: 'MY CAMP',
      logo: 'assets/logo1.png',
      onLogin: (_) => Future(null),
      onSignup: (_) => Future(null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          callback: () async {
            print('start google sign in');
            await Future.delayed(loginTime);
            print('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          callback: () async {
            print('start facebook sign in');
            await Future.delayed(loginTime);
            print('stop facebook sign in');
            return null;
          },
        ),
      ],
      onRecoverPassword: (_) => Future(null),
      theme: LoginTheme(
        primaryColor: Color.fromRGBO(36, 34, 47, 1),
        accentColor: Color.fromRGBO(36, 34, 47, 1),
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(170, 215, 62, 1),
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.black,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color.fromRGBO(170, 215, 62, 1),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 0),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          focusColor: Color.fromRGBO(170, 215, 62, 1),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(170, 215, 62, 1), width: 4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(170, 215, 62, 1), width: 5),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),

          elevation: 3.0,
          highlightElevation: 3.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
        logoWidth: 0.75,
      ),
    ));
  }
}
