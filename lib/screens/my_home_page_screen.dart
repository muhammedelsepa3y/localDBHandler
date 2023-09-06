import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
   List<String> imageUrls = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 5,
          // crossAxisSpacing: 10,
          // mainAxisSpacing: 10,
          //mainAxisExtent: 50,

        ),
        itemCount: imageUrls.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle image tap event here.
              print('Tapped on image $index');
            },
            child: Card(
              elevation: 2.0,
              margin: EdgeInsets.all(8.0),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),

    );
  }
}
