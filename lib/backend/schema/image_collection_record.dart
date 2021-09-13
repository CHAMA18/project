import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'image_collection_record.g.dart';

abstract class ImageCollectionRecord
    implements Built<ImageCollectionRecord, ImageCollectionRecordBuilder> {
  static Serializer<ImageCollectionRecord> get serializer =>
      _$imageCollectionRecordSerializer;

  @nullable
  String get pictures;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ImageCollectionRecordBuilder builder) =>
      builder..pictures = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('image_collection');

  static Stream<ImageCollectionRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ImageCollectionRecord._();
  factory ImageCollectionRecord(
          [void Function(ImageCollectionRecordBuilder) updates]) =
      _$ImageCollectionRecord;

  static ImageCollectionRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createImageCollectionRecordData({
  String pictures,
}) =>
    serializers.toFirestore(ImageCollectionRecord.serializer,
        ImageCollectionRecord((i) => i..pictures = pictures));
