import 'package:freezed_annotation/freezed_annotation.dart';

part 'slide_content.freezed.dart';
part 'slide_content.g.dart';

@freezed
class SlideContent with _$SlideContent {
  const factory SlideContent({
    @JsonKey(name: 'page_num') required int pageNum,
    required String title,
    required String content,
    List<String>? images,
  }) = _SlideContent;

  factory SlideContent.fromJson(Map<String, dynamic> json) =>
      _$SlideContentFromJson(json);
}
