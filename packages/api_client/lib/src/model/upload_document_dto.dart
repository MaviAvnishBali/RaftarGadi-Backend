//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_document_dto.g.dart';

/// UploadDocumentDto
///
/// Properties:
/// * [documentType] 
/// * [documentUrl] 
@BuiltValue()
abstract class UploadDocumentDto implements Built<UploadDocumentDto, UploadDocumentDtoBuilder> {
  @BuiltValueField(wireName: r'documentType')
  UploadDocumentDtoDocumentTypeEnum get documentType;
  // enum documentTypeEnum {  LICENSE,  AADHAAR,  PAN,  RC,  INSURANCE,  PHOTO,  };

  @BuiltValueField(wireName: r'documentUrl')
  String get documentUrl;

  UploadDocumentDto._();

  factory UploadDocumentDto([void updates(UploadDocumentDtoBuilder b)]) = _$UploadDocumentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadDocumentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadDocumentDto> get serializer => _$UploadDocumentDtoSerializer();
}

class _$UploadDocumentDtoSerializer implements PrimitiveSerializer<UploadDocumentDto> {
  @override
  final Iterable<Type> types = const [UploadDocumentDto, _$UploadDocumentDto];

  @override
  final String wireName = r'UploadDocumentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadDocumentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'documentType';
    yield serializers.serialize(
      object.documentType,
      specifiedType: const FullType(UploadDocumentDtoDocumentTypeEnum),
    );
    yield r'documentUrl';
    yield serializers.serialize(
      object.documentUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadDocumentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UploadDocumentDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'documentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UploadDocumentDtoDocumentTypeEnum),
          ) as UploadDocumentDtoDocumentTypeEnum;
          result.documentType = valueDes;
          break;
        case r'documentUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.documentUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadDocumentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadDocumentDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


class UploadDocumentDtoDocumentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LICENSE')
  static const UploadDocumentDtoDocumentTypeEnum LICENSE = _$uploadDocumentDtoDocumentTypeEnum_LICENSE;
  @BuiltValueEnumConst(wireName: r'AADHAAR')
  static const UploadDocumentDtoDocumentTypeEnum AADHAAR = _$uploadDocumentDtoDocumentTypeEnum_AADHAAR;
  @BuiltValueEnumConst(wireName: r'PAN')
  static const UploadDocumentDtoDocumentTypeEnum PAN = _$uploadDocumentDtoDocumentTypeEnum_PAN;
  @BuiltValueEnumConst(wireName: r'RC')
  static const UploadDocumentDtoDocumentTypeEnum RC = _$uploadDocumentDtoDocumentTypeEnum_RC;
  @BuiltValueEnumConst(wireName: r'INSURANCE')
  static const UploadDocumentDtoDocumentTypeEnum INSURANCE = _$uploadDocumentDtoDocumentTypeEnum_INSURANCE;
  @BuiltValueEnumConst(wireName: r'PHOTO')
  static const UploadDocumentDtoDocumentTypeEnum PHOTO = _$uploadDocumentDtoDocumentTypeEnum_PHOTO;

  static Serializer<UploadDocumentDtoDocumentTypeEnum> get serializer => _$uploadDocumentDtoDocumentTypeEnumSerializer;

  const UploadDocumentDtoDocumentTypeEnum._(String name): super(name);

  static BuiltSet<UploadDocumentDtoDocumentTypeEnum> get values => _$uploadDocumentDtoDocumentTypeEnumValues;
  static UploadDocumentDtoDocumentTypeEnum valueOf(String name) => _$uploadDocumentDtoDocumentTypeEnumValueOf(name);
}

