

import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_camp/screens/loading/mainScreen/loading.dart';
import 'package:my_camp/services/login.dart';

class VerifyOtp extends StatefulWidget {
  final email ;

  const VerifyOtp({Key key, this.email}) : super(key: key);
  @override
  _VerifyOtp createState() => _VerifyOtp();
}

class _VerifyOtp extends State<VerifyOtp> {
  final _formKey = GlobalKey<FormState>();

  var  otpController = new TextEditingController();
  var loading = false ;
  void verifyOtp() {
    EmailAuth.sessionName = "test session" ;
    var res =  EmailAuth.validate(receiverMail: widget.email, userOTP: otpController.text);
    if(res){
        print("redirect to change password");
    }else
    {
        print("invalid otp");
    }
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
          return 'Please enter your code';
        }

        return null;
      },

      controller: otpController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Verification Code',
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
            verifyOtp();
          }
        },
        padding: EdgeInsets.all(12),

        color: Color.fromRGBO(36, 34, 47, 1),
        child: Text('Verify', style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1))),
      ),
    );



    return loading? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
        title: Center(child: Text("Code Verification",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),),),
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




