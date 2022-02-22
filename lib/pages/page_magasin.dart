import 'package:flutter/material.dart';

class PageMagasin extends StatefulWidget {
  const PageMagasin({Key? key}) : super(key: key);

  @override
  _PageMagasinState createState() => _PageMagasinState();
}

class _PageMagasinState extends State<PageMagasin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magasins"),
      ),
      body: Center(),
    );
  }
}
