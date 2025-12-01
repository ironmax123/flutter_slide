// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slide_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SlideContent _$SlideContentFromJson(Map<String, dynamic> json) {
  return _SlideContent.fromJson(json);
}

/// @nodoc
mixin _$SlideContent {
  @JsonKey(name: 'page_num')
  int get pageNum => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;

  /// Serializes this SlideContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SlideContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlideContentCopyWith<SlideContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideContentCopyWith<$Res> {
  factory $SlideContentCopyWith(
    SlideContent value,
    $Res Function(SlideContent) then,
  ) = _$SlideContentCopyWithImpl<$Res, SlideContent>;
  @useResult
  $Res call({
    @JsonKey(name: 'page_num') int pageNum,
    String title,
    String content,
    List<String>? images,
  });
}

/// @nodoc
class _$SlideContentCopyWithImpl<$Res, $Val extends SlideContent>
    implements $SlideContentCopyWith<$Res> {
  _$SlideContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SlideContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNum = null,
    Object? title = null,
    Object? content = null,
    Object? images = freezed,
  }) {
    return _then(
      _value.copyWith(
            pageNum:
                null == pageNum
                    ? _value.pageNum
                    : pageNum // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            images:
                freezed == images
                    ? _value.images
                    : images // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SlideContentImplCopyWith<$Res>
    implements $SlideContentCopyWith<$Res> {
  factory _$$SlideContentImplCopyWith(
    _$SlideContentImpl value,
    $Res Function(_$SlideContentImpl) then,
  ) = __$$SlideContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'page_num') int pageNum,
    String title,
    String content,
    List<String>? images,
  });
}

/// @nodoc
class __$$SlideContentImplCopyWithImpl<$Res>
    extends _$SlideContentCopyWithImpl<$Res, _$SlideContentImpl>
    implements _$$SlideContentImplCopyWith<$Res> {
  __$$SlideContentImplCopyWithImpl(
    _$SlideContentImpl _value,
    $Res Function(_$SlideContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SlideContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNum = null,
    Object? title = null,
    Object? content = null,
    Object? images = freezed,
  }) {
    return _then(
      _$SlideContentImpl(
        pageNum:
            null == pageNum
                ? _value.pageNum
                : pageNum // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        images:
            freezed == images
                ? _value._images
                : images // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SlideContentImpl implements _SlideContent {
  const _$SlideContentImpl({
    @JsonKey(name: 'page_num') required this.pageNum,
    required this.title,
    required this.content,
    final List<String>? images,
  }) : _images = images;

  factory _$SlideContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlideContentImplFromJson(json);

  @override
  @JsonKey(name: 'page_num')
  final int pageNum;
  @override
  final String title;
  @override
  final String content;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SlideContent(pageNum: $pageNum, title: $title, content: $content, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideContentImpl &&
            (identical(other.pageNum, pageNum) || other.pageNum == pageNum) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pageNum,
    title,
    content,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of SlideContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideContentImplCopyWith<_$SlideContentImpl> get copyWith =>
      __$$SlideContentImplCopyWithImpl<_$SlideContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlideContentImplToJson(this);
  }
}

abstract class _SlideContent implements SlideContent {
  const factory _SlideContent({
    @JsonKey(name: 'page_num') required final int pageNum,
    required final String title,
    required final String content,
    final List<String>? images,
  }) = _$SlideContentImpl;

  factory _SlideContent.fromJson(Map<String, dynamic> json) =
      _$SlideContentImpl.fromJson;

  @override
  @JsonKey(name: 'page_num')
  int get pageNum;
  @override
  String get title;
  @override
  String get content;
  @override
  List<String>? get images;

  /// Create a copy of SlideContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlideContentImplCopyWith<_$SlideContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
