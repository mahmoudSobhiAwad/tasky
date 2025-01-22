class CreateEditTaskModel {
  String? imagePath;
  String title;
  String? desc;
  String priority;
  String dueDate;
  CreateEditTaskModel(
      {required this.title,
      required this.dueDate,
      required this.priority,
      this.imagePath,
      this.desc});
  Map<String, dynamic> toJson() {
    return {
      if (imagePath != null) "image": imagePath,
      "title": title,
      if (desc != null) "desc": desc,
      "priority": priority,
      "dueDate": dueDate,
    };
  }
}
