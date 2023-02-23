// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Last Payments`
  String get last_payments {
    return Intl.message(
      'Last Payments',
      name: 'last_payments',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `exit`
  String get exit {
    return Intl.message(
      'exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Call Helping Center`
  String get call_helping_center {
    return Intl.message(
      'Call Helping Center',
      name: 'call_helping_center',
      desc: '',
      args: [],
    );
  }

  /// `Edit Personal Info`
  String get edit_personal_info {
    return Intl.message(
      'Edit Personal Info',
      name: 'edit_personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiaries`
  String get beneficiaries {
    return Intl.message(
      'Beneficiaries',
      name: 'beneficiaries',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Subscription number`
  String get sub_no {
    return Intl.message(
      'Subscription number',
      name: 'sub_no',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get pay_method {
    return Intl.message(
      'Payment Method',
      name: 'pay_method',
      desc: '',
      args: [],
    );
  }

  /// `Subscription State`
  String get sub_state {
    return Intl.message(
      'Subscription State',
      name: 'sub_state',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Medical File`
  String get med_file {
    return Intl.message(
      'Medical File',
      name: 'med_file',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Therapeutic Plan`
  String get treatment_plan {
    return Intl.message(
      'Therapeutic Plan',
      name: 'treatment_plan',
      desc: '',
      args: [],
    );
  }

  /// `Therapeutic Plans`
  String get treatment_plans {
    return Intl.message(
      'Therapeutic Plans',
      name: 'treatment_plans',
      desc: '',
      args: [],
    );
  }

  /// `Assessments Questions`
  String get reviews {
    return Intl.message(
      'Assessments Questions',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `I can`
  String get can {
    return Intl.message(
      'I can',
      name: 'can',
      desc: '',
      args: [],
    );
  }

  /// `I can't`
  String get cant {
    return Intl.message(
      'I can\'t',
      name: 'cant',
      desc: '',
      args: [],
    );
  }

  /// `SomeTimes`
  String get sometimes {
    return Intl.message(
      'SomeTimes',
      name: 'sometimes',
      desc: '',
      args: [],
    );
  }

  /// `Therapeutic Session`
  String get treatment_session {
    return Intl.message(
      'Therapeutic Session',
      name: 'treatment_session',
      desc: '',
      args: [],
    );
  }

  /// `Therapeutic Sessions`
  String get treatment_sessions {
    return Intl.message(
      'Therapeutic Sessions',
      name: 'treatment_sessions',
      desc: '',
      args: [],
    );
  }

  /// `Assessments Videos`
  String get videos {
    return Intl.message(
      'Assessments Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Assessments Video`
  String get video {
    return Intl.message(
      'Assessments Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Subscription is valid until`
  String get sub_valid {
    return Intl.message(
      'Subscription is valid until',
      name: 'sub_valid',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Renewal`
  String get renew_sub {
    return Intl.message(
      'Subscription Renewal',
      name: 'renew_sub',
      desc: '',
      args: [],
    );
  }

  /// `Operation Success`
  String get success {
    return Intl.message(
      'Operation Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Operation Error`
  String get error {
    return Intl.message(
      'Operation Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Card Info`
  String get card_info {
    return Intl.message(
      'Card Info',
      name: 'card_info',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_no {
    return Intl.message(
      'Card Number',
      name: 'card_no',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get card_holder {
    return Intl.message(
      'Card Holder Name',
      name: 'card_holder',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get pay_now {
    return Intl.message(
      'Pay Now',
      name: 'pay_now',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary Name`
  String get ben_name {
    return Intl.message(
      'Beneficiary Name',
      name: 'ben_name',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth`
  String get dob {
    return Intl.message(
      'Date Of Birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Medical Condition`
  String get medical_condition {
    return Intl.message(
      'Medical Condition',
      name: 'medical_condition',
      desc: '',
      args: [],
    );
  }

  /// `Attach Medical Reports`
  String get attach_medical_reports {
    return Intl.message(
      'Attach Medical Reports',
      name: 'attach_medical_reports',
      desc: '',
      args: [],
    );
  }

  /// `Add Beneficiary`
  String get add_ben {
    return Intl.message(
      'Add Beneficiary',
      name: 'add_ben',
      desc: '',
      args: [],
    );
  }

  /// `You Have No Beneficiaries`
  String get no_ben {
    return Intl.message(
      'You Have No Beneficiaries',
      name: 'no_ben',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_pass {
    return Intl.message(
      'Reset Password',
      name: 'reset_pass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_pass {
    return Intl.message(
      'New Password',
      name: 'new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Retype The Password`
  String get r_pass {
    return Intl.message(
      'Retype The Password',
      name: 'r_pass',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get reg {
    return Intl.message(
      'Register',
      name: 'reg',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account?`
  String get already_have_account {
    return Intl.message(
      'Already Have Account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Code`
  String get confirm_code {
    return Intl.message(
      'Confirm Code',
      name: 'confirm_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm Code`
  String get enterCC {
    return Intl.message(
      'Enter Confirm Code',
      name: 'enterCC',
      desc: '',
      args: [],
    );
  }

  /// `Confirm code that you received in sms`
  String get desCC {
    return Intl.message(
      'Confirm code that you received in sms',
      name: 'desCC',
      desc: '',
      args: [],
    );
  }

  /// `Resend confirm code`
  String get reCC {
    return Intl.message(
      'Resend confirm code',
      name: 'reCC',
      desc: '',
      args: [],
    );
  }

  /// `Do you have problem with confirm code\ncall for help`
  String get pCC {
    return Intl.message(
      'Do you have problem with confirm code\ncall for help',
      name: 'pCC',
      desc: '',
      args: [],
    );
  }

  /// `Do you forget the password ?`
  String get forgetP {
    return Intl.message(
      'Do you forget the password ?',
      name: 'forgetP',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account ?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have account ?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Please connect to network !`
  String get network_error {
    return Intl.message(
      'Please connect to network !',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Password is less than`
  String get password_is_less {
    return Intl.message(
      'Password is less than',
      name: 'password_is_less',
      desc: '',
      args: [],
    );
  }

  /// `Phone/Password is wrong`
  String get errorAuth {
    return Intl.message(
      'Phone/Password is wrong',
      name: 'errorAuth',
      desc: '',
      args: [],
    );
  }

  /// `Exists`
  String get exists {
    return Intl.message(
      'Exists',
      name: 'exists',
      desc: '',
      args: [],
    );
  }

  /// `Wrong`
  String get wrong {
    return Intl.message(
      'Wrong',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `is not valid`
  String get notValid {
    return Intl.message(
      'is not valid',
      name: 'notValid',
      desc: '',
      args: [],
    );
  }

  /// `is more than`
  String get more {
    return Intl.message(
      'is more than',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `is less than`
  String get less {
    return Intl.message(
      'is less than',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `characters`
  String get char {
    return Intl.message(
      'characters',
      name: 'char',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personal_info {
    return Intl.message(
      'Personal Info',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Select Beneficiary`
  String get select_ben {
    return Intl.message(
      'Select Beneficiary',
      name: 'select_ben',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Retype the password`
  String get retype_new_password {
    return Intl.message(
      'Retype the password',
      name: 'retype_new_password',
      desc: '',
      args: [],
    );
  }

  /// `AED`
  String get aed {
    return Intl.message(
      'AED',
      name: 'aed',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Are u sure ?`
  String get confirm {
    return Intl.message(
      'Are u sure ?',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Card Number is not valid`
  String get card_no_not_valid {
    return Intl.message(
      'Card Number is not valid',
      name: 'card_no_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder name is not valid`
  String get card_holder_name_is_not_valid {
    return Intl.message(
      'Card Holder name is not valid',
      name: 'card_holder_name_is_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Passwords does not match`
  String get not_equal {
    return Intl.message(
      'Passwords does not match',
      name: 'not_equal',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get attachment {
    return Intl.message(
      'Attachment',
      name: 'attachment',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `File Path`
  String get path {
    return Intl.message(
      'File Path',
      name: 'path',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Tap the image above to change photo`
  String get image_tutorial {
    return Intl.message(
      'Tap the image above to change photo',
      name: 'image_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Downloading`
  String get downloading {
    return Intl.message(
      'Downloading',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Saved in Download Folder`
  String get saved_file {
    return Intl.message(
      'Saved in Download Folder',
      name: 'saved_file',
      desc: '',
      args: [],
    );
  }

  /// `Please Give Permission !`
  String get permissions {
    return Intl.message(
      'Please Give Permission !',
      name: 'permissions',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Not valid`
  String get not_valid2 {
    return Intl.message(
      'Not valid',
      name: 'not_valid2',
      desc: '',
      args: [],
    );
  }

  /// `Please select medical case`
  String get please_select_major {
    return Intl.message(
      'Please select medical case',
      name: 'please_select_major',
      desc: '',
      args: [],
    );
  }

  /// `Added Beneficiary you can pay now`
  String get added_ben {
    return Intl.message(
      'Added Beneficiary you can pay now',
      name: 'added_ben',
      desc: '',
      args: [],
    );
  }

  /// `View Medical file`
  String get view_med {
    return Intl.message(
      'View Medical file',
      name: 'view_med',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Beneficiary`
  String get please_select_ben {
    return Intl.message(
      'Please Select Beneficiary',
      name: 'please_select_ben',
      desc: '',
      args: [],
    );
  }

  /// `There are no videos`
  String get there_are_no_videos {
    return Intl.message(
      'There are no videos',
      name: 'there_are_no_videos',
      desc: '',
      args: [],
    );
  }

  /// `There are no Plan`
  String get there_are_no_plan {
    return Intl.message(
      'There are no Plan',
      name: 'there_are_no_plan',
      desc: '',
      args: [],
    );
  }

  /// `Choose Video`
  String get choice_video {
    return Intl.message(
      'Choose Video',
      name: 'choice_video',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get upload_video {
    return Intl.message(
      'Upload Video',
      name: 'upload_video',
      desc: '',
      args: [],
    );
  }

  /// `No data can be presented`
  String get no_data {
    return Intl.message(
      'No data can be presented',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose Video`
  String get please_choice_video {
    return Intl.message(
      'Please Choose Video',
      name: 'please_choice_video',
      desc: '',
      args: [],
    );
  }

  /// `Sending : `
  String get sending {
    return Intl.message(
      'Sending : ',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `Total : `
  String get total_upload {
    return Intl.message(
      'Total : ',
      name: 'total_upload',
      desc: '',
      args: [],
    );
  }

  /// `presenting : `
  String get presenting {
    return Intl.message(
      'presenting : ',
      name: 'presenting',
      desc: '',
      args: [],
    );
  }

  /// `Video Type should be mp4 , mov , 3gp , mpeg`
  String get not_supported_video {
    return Intl.message(
      'Video Type should be mp4 , mov , 3gp , mpeg',
      name: 'not_supported_video',
      desc: '',
      args: [],
    );
  }

  /// `Uploading...`
  String get uploading {
    return Intl.message(
      'Uploading...',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Please don't close the app !`
  String get keep_the_app_open {
    return Intl.message(
      'Please don\'t close the app !',
      name: 'keep_the_app_open',
      desc: '',
      args: [],
    );
  }

  /// `Close this screen will stop the upload task`
  String get close_this_screen {
    return Intl.message(
      'Close this screen will stop the upload task',
      name: 'close_this_screen',
      desc: '',
      args: [],
    );
  }

  /// `We Have Some problems please try again later .`
  String get temp_error {
    return Intl.message(
      'We Have Some problems please try again later .',
      name: 'temp_error',
      desc: '',
      args: [],
    );
  }

  /// `record date`
  String get sub_date {
    return Intl.message(
      'record date',
      name: 'sub_date',
      desc: '',
      args: [],
    );
  }

  /// `require date`
  String get req_date {
    return Intl.message(
      'require date',
      name: 'req_date',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `currently no medical file for this beneficiary.`
  String get noMedical {
    return Intl.message(
      'currently no medical file for this beneficiary.',
      name: 'noMedical',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
