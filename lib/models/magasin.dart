
import 'package:objectbox/objectbox.dart';

@Entity()
class Magasin{
  int id;

  String nom;
  String ville;

  Magasin({this.id=0, required this.nom, required this.ville});

}