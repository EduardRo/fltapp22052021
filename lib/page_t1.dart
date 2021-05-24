import 'package:flutter/material.dart';

void main() {
  runApp(PageT1());
}

class PageT1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('this is test1 page'),
        ),
        body: myLayoutWidget1(),
      ),
    );
  }
}

Widget myLayoutWidget() {
  return Row(
    children: [
      Expanded(child: Icon(Icons.home)),
      Text('this is a text'),
      Expanded(child: Icon(Icons.home)),
      Expanded(child: Icon(Icons.home)),
      Expanded(child: Icon(Icons.home)),
    ],
  );
}

Widget myLayoutWidget1() {
  return Row(
    children: [
      Expanded(
          flex: 7,
          child: Container(
            color: Colors.green,
          )),
      Expanded(
        flex: 3,
        child: Container(
            color: Colors.redAccent,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('this is the text on red',
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Pattaya',
                          height: 1.4,
                          fontSize: 20)),
                ),
                Image.network('https://picsum.photos/250?image=9'),
                Image.network('https://picsum.photos/250?image=19'),
              ],
            )),
      ),
    ],
  );
}
