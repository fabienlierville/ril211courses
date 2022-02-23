
import 'package:course/models/magasin.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class Article{
  int id;
  String nom;
  double prix;
  String? image;
  final magasin = ToOne<Magasin>();
  Article({this.id = 0, required this.nom, required this.prix, this.image});

}