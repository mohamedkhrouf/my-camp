

import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_camp/screens/loading/mainScreen/loading.dart';
import 'package:my_camp/services/verifyOTP.dart';
import 'login.dart';
class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var  emailController = new TextEditingController();
  var loading = false ;
  var error = "" ;
 sendOtp() async{
  EmailAuth.sessionName = "test session" ;
  var res = await EmailAuth.sendOtp(receiverMail: emailController.text);
  return res ;
}

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



    final logInLabel = TextButton(

      child: Text(
        'LogIn?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      },
    );

    final verifyButton = Padding(
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
              sendOtp().then((result){
                if(result){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => VerifyOtp(email: emailController.text,)));
                }else
                {
                  setState(() {
                    loading= false ;
                    error="Unknown Error" ;
                  });
                }
              }
              );

          }
          },
        padding: EdgeInsets.all(12),

        color: Color.fromRGBO(36, 34, 47, 1),
        child: Text('Send verification mail', style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1))),
      ),
    );



    return loading? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
        title: Center(child: Text("Forgot password",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),),),
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

                SizedBox(height: 24.0),

                verifyButton,
                logInLabel,
                (error == "" || error== null )? Container() : Text(error, style: TextStyle(color: Colors.red),),
              ],
            ),),


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




