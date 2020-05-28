import 'package:flutter/material.dart';
import 'package:Eventory/screens/provider_info.dart';

class GridProduct extends StatelessWidget {

  final String img;
  final String name;
  final String scategory;
  final String srate;

  GridProduct({
    Key key,
    @required this.img,
    @required this.name,
    @required this.scategory,
    @required this.srate, category})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

          ),

          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),

           Padding(
             padding: EdgeInsets.only(bottom: 2.0, top: 3.0),
             child:
          Text(
              "$scategory",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                  ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Starting Rate:  P$srate",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),

              ],
            ),
          ),


        ],
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context){
              return SupplierInfo();
            },
          ),
        );
      },
    );
  }
}
