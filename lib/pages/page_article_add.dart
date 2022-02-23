import 'dart:io';

import 'package:course/models/article.dart';
import 'package:course/models/article_manager.dart';
import 'package:course/models/magasin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageArticleAdd extends StatefulWidget {
  final Magasin magasin;
  const PageArticleAdd({Key? key,required this.magasin}) : super(key: key);

  @override
  _PageArticleAddState createState() => _PageArticleAddState();
}



class _PageArticleAddState extends State<PageArticleAdd> {
  String? image; // sera utilisée plus tard pour utiliser imagepicker
  String? nom;
  String? prix;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter'),
        actions: <Widget>[
          TextButton(onPressed: ajouter, child: Text('Valider', style: TextStyle(color: Colors.white)))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Article à ajouter', textScaleFactor: 1.4, style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),),
            Card(
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (image == null)
                      ?Image.asset('assets/img/no_image.png')
                      :Image.file(File(image!)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera_enhance),
                          onPressed: (){
                            getImage(ImageSource.camera);
                          }
                      ),
                      IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: (){
                            getImage(ImageSource.gallery);
                          }
                      )
                    ],
                  ),
                  textfield(TypeTextField.nom, "Nom de l'article"),
                  textfield(TypeTextField.prix, "Prix de l'article"),

                ],
              ),
            )
          ],

        ),
      ),
    );

  }

  TextField textfield(TypeTextField type, String label) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.prix:
            prix = string;
            break;
        }
      },
    );

  }

  void ajouter() async{
    if(nom != null && prix != null && widget.magasin != null){
      Article article = Article(nom: nom!, prix: double.tryParse(prix!)!, image: image);
      int id = ArticleManager.upsert(article, widget.magasin);
      if(id != 0){
        Navigator.pop(context);
      }
      //Todo un snackbar qui affiche une erreur
    }
  }

  Future<void> getImage(ImageSource source) async{
    XFile? pickedFile =  await picker.pickImage(source: source);
    setState(() {
      image = pickedFile?.path;
      print(image);
    });
  }

}


enum TypeTextField {nom, prix}