import 'package:get/get.dart';
import 'package:noproxy/components/controller/Db/Db_helper.dart';
import 'package:noproxy/models/task.dart';

class TaskController extends GetxController {
  Future<int> addtask({Task? task}) async {
    return await DbHelper.insert(task);
  }
}
