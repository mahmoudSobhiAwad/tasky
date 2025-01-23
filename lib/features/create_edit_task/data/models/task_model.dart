import 'package:intl/intl.dart';
import 'package:tasky/features/create_edit_task/data/models/image_model.dart';
import 'package:tasky/features/create_edit_task/data/models/priority_model.dart';
import 'package:tasky/features/create_edit_task/data/models/status_model.dart';

class TaskModel {
  final String? id;
  final ImageModel? imageModel;
  final String? title;
  final String? desc;
  final PriorityModel? priority;
  final StatusModel? status;
  final String? user;
  final String? createdAt;
  final String? updatedAt;

  TaskModel({
    this.id,
    this.imageModel,
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
      imageModel: ImageModel(
          imagePath:
              'https://todo.iraqsapp.com/images/${json['image'] as String?}',
          imageType: ImageType.network),
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      priority: pirorityList.firstWhere(
          (model) => model?.title == json['priority'] as String?,
          orElse: () => null),
      status: statusList.firstWhere(
          (item) => item?.title == json['status'] as String?,
          orElse: () => null),
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
        'image': imageModel?.imagePath?.split('/').last,
        'title': title,
        'desc': desc,
        'priority': priority?.title,
        'status': status?.title,
        'user': user,
      };
  TaskModel copyWith({
    final String? id,
    final ImageModel? imageModel,
    final String? title,
    final String? desc,
    final PriorityModel? priority,
    final StatusModel? status,
    final String? user,
    final String? createdAt,
    final String? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      imageModel: imageModel ?? this.imageModel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
