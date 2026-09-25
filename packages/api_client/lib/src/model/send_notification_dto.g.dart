// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_notification_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SendNotificationDtoChannelEnum _$sendNotificationDtoChannelEnum_PUSH =
    const SendNotificationDtoChannelEnum._('PUSH');
const SendNotificationDtoChannelEnum _$sendNotificationDtoChannelEnum_SMS =
    const SendNotificationDtoChannelEnum._('SMS');
const SendNotificationDtoChannelEnum _$sendNotificationDtoChannelEnum_EMAIL =
    const SendNotificationDtoChannelEnum._('EMAIL');

SendNotificationDtoChannelEnum _$sendNotificationDtoChannelEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PUSH':
      return _$sendNotificationDtoChannelEnum_PUSH;
    case 'SMS':
      return _$sendNotificationDtoChannelEnum_SMS;
    case 'EMAIL':
      return _$sendNotificationDtoChannelEnum_EMAIL;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SendNotificationDtoChannelEnum>
_$sendNotificationDtoChannelEnumValues =
    BuiltSet<SendNotificationDtoChannelEnum>(
      const <SendNotificationDtoChannelEnum>[
        _$sendNotificationDtoChannelEnum_PUSH,
        _$sendNotificationDtoChannelEnum_SMS,
        _$sendNotificationDtoChannelEnum_EMAIL,
      ],
    );

Serializer<SendNotificationDtoChannelEnum>
_$sendNotificationDtoChannelEnumSerializer =
    _$SendNotificationDtoChannelEnumSerializer();

class _$SendNotificationDtoChannelEnumSerializer
    implements PrimitiveSerializer<SendNotificationDtoChannelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PUSH': 'PUSH',
    'SMS': 'SMS',
    'EMAIL': 'EMAIL',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PUSH': 'PUSH',
    'SMS': 'SMS',
    'EMAIL': 'EMAIL',
  };

  @override
  final Iterable<Type> types = const <Type>[SendNotificationDtoChannelEnum];
  @override
  final String wireName = 'SendNotificationDtoChannelEnum';

  @override
  Object serialize(
    Serializers serializers,
    SendNotificationDtoChannelEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SendNotificationDtoChannelEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SendNotificationDtoChannelEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SendNotificationDto extends SendNotificationDto {
  @override
  final String userId;
  @override
  final String title;
  @override
  final String body;
  @override
  final SendNotificationDtoChannelEnum channel;
  @override
  final JsonObject? metadata;

  factory _$SendNotificationDto([
    void Function(SendNotificationDtoBuilder)? updates,
  ]) => (SendNotificationDtoBuilder()..update(updates))._build();

  _$SendNotificationDto._({
    required this.userId,
    required this.title,
    required this.body,
    required this.channel,
    this.metadata,
  }) : super._();
  @override
  SendNotificationDto rebuild(
    void Function(SendNotificationDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendNotificationDtoBuilder toBuilder() =>
      SendNotificationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendNotificationDto &&
        userId == other.userId &&
        title == other.title &&
        body == other.body &&
        channel == other.channel &&
        metadata == other.metadata;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, channel.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendNotificationDto')
          ..add('userId', userId)
          ..add('title', title)
          ..add('body', body)
          ..add('channel', channel)
          ..add('metadata', metadata))
        .toString();
  }
}

class SendNotificationDtoBuilder
    implements Builder<SendNotificationDto, SendNotificationDtoBuilder> {
  _$SendNotificationDto? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  SendNotificationDtoChannelEnum? _channel;
  SendNotificationDtoChannelEnum? get channel => _$this._channel;
  set channel(SendNotificationDtoChannelEnum? channel) =>
      _$this._channel = channel;

  JsonObject? _metadata;
  JsonObject? get metadata => _$this._metadata;
  set metadata(JsonObject? metadata) => _$this._metadata = metadata;

  SendNotificationDtoBuilder() {
    SendNotificationDto._defaults(this);
  }

  SendNotificationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _title = $v.title;
      _body = $v.body;
      _channel = $v.channel;
      _metadata = $v.metadata;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendNotificationDto other) {
    _$v = other as _$SendNotificationDto;
  }

  @override
  void update(void Function(SendNotificationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendNotificationDto build() => _build();

  _$SendNotificationDto _build() {
    final _$result =
        _$v ??
        _$SendNotificationDto._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'SendNotificationDto',
            'userId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'SendNotificationDto',
            'title',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'SendNotificationDto',
            'body',
          ),
          channel: BuiltValueNullFieldError.checkNotNull(
            channel,
            r'SendNotificationDto',
            'channel',
          ),
          metadata: metadata,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
