import 'dart:convert';

class TaskModel {
  String title;
  String status;
  DateTime cearetedAt;
  int taskId;
  TaskModel({
    required this.title,
    required this.status,
    required this.cearetedAt,
    required this.taskId,
  });
  
    TaskModel copyWith({
    String? title,
    String? status,
    DateTime? cearetedAt,
    int? taskId,
  }) {
    return TaskModel(
      title: title ?? this.title,
      status: status ?? this.status,
      cearetedAt: cearetedAt ?? this.cearetedAt,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'status': status,
      'cearetedAt': cearetedAt.millisecondsSinceEpoch,
      'taskId': taskId,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      status: map['status'] as String,
      cearetedAt: DateTime.fromMillisecondsSinceEpoch(map['cearetedAt'] as int),
      taskId: map['taskId'] as int,
    );
  }
 
  @override
  String toString() {
    return 'TaskModel(title: $title, status: $status, cearetedAt: $cearetedAt, taskId: $taskId)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.status == status &&
      other.cearetedAt == cearetedAt &&
      other.taskId == taskId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      status.hashCode ^
      cearetedAt.hashCode ^
      taskId.hashCode;
  }
}
