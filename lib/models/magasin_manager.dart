

import 'dart:async';

import 'package:course/global_vars.dart';
import 'package:course/models/magasin.dart';

class MagasinManager{

  static Stream<List<Magasin>> getAllStream(){
    StreamController<List<Magasin>> controller = StreamController<List<Magasin>>();

    Stream<List<Magasin>> streamMagasins =   GlobalVars.store!.box<Magasin>().query().watch(triggerImmediately: true).map((event) => event.find());

    controller.addStream(streamMagasins);

    return controller.stream;

  }


}