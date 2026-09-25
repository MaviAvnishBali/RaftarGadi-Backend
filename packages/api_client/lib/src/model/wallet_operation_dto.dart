//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_operation_dto.g.dart';

/// WalletOperationDto
///
/// Properties:
/// * [amount] 
/// * [description] 
@BuiltValue()
abstract class WalletOperationDto implements Built<WalletOperationDto, WalletOperationDtoBuilder> {
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'description')
  String get description;

  WalletOperationDto._();

  factory WalletOperationDto([void updates(WalletOperationDtoBuilder b)]) = _$WalletOperationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletOperationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletOperationDto> get serializer => _$WalletOperationDtoSerializer();
}

class _$WalletOperationDtoSerializer implements PrimitiveSerializer<WalletOperationDto> {
  @override
  final Iterable<Type> types = const [WalletOperationDto, _$WalletOperationDto];

  @override
  final String wireName = r'WalletOperationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletOperationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletOperationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletOperationDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletOperationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletOperationDtoBuilder();
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


