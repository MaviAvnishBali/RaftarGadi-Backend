// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rating_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRatingDto extends CreateRatingDto {
  @override
  final String bookingId;
  @override
  final num rating;
  @override
  final String? review;

  factory _$CreateRatingDto([void Function(CreateRatingDtoBuilder)? updates]) =>
      (CreateRatingDtoBuilder()..update(updates))._build();

  _$CreateRatingDto._({
    required this.bookingId,
    required this.rating,
    this.review,
  }) : super._();
  @override
  CreateRatingDto rebuild(void Function(CreateRatingDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRatingDtoBuilder toBuilder() => CreateRatingDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRatingDto &&
        bookingId == other.bookingId &&
        rating == other.rating &&
        review == other.review;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookingId.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, review.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRatingDto')
          ..add('bookingId', bookingId)
          ..add('rating', rating)
          ..add('review', review))
        .toString();
  }
}

class CreateRatingDtoBuilder
    implements Builder<CreateRatingDto, CreateRatingDtoBuilder> {
  _$CreateRatingDto? _$v;

  String? _bookingId;
  String? get bookingId => _$this._bookingId;
  set bookingId(String? bookingId) => _$this._bookingId = bookingId;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  String? _review;
  String? get review => _$this._review;
  set review(String? review) => _$this._review = review;

  CreateRatingDtoBuilder() {
    CreateRatingDto._defaults(this);
  }

  CreateRatingDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookingId = $v.bookingId;
      _rating = $v.rating;
      _review = $v.review;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRatingDto other) {
    _$v = other as _$CreateRatingDto;
  }

  @override
  void update(void Function(CreateRatingDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRatingDto build() => _build();

  _$CreateRatingDto _build() {
    final _$result =
        _$v ??
        _$CreateRatingDto._(
          bookingId: BuiltValueNullFieldError.checkNotNull(
            bookingId,
            r'CreateRatingDto',
            'bookingId',
          ),
          rating: BuiltValueNullFieldError.checkNotNull(
            rating,
            r'CreateRatingDto',
            'rating',
          ),
          review: review,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
