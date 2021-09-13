import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'account_record.g.dart';

abstract class AccountRecord
    implements Built<AccountRecord, AccountRecordBuilder> {
  static Serializer<AccountRecord> get serializer => _$accountRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'FullName')
  String get fullName;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'Password')
  String get password;

  @nullable
  @BuiltValueField(wireName: 'CPassword')
  String get cPassword;

  @nullable
  String get pictures;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AccountRecordBuilder builder) => builder
    ..fullName = ''
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..password = ''
    ..cPassword = ''
    ..pictures = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('account');

  static Stream<AccountRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AccountRecord._();
  factory AccountRecord([void Function(AccountRecordBuilder) updates]) =
      _$AccountRecord;

  static AccountRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createAccountRecordData({
  String fullName,
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String password,
  String cPassword,
  String pictures,
}) =>
    serializers.toFirestore(
        AccountRecord.serializer,
        AccountRecord((a) => a
          ..fullName = fullName
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..password = password
          ..cPassword = cPassword
          ..pictures = pictures));
