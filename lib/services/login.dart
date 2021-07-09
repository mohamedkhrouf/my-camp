

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/index/mainScreen/index.dart';
import 'package:my_camp/screens/loading/mainScreen/loading.dart';
import 'package:my_camp/services/forgotPassword.dart';
import 'package:my_camp/services/singup.dart';
import 'authentication.dart';
class LogIn extends StatefulWidget {

  @override
  _LogIn createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  var  emailController = new TextEditingController();
  var passwordController = new TextEditingController();
var loading = false ;
var error = "" ;

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 130,
        child: Image.asset('assets/logo1.png'),
      ),
    );

    final email = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
          return 'Emal invalid';
        }
        return null;
      },

      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      validator: (value) {
        if (value.length< 8) {
          return 'Password should be longer than 8 caracters';
        }
        return null ;
      },
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          fillColor: Color.fromRGBO(170, 215, 62, 1)
      ),
    );

    final signUpLabel = TextButton(
      child: Text(
        'SignUp?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()) {
            setState(() {
              loading= true ;
            });
            AuthenticationHelper()
                .signIn(email: emailController.text, password: passwordController.text)
                .then((result) {
              if (result == null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Index()));
              } else {
                setState(() {
                  error= result ;
                  loading = false ;
                });
                print(result);
              }
            });
          }
        },
        padding: EdgeInsets.all(12),

        color: Color.fromRGBO(36, 34, 47, 1),
        child: Text('Login', style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1),fontSize: 20)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
    );

    return loading? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
        title: Center(child:Text("Login",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),),),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            Form(
              key: _formKey,child: Column(
              children: [
                email,
                SizedBox(height: 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  password,
                  forgotLabel,
                ],
                ),

                SizedBox(height: 12.0),



              ],
            ),),

            loginButton,
            signUpLabel,

            (error == "" || error== null )? Container() : Text(error, style: TextStyle(color: Colors.red,fontSize: 30),),
          ],
        ),
      ),
    );
  }
/*return Scaffold(
      appBar: AppBar(
        title: Text("Auth"),

      ),
      body:GestureDetector(
        child: Container(
          child: ,
        ),
        onTap: (){
          AuthenticationHelper()
              .signUp(email: "mekkiahmed123@gmail.com", password: "password.text")
              .then((result) {
            if (result == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Index()));
            } else {
              print("hello");

            }
          });
        },
      ) ,
    );*/
}


