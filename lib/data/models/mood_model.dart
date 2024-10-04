
class MoodModel {
  final int? id;
  final int? userId;
  final int level;
  final DateTime createdAt;

  MoodModel({this.id, this.userId, required this.level, required this.createdAt});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'level': level,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['id'],
      userId: json['userId'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

Map<String, dynamic> toJsonRequest() {
    return {
      'id': id.toString(),
      'userId': userId.toString(),
      'level': level.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

}
