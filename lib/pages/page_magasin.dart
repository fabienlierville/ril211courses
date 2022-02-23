import 'package:course/global_vars.dart';
import 'package:course/models/magasin.dart';
import 'package:course/models/magasin_manager.dart';
import 'package:course/objectbox.g.dart';
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
        actions: [
          TextButton(
              onPressed: (){
                upsert(null);
              },
              child: Text("Ajouter", style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
      body: StreamBuilder<List<Magasin>>(
        stream: MagasinManager.getAllStream(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: Text("NoData"),);
          }
          List<Magasin> magasins = snapshot.data!;
          if(magasins.length == 0){
            return Center(child: Text("NoData"),);
          }
          return ListView.builder(
            itemCount: magasins.length,
            itemBuilder: (context, index){
              Magasin mag = magasins[index];
              return ListTile(
                title: Text(mag.nom),
                subtitle: Text(mag.ville),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    MagasinManager.remove(mag);
                  },
                ),
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    upsert(mag);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> upsert(Magasin? magasin) async {
    String? newMagasinNom = magasin?.nom ?? null;
    String? newMagasinVille = magasin?.ville ?? null;

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Ajouter un magasin'),
            content: Container(
              //On défini la hauteur car de base la colonne prend toute la hauteur
              height: MediaQuery.of(buildContext).size.height / 5,
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text:  magasin?.nom),
                    decoration: InputDecoration(
                        labelText: 'Nom Magasin:',
                        hintText: (magasin==null) ? 'ex: Leclerc' : magasin?.nom
                    ),
                    onChanged: (String str) {
                      newMagasinNom = str;
                    },
                  ),
                  TextField(
                    controller: TextEditingController(text:  magasin?.ville) ,
                    decoration: InputDecoration(
                        labelText: 'Ville Magasin:',
                        hintText: (magasin==null) ? 'ex: Rouen' : magasin?.ville
                    ),
                    onChanged: (String str) {
                      newMagasinVille = str;
                    },
                  ),
                ],
              ) ,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(buildContext);
                },
                child: Text('Annuler'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  if(newMagasinNom != null && newMagasinVille != null){
                    if(magasin == null){
                      magasin = Magasin(nom: newMagasinNom!, ville: newMagasinVille!);
                    }else{
                      magasin!.nom = newMagasinNom!;
                      magasin!.ville = newMagasinVille!;
                    }

                    Box box = GlobalVars.store!.box<Magasin>();
                    int id = box.put(magasin);
                    print(id);
                    Navigator.pop(buildContext);
                  }
                },
                child: Text('Valider'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              )
            ],
          );
        }
    );
  }

}
