import 'package:tasky/features/create_edit_task/data/models/task_model.dart';

const String fontFamily = 'DM Sans';
List<String> filterList = const ['All', 'InProgress', 'Waiting', 'Finished'];
List<String> experienceLevelList = const [
  'fresh',
  'junior',
  'midLevel',
  'senior'
];


const String expLevelParam = 'Choose experience Level';
const String accessTokenParam = 'accessToken';
const String refreshTokenParam = 'refreshToken';

TaskModel fakeTaskModel = TaskModel.fromJson(
  {
    'title': 'BLLALALALALAL',
    'desc': 'BLLALALALALALBlalalallalalla',
    'priority': 'Blala',
    'image':
        'https://4.bp.blogspot.com/-TeAdCJ9bWbg/WAYPHUoaZsI/AAAAAAAAAcM/D5-34biNdNMm7LvY88pdm9mkIIiVS-QWACLcB/s1600/To-do-list.jpg',
    'status': 'Blalalal',
    'createdAt': '${DateTime.now().timeZoneOffset}',
  },
);
