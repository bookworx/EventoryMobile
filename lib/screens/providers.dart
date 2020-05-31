import 'package:flutter/material.dart';
//
import 'package:Eventory/util/providers_data.dart'; //reference
//
import 'package:Eventory/widgets/providers_format.dart';  //format


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  // int _current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "All Suppliers",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            
//DISPLAY OF DATA STARTS HERE

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: suppliers == null ? 0 : suppliers.length, //the source of data
              itemBuilder: (BuildContext context, int index) {
                Map supplier = suppliers[index]; //the source of data

                return GridProduct(
                  img: supplier['img'],
                  name: supplier['name'],
                  scategory: supplier['scategory'],
                  srate: supplier['srate'],
                );
              },
            ),

//DISPLAY OF DATA ENDED HERE

          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
