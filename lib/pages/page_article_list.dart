
import 'dart:io';

import 'package:course/models/article.dart';
import 'package:course/models/article_manager.dart';
import 'package:course/models/magasin.dart';
import 'package:course/pages/page_article_add.dart';
import 'package:flutter/material.dart';

class PageArticleList extends StatelessWidget {
  final Magasin magasin;
  const PageArticleList({Key? key,required this.magasin }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(magasin.nom),
        actions: [
          TextButton(
            child: Text("Ajouter", style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return PageArticleAdd(magasin: magasin,);
              }));
            },
          )
        ],
      ),
        body: StreamBuilder<List<Article>>(
          stream: ArticleManager.getAllStream(magasin),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(
                child: Text("NoData"),
              );
            }else{
              List<Article> articles = snapshot.data;
              if( articles == null || articles.length == 0){
                return Center(child: Text("No Articles"),);
              }

              return GridView.builder(
                  itemCount: articles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    Article art = articles[index];
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Nom
                          Text(art.nom),
                          // Image
                          Expanded(
                              child: (art.image == null)
                                  ?Image.asset('assets/images/no_image.png')
                                  :Image.file(File(art.image!)),
                          ),
                          //Prix + Delete
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${art.prix}€"),
                              IconButton(
                                  onPressed: (){
                                    ArticleManager.remove(art);
                                  },
                                  icon: Icon(Icons.delete)
                              )
                            ],

                          )
                        ],
                      ),
                    );
                  }
              );

            }
          },
        ),
    );
  }

}
