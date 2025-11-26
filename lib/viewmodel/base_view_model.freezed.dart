// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppBarState {
  String get title => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get showBackButton => throw _privateConstructorUsedError;
  int get currentPageIndex => throw _privateConstructorUsedError;

  /// Create a copy of AppBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppBarStateCopyWith<AppBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBarStateCopyWith<$Res> {
  factory $AppBarStateCopyWith(
    AppBarState value,
    $Res Function(AppBarState) then,
  ) = _$AppBarStateCopyWithImpl<$Res, AppBarState>;
  @useResult
  $Res call({
    String title,
    bool isVisible,
    bool showBackButton,
    int currentPageIndex,
  });
}

/// @nodoc
class _$AppBarStateCopyWithImpl<$Res, $Val extends AppBarState>
    implements $AppBarStateCopyWith<$Res> {
  _$AppBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isVisible = null,
    Object? showBackButton = null,
    Object? currentPageIndex = null,
  }) {
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            isVisible:
                null == isVisible
                    ? _value.isVisible
                    : isVisible // ignore: cast_nullable_to_non_nullable
                        as bool,
            showBackButton:
                null == showBackButton
                    ? _value.showBackButton
                    : showBackButton // ignore: cast_nullable_to_non_nullable
                        as bool,
            currentPageIndex:
                null == currentPageIndex
                    ? _value.currentPageIndex
                    : currentPageIndex // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppBarStateImplCopyWith<$Res>
    implements $AppBarStateCopyWith<$Res> {
  factory _$$AppBarStateImplCopyWith(
    _$AppBarStateImpl value,
    $Res Function(_$AppBarStateImpl) then,
  ) = __$$AppBarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    bool isVisible,
    bool showBackButton,
    int currentPageIndex,
  });
}

/// @nodoc
class __$$AppBarStateImplCopyWithImpl<$Res>
    extends _$AppBarStateCopyWithImpl<$Res, _$AppBarStateImpl>
    implements _$$AppBarStateImplCopyWith<$Res> {
  __$$AppBarStateImplCopyWithImpl(
    _$AppBarStateImpl _value,
    $Res Function(_$AppBarStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isVisible = null,
    Object? showBackButton = null,
    Object? currentPageIndex = null,
  }) {
    return _then(
      _$AppBarStateImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        isVisible:
            null == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                    as bool,
        showBackButton:
            null == showBackButton
                ? _value.showBackButton
                : showBackButton // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentPageIndex:
            null == currentPageIndex
                ? _value.currentPageIndex
                : currentPageIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$AppBarStateImpl implements _AppBarState {
  const _$AppBarStateImpl({
    required this.title,
    this.isVisible = false,
    this.showBackButton = true,
    this.currentPageIndex = 0,
  });

  @override
  final String title;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool showBackButton;
  @override
  @JsonKey()
  final int currentPageIndex;

  @override
  String toString() {
    return 'AppBarState(title: $title, isVisible: $isVisible, showBackButton: $showBackButton, currentPageIndex: $currentPageIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBarStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.showBackButton, showBackButton) ||
                other.showBackButton == showBackButton) &&
            (identical(other.currentPageIndex, currentPageIndex) ||
                other.currentPageIndex == currentPageIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    isVisible,
    showBackButton,
    currentPageIndex,
  );

  /// Create a copy of AppBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBarStateImplCopyWith<_$AppBarStateImpl> get copyWith =>
      __$$AppBarStateImplCopyWithImpl<_$AppBarStateImpl>(this, _$identity);
}

abstract class _AppBarState implements AppBarState {
  const factory _AppBarState({
    required final String title,
    final bool isVisible,
    final bool showBackButton,
    final int currentPageIndex,
  }) = _$AppBarStateImpl;

  @override
  String get title;
  @override
  bool get isVisible;
  @override
  bool get showBackButton;
  @override
  int get currentPageIndex;

  /// Create a copy of AppBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppBarStateImplCopyWith<_$AppBarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
