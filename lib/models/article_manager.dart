

import 'dart:async';

import 'package:course/global_vars.dart';
import 'package:course/models/article.dart';
import 'package:course/models/magasin.dart';
import 'package:course/objectbox.g.dart';

class ArticleManager{
  static Stream<List<Article>> getAllStream(Magasin mag){
    StreamController<List<Article>> controller = StreamController<List<Article>>();
    if(GlobalVars.store != null){
      Stream<List<Article>> articles = GlobalVars.store!.box<Article>().query(Article_.magasin.equals(mag.id)).watch(triggerImmediately: true).map((query) => query.find());
      controller.addStream(articles);
    }
    return controller.stream;
  }

  static int upsert(Article art, Magasin mag){
    if(GlobalVars.store != null){
      art.magasin.target = mag;
      return GlobalVars.store!.box<Article>().put(art);
    }
    return 0;
  }

  static bool remove(Article art){
    if(GlobalVars.store != null){
      GlobalVars.store!.box<Article>().remove(art.id);
      return true;
    }
    return false;
  }



}