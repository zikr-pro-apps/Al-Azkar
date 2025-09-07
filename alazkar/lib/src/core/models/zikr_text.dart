import 'dart:convert';
import 'package:alazkar/src/core/models/zikr_text_type.dart';
import 'package:equatable/equatable.dart';

class ZikrText extends Equatable {
  final int id;
  final int zikrId;
  final int textOrder;
  final String text;
  final ZikrTextType type;
  final String attachment;

  const ZikrText({
    required this.id,
    required this.zikrId,
    required this.textOrder,
    required this.text,
    required this.type,
    required this.attachment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zikrId': zikrId,
      'textOrder': textOrder,
      'text': text,
      'type': type,
      'attachment': attachment,
    };
  }

  factory ZikrText.fromMap(Map<String, dynamic> map) {
    return ZikrText(
      id: map['id'] as int,
      zikrId: map['zikrId'] as int,
      textOrder: map['textOrder'] as int,
      text: map['text'] as String,
      type: ZikrTextType.fromString(map['type'] as String),
      attachment: (map['attachment'] as String?) ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ZikrText.fromJson(String source) =>
      ZikrText.fromMap(json.decode(source) as Map<String, dynamic>);

  ZikrText copyWith({
    int? id,
    int? titleId,
    int? subZikrId,
    String? text,
    ZikrTextType? type,
    String? attachment,
  }) {
    return ZikrText(
      id: id ?? this.id,
      zikrId: titleId ?? this.zikrId,
      textOrder: subZikrId ?? this.textOrder,
      text: text ?? this.text,
      type: type ?? this.type,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      zikrId,
      textOrder,
      text,
      type,
      attachment,
    ];
  }
}
