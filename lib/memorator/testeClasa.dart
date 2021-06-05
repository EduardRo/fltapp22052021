import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://www.matematicon.ro/_teste-grila-json/teste-cls.php?cls=10'));
  // .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  //https://www.matematicon.ro/_teste-grila-json/teste-cls.php?cls=09
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String albumId;
  final String id;
  final String title;
  final String url;
  final String thumbnailUrl;
  final String enuntUrl;
  final String v1Url;
  final String v2Url;
  final String v3Url;
  final String v4Url;
  final String raspunsUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.enuntUrl,
    required this.v1Url,
    required this.v2Url,
    required this.v3Url,
    required this.v4Url,
    required this.raspunsUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['idtest'] as String,
      id: json['codserie'] as String,
      title: json['denumireserie'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      enuntUrl: json['enuntUrl'] as String,
      v1Url: json['v1Url'] as String,
      v2Url: json['v2Url'] as String,
      v3Url: json['v3Url'] as String,
      v4Url: json['v4Url'] as String,
      raspunsUrl: json['raspunsUrl'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;
  final List<int> colorCodes = <int>[600, 500, 100];

  PhotosList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Container(
                  child: Material(
                    child: Image.network(
                      photos[index].enuntUrl,
                      color: Colors.black,
                    ),
                    elevation: 15.0,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    child: ElevatedButton(
                      onPressed: null,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.network(
                          photos[index].v1Url,
                          color: Colors.yellowAccent,
                          width: double.maxFinite,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                    ),
                    elevation: 25.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Image.network(
                    photos[index].v2Url,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Image.network(
                    photos[index].v3Url,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        });
  }

  // return ListView.builder(
  //   itemCount: photos.length,
  //   itemBuilder: (context, index) {
  //     return Image.network(
  //       photos[index].thumbnailUrl,
  //       photos[index].v1Url,
  //       color: Colors.blue,
  //       height: 200.00,
  //     );
  //   },
  // );
}
