import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_text_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppText
/// returned by `AppText.of(context)`.
///
/// Applications need to include `AppText.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_text.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppText.localizationsDelegates,
///   supportedLocales: AppText.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppText.supportedLocales
/// property.
abstract class AppText {
  AppText(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppText? of(BuildContext context) {
    return Localizations.of<AppText>(context, AppText);
  }

  static const LocalizationsDelegate<AppText> delegate = _AppTextDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ja')
  ];

  /// No description provided for @myTasks.
  ///
  /// In ja, this message translates to:
  /// **'マイタスク'**
  String get myTasks;

  /// No description provided for @newTask.
  ///
  /// In ja, this message translates to:
  /// **'新規タスク'**
  String get newTask;

  /// No description provided for @subtasks.
  ///
  /// In ja, this message translates to:
  /// **'サブタスク'**
  String get subtasks;

  /// No description provided for @taskName.
  ///
  /// In ja, this message translates to:
  /// **'タスク名'**
  String get taskName;

  /// No description provided for @taskScore.
  ///
  /// In ja, this message translates to:
  /// **'タスクスコア'**
  String get taskScore;

  /// No description provided for @selectDate.
  ///
  /// In ja, this message translates to:
  /// **'日付選択'**
  String get selectDate;

  /// No description provided for @addSubtask.
  ///
  /// In ja, this message translates to:
  /// **'サブタスクの追加'**
  String get addSubtask;

  /// No description provided for @editTask.
  ///
  /// In ja, this message translates to:
  /// **'タスク編集'**
  String get editTask;

  /// No description provided for @percent.
  ///
  /// In ja, this message translates to:
  /// **'%'**
  String get percent;

  /// No description provided for @comparisonToLastweek.
  ///
  /// In ja, this message translates to:
  /// **'先週より{gap}%{change}'**
  String comparisonToLastweek(Object change, Object gap);

  /// No description provided for @tasksInProgress.
  ///
  /// In ja, this message translates to:
  /// **'進行中のタスク'**
  String get tasksInProgress;

  /// No description provided for @deadline.
  ///
  /// In ja, this message translates to:
  /// **'締切'**
  String get deadline;

  /// No description provided for @month.
  ///
  /// In ja, this message translates to:
  /// **'月'**
  String get month;

  /// No description provided for @date.
  ///
  /// In ja, this message translates to:
  /// **'日'**
  String get date;

  /// No description provided for @today.
  ///
  /// In ja, this message translates to:
  /// **'今日'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In ja, this message translates to:
  /// **'明日'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In ja, this message translates to:
  /// **'昨日'**
  String get yesterday;

  /// No description provided for @completedTasks.
  ///
  /// In ja, this message translates to:
  /// **'完了済みタスク'**
  String get completedTasks;

  /// No description provided for @completed.
  ///
  /// In ja, this message translates to:
  /// **'完了'**
  String get completed;

  /// No description provided for @weeklyProgress.
  ///
  /// In ja, this message translates to:
  /// **'週間達成状況'**
  String get weeklyProgress;

  /// No description provided for @monday.
  ///
  /// In ja, this message translates to:
  /// **'月'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In ja, this message translates to:
  /// **'火'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In ja, this message translates to:
  /// **'水'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In ja, this message translates to:
  /// **'木'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In ja, this message translates to:
  /// **'金'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In ja, this message translates to:
  /// **'土'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In ja, this message translates to:
  /// **'日'**
  String get sunday;
}

class _AppTextDelegate extends LocalizationsDelegate<AppText> {
  const _AppTextDelegate();

  @override
  Future<AppText> load(Locale locale) {
    return SynchronousFuture<AppText>(lookupAppText(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppTextDelegate old) => false;
}

AppText lookupAppText(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ja': return AppTextJa();
  }

  throw FlutterError(
    'AppText.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
