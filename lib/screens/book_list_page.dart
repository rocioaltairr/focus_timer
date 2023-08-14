import 'package:flutter/material.dart';

class bookListPage extends StatelessWidget {
  const bookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount:10,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text("Item $index"),
          );
      })
    );
  }
}
