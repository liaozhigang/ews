import 'package:test/test.dart';

import 'test_folder_crud.dart' as test_folder_crud;
import 'test_folder_hierarhy.dart' as test_folder_hierarhy;
import 'test_calendar_folder.dart' as test_calendar_folder;
import 'test_folder_permissions.dart' as test_folder_permissions;
import 'test_trace_logs.dart' as test_trace_logs;
import 'test_item_crud.dart' as test_item_crud;

void main() {
  group("folder crud", test_folder_crud.main);
  group("folder hierarhy", test_folder_hierarhy.main);
  group("calendar folder", test_calendar_folder.main);
  group("folder permissions", test_folder_permissions.main);
  group("trace logs", test_trace_logs.main);
  group("item crud", test_item_crud.main);
}
