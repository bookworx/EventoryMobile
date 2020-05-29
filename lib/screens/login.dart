import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Eventory/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  String msg = ''; //added by Jhunes
  String name = ''; //added by Jhunes
  bool isLoggedIn = false; //added by Jhunes
  

   @override
  void initState() {
    //added by Jhunes
    super.initState();
    autoLogIn();
  } //added by Jhunes

  void autoLogIn() async {
    //added by Jhunes
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); //added by Jhunes
    final String userId = prefs.getString('accountID');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
      return;
    }
  } //added by Jhunes


//  Future<List> _login() async {
//   final response = await http.post("http://192.168.1.11/eventory/REST_API/login.php", body: {
//     "email": email.text,
//     "password": password.text,
//   });

//   var datauser = json.decode(response.body);

//   if(datauser.length==0){
//     setState(() {
//           msg="Login Fail";
//         });
//   }else{
//     if(datauser[0]['accountType']=='I am Client'){
//       Navigator.pushReplacementNamed(context, '/Client');
//       Toast.show("Login Successfully as Client", context,
//       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      
//     }else if(datauser[0]['accountType']=='I am Supplier'){
//       Navigator.pushReplacementNamed(context, '/Supplier');
//       Toast.show("Login Successfully as Supplier", context,
//       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     }
//      setState(() {
        
//         username= datauser[0]['fullName'];
//         emailAdd = datauser[0]['email'];
//         accountType = datauser[0]['accountType'];
//       });

    
    
//   }
//   return datauser;
// }

Future<List> _login() async {
    print("Hello");

    final response = await http.post("http://192.168.1.2/eventory/login.php", body: {
      "event": "login",
      "email": email.text,
      "password": password.text
    });
    print(response.body);
    print(email.text);
    print(password.text);
    var datauser = json.decode(response.body);
    print(datauser[0]['accountID']);
    if (datauser.length == 0) {
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accountID', datauser[0]['accountID']);

      setState(() {
        name = datauser[0]['accountID'];
        isLoggedIn = true;
      });

      email.clear();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );

      if(datauser[0]['accountType']=='I am Client'){
        Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
      Toast.show("Login Successfully as Client", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      
    }else if(datauser[0]['accountType']=='I am Supplier'){
       Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
      Toast.show("Login Successfully as Supplier", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
   }
  } //added Jhunes


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 25.0,
            ),
            child: Text(
              "Log in to your account", //edited by Neo
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: email,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                maxLines: 1,
                controller: password,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "LOGIN".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _login(); //added by Jhunes
                
              
              },
              
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 10.0),
          Center(
            child: Image.asset('assets/footer.png'),
          ),
          Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)
        ],
      ),
    );
    
  }
}
