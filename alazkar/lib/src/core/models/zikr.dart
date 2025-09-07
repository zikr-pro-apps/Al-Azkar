// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alazkar/src/core/models/zikr_text.dart';
import 'package:equatable/equatable.dart';

class Zikr extends Equatable {
  final int id;
  final int titleId;
  final int order;
  final List<ZikrText> body;
  final String source;
  final String fadl;
  final int count;
  final String footnote;

  const Zikr({
    required this.id,
    required this.titleId,
    required this.order,
    required this.body,
    required this.source,
    required this.fadl,
    required this.count,
    required this.footnote,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleId': titleId,
      'order': order,
      'body': body,
      'source': source,
      'fadl': fadl,
      'count': count,
      'footnote': footnote,
    };
  }

  factory Zikr.fromMap(Map<String, dynamic> map, List<ZikrText> zikrText) {
    return Zikr(
      id: map['id'] as int,
      titleId: map['titleId'] as int,
      order: map['order'] as int,
      body: zikrText,
      source: (map['source'] as String?) ?? "",
      fadl: (map['fadl'] as String?) ?? "",
      count: map['count'] as int,
      footnote: (map['footnote'] as String?) ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Zikr.fromJson(String source, List<ZikrText> zikrText) => Zikr.fromMap(
        json.decode(source) as Map<String, dynamic>,
        zikrText,
      );

  Zikr copyWith({
    int? id,
    int? titleId,
    int? order,
    List<ZikrText>? body,
    String? source,
    String? fadl,
    int? count,
    String? footnote,
  }) {
    return Zikr(
      id: id ?? this.id,
      titleId: titleId ?? this.titleId,
      order: order ?? this.order,
      body: body ?? this.body,
      source: source ?? this.source,
      fadl: fadl ?? this.fadl,
      count: count ?? this.count,
      footnote: footnote ?? this.footnote,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      titleId,
      order,
      body,
      source,
      count,
      fadl,
      footnote,
    ];
  }

  String get fullText {
    return body.map((t) => t.text).join("\n");
  }

  String get fullSource {
    return body
        .map((t) => t.attachment)
        .where((attachment) => attachment.isNotEmpty)
        .join(", ");
  }
}
