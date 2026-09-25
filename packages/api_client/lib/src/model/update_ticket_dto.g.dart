// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ticket_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateTicketDtoStatusEnum _$updateTicketDtoStatusEnum_OPEN =
    const UpdateTicketDtoStatusEnum._('OPEN');
const UpdateTicketDtoStatusEnum _$updateTicketDtoStatusEnum_IN_PROGRESS =
    const UpdateTicketDtoStatusEnum._('IN_PROGRESS');
const UpdateTicketDtoStatusEnum _$updateTicketDtoStatusEnum_RESOLVED =
    const UpdateTicketDtoStatusEnum._('RESOLVED');
const UpdateTicketDtoStatusEnum _$updateTicketDtoStatusEnum_CLOSED =
    const UpdateTicketDtoStatusEnum._('CLOSED');

UpdateTicketDtoStatusEnum _$updateTicketDtoStatusEnumValueOf(String name) {
  switch (name) {
    case 'OPEN':
      return _$updateTicketDtoStatusEnum_OPEN;
    case 'IN_PROGRESS':
      return _$updateTicketDtoStatusEnum_IN_PROGRESS;
    case 'RESOLVED':
      return _$updateTicketDtoStatusEnum_RESOLVED;
    case 'CLOSED':
      return _$updateTicketDtoStatusEnum_CLOSED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateTicketDtoStatusEnum> _$updateTicketDtoStatusEnumValues =
    BuiltSet<UpdateTicketDtoStatusEnum>(const <UpdateTicketDtoStatusEnum>[
      _$updateTicketDtoStatusEnum_OPEN,
      _$updateTicketDtoStatusEnum_IN_PROGRESS,
      _$updateTicketDtoStatusEnum_RESOLVED,
      _$updateTicketDtoStatusEnum_CLOSED,
    ]);

Serializer<UpdateTicketDtoStatusEnum> _$updateTicketDtoStatusEnumSerializer =
    _$UpdateTicketDtoStatusEnumSerializer();

class _$UpdateTicketDtoStatusEnumSerializer
    implements PrimitiveSerializer<UpdateTicketDtoStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'OPEN': 'OPEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'OPEN': 'OPEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
  };

  @override
  final Iterable<Type> types = const <Type>[UpdateTicketDtoStatusEnum];
  @override
  final String wireName = 'UpdateTicketDtoStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateTicketDtoStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateTicketDtoStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateTicketDtoStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateTicketDto extends UpdateTicketDto {
  @override
  final UpdateTicketDtoStatusEnum status;
  @override
  final String? assignedTo;

  factory _$UpdateTicketDto([void Function(UpdateTicketDtoBuilder)? updates]) =>
      (UpdateTicketDtoBuilder()..update(updates))._build();

  _$UpdateTicketDto._({required this.status, this.assignedTo}) : super._();
  @override
  UpdateTicketDto rebuild(void Function(UpdateTicketDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateTicketDtoBuilder toBuilder() => UpdateTicketDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateTicketDto &&
        status == other.status &&
        assignedTo == other.assignedTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, assignedTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateTicketDto')
          ..add('status', status)
          ..add('assignedTo', assignedTo))
        .toString();
  }
}

class UpdateTicketDtoBuilder
    implements Builder<UpdateTicketDto, UpdateTicketDtoBuilder> {
  _$UpdateTicketDto? _$v;

  UpdateTicketDtoStatusEnum? _status;
  UpdateTicketDtoStatusEnum? get status => _$this._status;
  set status(UpdateTicketDtoStatusEnum? status) => _$this._status = status;

  String? _assignedTo;
  String? get assignedTo => _$this._assignedTo;
  set assignedTo(String? assignedTo) => _$this._assignedTo = assignedTo;

  UpdateTicketDtoBuilder() {
    UpdateTicketDto._defaults(this);
  }

  UpdateTicketDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _assignedTo = $v.assignedTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateTicketDto other) {
    _$v = other as _$UpdateTicketDto;
  }

  @override
  void update(void Function(UpdateTicketDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateTicketDto build() => _build();

  _$UpdateTicketDto _build() {
    final _$result =
        _$v ??
        _$UpdateTicketDto._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'UpdateTicketDto',
            'status',
          ),
          assignedTo: assignedTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
