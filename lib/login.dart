import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/mainpage.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Login extends StatefulWidget {
  static String tag = 'LOGIN';
  

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneno,smscode,verid;
  String hintTaxt = '*********';
  bool _Tap = true;

signIn()async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verid,
      smsCode: smscode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>mainn()));
    }).catchError((e)=>print(e));
      }
  Future<void> verifyNumber() async{
    
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verid = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
        this.verid=verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential){
      print('verified');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>mainn()));
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception){
      print('${exception.message}');
    };

     await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneno,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
     );

     
  }

  

  void _click(){
    setState(() {
     _Tap = !_Tap; 
    });

  }
  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextField(
      
      autofocus: false,
      keyboardType: TextInputType.number,
      
      decoration: InputDecoration(
        
        icon: Icon(Icons.phone,
        color: Colors.black,),
        labelText: 'Phone Number',
        //hintText: 'Enter Email',
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
            )
            ),
         
         
      ),
      onSubmitted: null,
      onChanged: (value){
        this.phoneno = '+91$value'; 
      },
      
    );

    
        final pass = TextField(
          autofocus: false,
          //style: Theme.of(context).textTheme.display1,
         
          decoration: InputDecoration(
            icon: Icon(Icons.vpn_key,color: Colors.black,),
            labelText: 'Enter OTP',
            hintText: hintTaxt,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
            ),
            suffixIcon: IconButton(
               //icon: Icon(Icons.visibility),
                onPressed: _click,
                icon: _Tap ? Icon(Icons.visibility) : Icon(Icons.visibility_off) , 
             ) ,  
          ),
          onSubmitted: null,
          onChanged: (value){
            this.smscode = value;
          },
          obscureText: hintTaxt == '*********' ? _Tap : false,
    );

     final loginbtn = Material(
       borderRadius: BorderRadius.circular(40.0),
       color: Colors.lightBlueAccent,
       shadowColor: Colors.lightGreenAccent.shade100,
      // elevation: 5.0,
       child: MaterialButton(
         
         child: Text('Login', style: TextStyle(color: Colors.white,fontSize: 28.0),), 
         onPressed: () {
           FirebaseAuth.instance.currentUser().then((user){
             if (user != null){
               Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>mainn()));
             } else {
               Navigator.of(context).pop();
               signIn();
             }
           });
         },
       ),
     ) ;

      final otpbtn = Material(
       borderRadius: BorderRadius.circular(40.0),
       color: Colors.lightBlueAccent,
       shadowColor: Colors.lightGreenAccent.shade100,
      // elevation: 5.0,
       child: MaterialButton(
         
         child: 
         Text('Get OTP', style: TextStyle(color: Colors.white,fontSize: 28.0),), 
         onPressed: verifyNumber,
       ),
     ) ;

     final forgetlb = FlatButton(
      
       child:  Text('Resend Code',
       //textAlign: TextAlign.right,
       style: TextStyle(color: Colors.blueAccent,fontSize: 16.0),
       ),
       onPressed: () {},
     );


    return Scaffold(
      
    
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('assets/bg.jpg',
          fit: BoxFit.cover,
          color: Colors.black38,
          colorBlendMode: BlendMode.softLight,
          ),
          
          Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            
              Text('Login Page',textAlign: 
              TextAlign.center,
              style: 
                TextStyle(color: 
                Colors.lightBlueAccent,
                fontSize: 65.0,
                //fontStyle: FontStyle.italic,
              ),
              ),
               Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            
            logo,
            SizedBox(height: 50.0),
            email,
            SizedBox(height: 15.0),
            pass,
            SizedBox(height: 50.0),
            loginbtn,
            SizedBox(height: 8.0),
            otpbtn,
            Column(
              //mainAxisAlignment : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              forgetlb,
              ],
            ),


          ],
        ),
      ),
      ) ,
            ],

          )
        ],
      )
    );
  }
}
