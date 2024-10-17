// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String title;
  DateTime cearetedAt;
  
  TaskModel({
    required this.title,
    required this.cearetedAt,
  });

  TaskModel copyWith({
    String? title,
    DateTime? cearetedAt,
  }) {
    return TaskModel(
      title: title ?? this.title,
      cearetedAt: cearetedAt ?? this.cearetedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'cearetedAt': cearetedAt.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      cearetedAt: DateTime.fromMillisecondsSinceEpoch(map['cearetedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(title: $title, cearetedAt: $cearetedAt)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.cearetedAt == cearetedAt;
  }

  @override
  int get hashCode => title.hashCode ^ cearetedAt.hashCode;
}
