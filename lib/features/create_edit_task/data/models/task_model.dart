import 'package:intl/intl.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';

class TaskModel {
  final String? id;
  final String? image;
  final String? title;
  final String? desc;
  final PriorityModel? priority;
  final String? status;
  final String? user;
  final String? createdAt;
  final String? updatedAt;

  TaskModel({
    this.id,
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json['_id'] as String?,
      image: 'https://todo.iraqsapp.com/images/${json['image'] as String?}',
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      priority: pirorityList.firstWhere(
          (model) => model?.title == json['priority'] as String?,
          orElse: () => null),
      status: json['status'] as String?,
      user: json['user'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateFormat('yyyy-MM-dd').format(
              DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(json['updatedAt'] as String)));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'status': status,
        'user': user,
      };
}
