// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ticket_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateTicketDtoPriorityEnum _$createTicketDtoPriorityEnum_LOW =
    const CreateTicketDtoPriorityEnum._('LOW');
const CreateTicketDtoPriorityEnum _$createTicketDtoPriorityEnum_MEDIUM =
    const CreateTicketDtoPriorityEnum._('MEDIUM');
const CreateTicketDtoPriorityEnum _$createTicketDtoPriorityEnum_HIGH =
    const CreateTicketDtoPriorityEnum._('HIGH');
const CreateTicketDtoPriorityEnum _$createTicketDtoPriorityEnum_URGENT =
    const CreateTicketDtoPriorityEnum._('URGENT');

CreateTicketDtoPriorityEnum _$createTicketDtoPriorityEnumValueOf(String name) {
  switch (name) {
    case 'LOW':
      return _$createTicketDtoPriorityEnum_LOW;
    case 'MEDIUM':
      return _$createTicketDtoPriorityEnum_MEDIUM;
    case 'HIGH':
      return _$createTicketDtoPriorityEnum_HIGH;
    case 'URGENT':
      return _$createTicketDtoPriorityEnum_URGENT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateTicketDtoPriorityEnum>
_$createTicketDtoPriorityEnumValues =
    BuiltSet<CreateTicketDtoPriorityEnum>(const <CreateTicketDtoPriorityEnum>[
      _$createTicketDtoPriorityEnum_LOW,
      _$createTicketDtoPriorityEnum_MEDIUM,
      _$createTicketDtoPriorityEnum_HIGH,
      _$createTicketDtoPriorityEnum_URGENT,
    ]);

Serializer<CreateTicketDtoPriorityEnum>
_$createTicketDtoPriorityEnumSerializer =
    _$CreateTicketDtoPriorityEnumSerializer();

class _$CreateTicketDtoPriorityEnumSerializer
    implements PrimitiveSerializer<CreateTicketDtoPriorityEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LOW': 'LOW',
    'MEDIUM': 'MEDIUM',
    'HIGH': 'HIGH',
    'URGENT': 'URGENT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LOW': 'LOW',
    'MEDIUM': 'MEDIUM',
    'HIGH': 'HIGH',
    'URGENT': 'URGENT',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateTicketDtoPriorityEnum];
  @override
  final String wireName = 'CreateTicketDtoPriorityEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateTicketDtoPriorityEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateTicketDtoPriorityEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateTicketDtoPriorityEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateTicketDto extends CreateTicketDto {
  @override
  final String? bookingId;
  @override
  final String subject;
  @override
  final String description;
  @override
  final CreateTicketDtoPriorityEnum? priority;

  factory _$CreateTicketDto([void Function(CreateTicketDtoBuilder)? updates]) =>
      (CreateTicketDtoBuilder()..update(updates))._build();

  _$CreateTicketDto._({
    this.bookingId,
    required this.subject,
    required this.description,
    this.priority,
  }) : super._();
  @override
  CreateTicketDto rebuild(void Function(CreateTicketDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateTicketDtoBuilder toBuilder() => CreateTicketDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTicketDto &&
        bookingId == other.bookingId &&
        subject == other.subject &&
        description == other.description &&
        priority == other.priority;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookingId.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateTicketDto')
          ..add('bookingId', bookingId)
          ..add('subject', subject)
          ..add('description', description)
          ..add('priority', priority))
        .toString();
  }
}

class CreateTicketDtoBuilder
    implements Builder<CreateTicketDto, CreateTicketDtoBuilder> {
  _$CreateTicketDto? _$v;

  String? _bookingId;
  String? get bookingId => _$this._bookingId;
  set bookingId(String? bookingId) => _$this._bookingId = bookingId;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateTicketDtoPriorityEnum? _priority;
  CreateTicketDtoPriorityEnum? get priority => _$this._priority;
  set priority(CreateTicketDtoPriorityEnum? priority) =>
      _$this._priority = priority;

  CreateTicketDtoBuilder() {
    CreateTicketDto._defaults(this);
  }

  CreateTicketDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookingId = $v.bookingId;
      _subject = $v.subject;
      _description = $v.description;
      _priority = $v.priority;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTicketDto other) {
    _$v = other as _$CreateTicketDto;
  }

  @override
  void update(void Function(CreateTicketDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTicketDto build() => _build();

  _$CreateTicketDto _build() {
    final _$result =
        _$v ??
        _$CreateTicketDto._(
          bookingId: bookingId,
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'CreateTicketDto',
            'subject',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'CreateTicketDto',
            'description',
          ),
          priority: priority,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
