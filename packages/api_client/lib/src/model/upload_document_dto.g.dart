// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_document_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UploadDocumentDtoDocumentTypeEnum
_$uploadDocumentDtoDocumentTypeEnum_LICENSE =
    const UploadDocumentDtoDocumentTypeEnum._('LICENSE');
const UploadDocumentDtoDocumentTypeEnum
_$uploadDocumentDtoDocumentTypeEnum_AADHAAR =
    const UploadDocumentDtoDocumentTypeEnum._('AADHAAR');
const UploadDocumentDtoDocumentTypeEnum
_$uploadDocumentDtoDocumentTypeEnum_PAN =
    const UploadDocumentDtoDocumentTypeEnum._('PAN');
const UploadDocumentDtoDocumentTypeEnum _$uploadDocumentDtoDocumentTypeEnum_RC =
    const UploadDocumentDtoDocumentTypeEnum._('RC');
const UploadDocumentDtoDocumentTypeEnum
_$uploadDocumentDtoDocumentTypeEnum_INSURANCE =
    const UploadDocumentDtoDocumentTypeEnum._('INSURANCE');
const UploadDocumentDtoDocumentTypeEnum
_$uploadDocumentDtoDocumentTypeEnum_PHOTO =
    const UploadDocumentDtoDocumentTypeEnum._('PHOTO');

UploadDocumentDtoDocumentTypeEnum _$uploadDocumentDtoDocumentTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'LICENSE':
      return _$uploadDocumentDtoDocumentTypeEnum_LICENSE;
    case 'AADHAAR':
      return _$uploadDocumentDtoDocumentTypeEnum_AADHAAR;
    case 'PAN':
      return _$uploadDocumentDtoDocumentTypeEnum_PAN;
    case 'RC':
      return _$uploadDocumentDtoDocumentTypeEnum_RC;
    case 'INSURANCE':
      return _$uploadDocumentDtoDocumentTypeEnum_INSURANCE;
    case 'PHOTO':
      return _$uploadDocumentDtoDocumentTypeEnum_PHOTO;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UploadDocumentDtoDocumentTypeEnum>
_$uploadDocumentDtoDocumentTypeEnumValues =
    BuiltSet<UploadDocumentDtoDocumentTypeEnum>(
      const <UploadDocumentDtoDocumentTypeEnum>[
        _$uploadDocumentDtoDocumentTypeEnum_LICENSE,
        _$uploadDocumentDtoDocumentTypeEnum_AADHAAR,
        _$uploadDocumentDtoDocumentTypeEnum_PAN,
        _$uploadDocumentDtoDocumentTypeEnum_RC,
        _$uploadDocumentDtoDocumentTypeEnum_INSURANCE,
        _$uploadDocumentDtoDocumentTypeEnum_PHOTO,
      ],
    );

Serializer<UploadDocumentDtoDocumentTypeEnum>
_$uploadDocumentDtoDocumentTypeEnumSerializer =
    _$UploadDocumentDtoDocumentTypeEnumSerializer();

class _$UploadDocumentDtoDocumentTypeEnumSerializer
    implements PrimitiveSerializer<UploadDocumentDtoDocumentTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LICENSE': 'LICENSE',
    'AADHAAR': 'AADHAAR',
    'PAN': 'PAN',
    'RC': 'RC',
    'INSURANCE': 'INSURANCE',
    'PHOTO': 'PHOTO',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LICENSE': 'LICENSE',
    'AADHAAR': 'AADHAAR',
    'PAN': 'PAN',
    'RC': 'RC',
    'INSURANCE': 'INSURANCE',
    'PHOTO': 'PHOTO',
  };

  @override
  final Iterable<Type> types = const <Type>[UploadDocumentDtoDocumentTypeEnum];
  @override
  final String wireName = 'UploadDocumentDtoDocumentTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UploadDocumentDtoDocumentTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UploadDocumentDtoDocumentTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UploadDocumentDtoDocumentTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UploadDocumentDto extends UploadDocumentDto {
  @override
  final UploadDocumentDtoDocumentTypeEnum documentType;
  @override
  final String documentUrl;

  factory _$UploadDocumentDto([
    void Function(UploadDocumentDtoBuilder)? updates,
  ]) => (UploadDocumentDtoBuilder()..update(updates))._build();

  _$UploadDocumentDto._({required this.documentType, required this.documentUrl})
    : super._();
  @override
  UploadDocumentDto rebuild(void Function(UploadDocumentDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadDocumentDtoBuilder toBuilder() =>
      UploadDocumentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadDocumentDto &&
        documentType == other.documentType &&
        documentUrl == other.documentUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, documentType.hashCode);
    _$hash = $jc(_$hash, documentUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadDocumentDto')
          ..add('documentType', documentType)
          ..add('documentUrl', documentUrl))
        .toString();
  }
}

class UploadDocumentDtoBuilder
    implements Builder<UploadDocumentDto, UploadDocumentDtoBuilder> {
  _$UploadDocumentDto? _$v;

  UploadDocumentDtoDocumentTypeEnum? _documentType;
  UploadDocumentDtoDocumentTypeEnum? get documentType => _$this._documentType;
  set documentType(UploadDocumentDtoDocumentTypeEnum? documentType) =>
      _$this._documentType = documentType;

  String? _documentUrl;
  String? get documentUrl => _$this._documentUrl;
  set documentUrl(String? documentUrl) => _$this._documentUrl = documentUrl;

  UploadDocumentDtoBuilder() {
    UploadDocumentDto._defaults(this);
  }

  UploadDocumentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _documentType = $v.documentType;
      _documentUrl = $v.documentUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadDocumentDto other) {
    _$v = other as _$UploadDocumentDto;
  }

  @override
  void update(void Function(UploadDocumentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadDocumentDto build() => _build();

  _$UploadDocumentDto _build() {
    final _$result =
        _$v ??
        _$UploadDocumentDto._(
          documentType: BuiltValueNullFieldError.checkNotNull(
            documentType,
            r'UploadDocumentDto',
            'documentType',
          ),
          documentUrl: BuiltValueNullFieldError.checkNotNull(
            documentUrl,
            r'UploadDocumentDto',
            'documentUrl',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
