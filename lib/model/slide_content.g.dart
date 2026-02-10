// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlideContentImpl _$$SlideContentImplFromJson(Map<String, dynamic> json) =>
    _$SlideContentImpl(
      pageNum: (json['page_num'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isMd: json['isMd'] as bool? ?? false,
      isRow: json['isRow'] as bool?,
    );

Map<String, dynamic> _$$SlideContentImplToJson(_$SlideContentImpl instance) =>
    <String, dynamic>{
      'page_num': instance.pageNum,
      'title': instance.title,
      'content': instance.content,
      'images': instance.images,
      'isMd': instance.isMd,
      'isRow': instance.isRow,
    };
