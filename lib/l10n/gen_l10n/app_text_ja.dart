// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_text.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppTextJa extends AppText {
  AppTextJa([String locale = 'ja']) : super(locale);

  @override
  String get myTasks => 'マイタスク';

  @override
  String get newTask => '新規タスク';

  @override
  String get subtasks => 'サブタスク';

  @override
  String get taskName => 'タスク名';

  @override
  String get taskScore => 'タスクスコア';

  @override
  String get selectDate => '日付選択';

  @override
  String get addSubtask => 'サブタスクの追加';

  @override
  String get editTask => 'タスク編集';

  @override
  String get percent => '%';

  @override
  String comparisonToLastweek(Object change, Object gap) {
    return '先週より$gap%$change';
  }

  @override
  String get tasksInProgress => '進行中のタスク';

  @override
  String get deadline => '締切';

  @override
  String get month => '月';

  @override
  String get date => '日';

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get yesterday => '昨日';

  @override
  String get completedTasks => '完了済みタスク';

  @override
  String get completed => '完了';

  @override
  String get weeklyProgress => '週間達成状況';

  @override
  String get monday => '月';

  @override
  String get tuesday => '火';

  @override
  String get wednesday => '水';

  @override
  String get thursday => '木';

  @override
  String get friday => '金';

  @override
  String get saturday => '土';

  @override
  String get sunday => '日';
}
