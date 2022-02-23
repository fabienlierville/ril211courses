// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/article.dart';
import 'models/magasin.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4440121120508191977),
      name: 'Magasin',
      lastPropertyId: const IdUid(3, 1717220788109749748),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6653402750809873116),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6589633058644539121),
            name: 'nom',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1717220788109749748),
            name: 'ville',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 9173954899443339677),
      name: 'Article',
      lastPropertyId: const IdUid(5, 3239567934779650066),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4474646952181587802),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6281867758438191505),
            name: 'nom',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1158939181946115205),
            name: 'prix',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1314418399558923468),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3239567934779650066),
            name: 'magasinId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7856544749811455279),
            relationTarget: 'Magasin')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 9173954899443339677),
      lastIndexId: const IdUid(1, 7856544749811455279),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Magasin: EntityDefinition<Magasin>(
        model: _entities[0],
        toOneRelations: (Magasin object) => [],
        toManyRelations: (Magasin object) => {},
        getId: (Magasin object) => object.id,
        setId: (Magasin object, int id) {
          object.id = id;
        },
        objectToFB: (Magasin object, fb.Builder fbb) {
          final nomOffset = fbb.writeString(object.nom);
          final villeOffset = fbb.writeString(object.ville);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nomOffset);
          fbb.addOffset(2, villeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Magasin(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              nom: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              ville: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    Article: EntityDefinition<Article>(
        model: _entities[1],
        toOneRelations: (Article object) => [object.magasin],
        toManyRelations: (Article object) => {},
        getId: (Article object) => object.id,
        setId: (Article object, int id) {
          object.id = id;
        },
        objectToFB: (Article object, fb.Builder fbb) {
          final nomOffset = fbb.writeString(object.nom);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nomOffset);
          fbb.addFloat64(2, object.prix);
          fbb.addOffset(3, imageOffset);
          fbb.addInt64(4, object.magasin.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Article(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              nom: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              prix:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10));
          object.magasin.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.magasin.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Magasin] entity fields to define ObjectBox queries.
class Magasin_ {
  /// see [Magasin.id]
  static final id = QueryIntegerProperty<Magasin>(_entities[0].properties[0]);

  /// see [Magasin.nom]
  static final nom = QueryStringProperty<Magasin>(_entities[0].properties[1]);

  /// see [Magasin.ville]
  static final ville = QueryStringProperty<Magasin>(_entities[0].properties[2]);
}

/// [Article] entity fields to define ObjectBox queries.
class Article_ {
  /// see [Article.id]
  static final id = QueryIntegerProperty<Article>(_entities[1].properties[0]);

  /// see [Article.nom]
  static final nom = QueryStringProperty<Article>(_entities[1].properties[1]);

  /// see [Article.prix]
  static final prix = QueryDoubleProperty<Article>(_entities[1].properties[2]);

  /// see [Article.image]
  static final image = QueryStringProperty<Article>(_entities[1].properties[3]);

  /// see [Article.magasin]
  static final magasin =
      QueryRelationToOne<Article, Magasin>(_entities[1].properties[4]);
}
