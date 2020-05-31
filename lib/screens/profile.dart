import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  @override
  
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final TextEditingController _fullnameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _phoneControl = TextEditingController();
  final TextEditingController _addressControl = TextEditingController();
  final TextEditingController _bioControl = TextEditingController();
  final TextEditingController _categoryControl = TextEditingController();
  final TextEditingController _srateControl = TextEditingController();
  final TextEditingController _yearsxpControl = TextEditingController();
  final TextEditingController _fbpageControl = TextEditingController();

  
  
   @override
  void initState() {
    //added by Jhunes
    super.initState();
    getData();
  } //added by Jhunes

  File _image;
  String fullname, email;
  
  // String image = '';
  String name = '';
  String _email = '';
  String _picked = '';

  String phone = '';
  String address = '';
  String bio = "";
  String category = '';
  String srate ='';
  String yearsxp = '';
  String fbpage = '';



  Future getImage() async {
    var image = await
    ImagePicker.pickImage(source:
    ImageSource.gallery);
    
    setState(() {
      _image = image; //SEND DATA
    });
  }

 Future<List> getData() async {
    final response = await http.post("http://192.168.1.2/eventory/login.php", body: {
      "event": "profile",
    });
     print(response.body);
     
     var datauser = json.decode(response.body); 

    
    setState(() {
        // image = datauser[0]['image'];
        name = datauser[0]['fullName'];
        _email = datauser[0]['email'];
        _picked = datauser[0]['accountType'];
        phone = datauser[0]['supplierPhone'];
        address = datauser[0]['supplierAddress'];
        bio = datauser[0]['supplierBio'];
        category = datauser[0]['supplierCategory'];
        srate = datauser[0]['supplierRate'];
        yearsxp = datauser[0]['supplierYears'];
        fbpage = datauser[0]['supplierFacebook'];
       
      });
     return json.decode(response.body);
     
  }
  
  // Future<String> getData() async {
  //   http.Response response = await http.get(
  //     Uri.encodeFull("http://192.168.1.2/eventory/REST_API/getdata.php"),
  //     headers: {
  //      "Accept": "application/json" 
  //     }
  //   );

  //   print(response.body);

  //    List data = json.decode(response.body);
  //   // print(data[0]["email"]);
  //   // print(data[0]["password"]);
  //   // print(data[0]["fullName"]);
  //   // print(data[0]["accountType"]);
  //   setState(() {
  //       name = data[0]['supplierPhone'];
  //       emailAdd = data[0]['supplierAddress'];
     
  //     });
  // }

  void updateData() {
    var url = "http://192.168.1.2/eventory/REST_API/updateData.php";

    http.post(url, body: {
      "fullName": _fullnameControl.text,
      "email": _emailControl.text,
      "supplierPhone": _phoneControl.text,
      "supplierAddress": _addressControl.text,
      "supplierBio": _bioControl .text, 
      "supplierCategory": _categoryControl .text, 
      "supplierRate": _srateControl.text,
      "supplierYears": _yearsxpControl.text,
      "supplierFacebook": _fbpageControl.text,
    });
  }

Future upload(File imageFile) async{
  var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length= await imageFile.length();
  var uri = Uri.parse("http://192.168.1.2/eventory/REST_API/imgUpload.php");

  var request = new http.MultipartRequest("POST", uri);

  var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path)); 
  request.files.add(multipartFile); 

  var response = await request.send();

  if(response.statusCode==200){
    print("Image Uploaded");
  }else{
    print("Upload Failed");
  }
  response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    //  var url = "http://192.168.1.2/eventory/REST_API/updateData.php";

    // http.post(url, body: {
    //   "supplierPhone":_phoneControl.text,
    //   "supplierAddress":  _addressControl.text,
    //   "supplierBio": _bioControl .text, 
    //   "supplierRate": _srateControl.text,
    //   "supplierYears": _yearsxpControl.text,
       
    // });
}

  @override
  Widget build(BuildContext context) {
    if (_picked == 'I am Supplier') {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child:
                   _image == null ? 
                    Image.asset(
                      "assets/cm4.jpeg", //GET IMAGE DATA
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ) :
                    Image.file(_image,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$name",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Event Service Provider",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            getImage();
                            upload(_image);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context){
                            //       return JoinApp();
                            //     },
                            //   ),
                            // );
                          },
                          child: Text(
                            "Change Photo",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {
                      // upload(_image);
                      }
                      ),
                ],
              ),
              TextField(
                controller: _fullnameControl,
                onChanged: (value){
                  debugPrint('fullname: $value');
                  fullname = value; //SEND THIS DATA
                  debugPrint(fullname);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: '$name',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _emailControl,
                onChanged: (value){
                  debugPrint('email: $value');
                  email = value; //SEND THIS DATA
                  debugPrint(email);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: '$_email',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'email',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _phoneControl,
                onChanged: (value){
                  debugPrint('phone: $value'); //SEND THIS DATA
                  phone = value;
                  debugPrint(phone);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: '$phone',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter phone number',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _addressControl,
                onChanged: (value){
                  debugPrint('address: $value');
                  address = value; //SEND THIS DATA
                  debugPrint(address);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: '$address',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full address',
                  border: InputBorder.none,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Service Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {}
                      ),
                ],
              ),
              TextField(
                controller: _bioControl,
                onChanged: (value){
                  debugPrint('bio: $value');
                  bio = value; //SEND THIS DATA
                  debugPrint(bio);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.subject),
                  labelText: '$bio',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Tell more about yourself',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _categoryControl,
                onChanged: (value){
                  debugPrint('category: $value');
                   category = value; //SEND THIS DATA
                  // debugPrint(category);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.work),
                  labelText: '$category',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'What Service do you provide?',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _srateControl,
                onChanged: (value){
                  debugPrint('srate: $value');
                  srate = value; //SEND THIS DATA
                  debugPrint(srate);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.local_offer),
                  labelText: '$srate',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter your starting rate (PHP)',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _yearsxpControl,
                onChanged: (value){
                  debugPrint('yearsxp: $value');
                  yearsxp = value; //SEND THIS DATA
                  debugPrint(yearsxp);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.hourglass_full),
                  labelText: '$yearsxp',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter your years of experience',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _fbpageControl,
                onChanged: (value){
                  debugPrint('fbpage: $value');
                  fbpage = value; //SEND THIS DATA
                  debugPrint(fbpage);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.web),
                  labelText: '$fbpage',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter Link to your Facebook Page',
                  border: InputBorder.none,
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text ('Update',
                       style: TextStyle(
                        color: Colors.white,
                        ),
                        ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                      updateData();
                      // Toast.show("Profile Updated", context,
                      // duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      //getData();
                      }
                      ),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Image.asset(
                      "assets/cm4.jpeg",
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Neo Lamperouge",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Client",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                //insert UPLOAD PHOTO function
                              },
                              child: Text(
                                "Change Photo",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {}
                      ),
                ],
              ),
              TextField(
                onChanged: (value){
                  debugPrint('full name: $value');
                  fullname = value; //SEND THIS DATA
                  debugPrint(fullname);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                onChanged: (value){
                  debugPrint('email: $value');
                  email = value; //SEND THIS DATA
                  debugPrint(email);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter email address',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _phoneControl,
                onChanged: (value){
                  debugPrint('phone: $value');
                  phone = value; //SEND THIS DATA
                  debugPrint(phone);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Phone',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter phone number',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _addressControl,
                onChanged: (value){
                  debugPrint('address: $value');
                  address = value; //SEND THIS DATA
                  debugPrint(address);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full address',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
