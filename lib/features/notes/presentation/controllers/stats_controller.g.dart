// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatsController on _StatsController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_StatsController.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_StatsController.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$totalNotesAtom = Atom(
    name: '_StatsController.totalNotes',
    context: context,
  );

  @override
  int get totalNotes {
    _$totalNotesAtom.reportRead();
    return super.totalNotes;
  }

  @override
  set totalNotes(int value) {
    _$totalNotesAtom.reportWrite(value, super.totalNotes, () {
      super.totalNotes = value;
    });
  }

  late final _$totalCharsAtom = Atom(
    name: '_StatsController.totalChars',
    context: context,
  );

  @override
  int get totalChars {
    _$totalCharsAtom.reportRead();
    return super.totalChars;
  }

  @override
  set totalChars(int value) {
    _$totalCharsAtom.reportWrite(value, super.totalChars, () {
      super.totalChars = value;
    });
  }

  late final _$totalLinesAtom = Atom(
    name: '_StatsController.totalLines',
    context: context,
  );

  @override
  int get totalLines {
    _$totalLinesAtom.reportRead();
    return super.totalLines;
  }

  @override
  set totalLines(int value) {
    _$totalLinesAtom.reportWrite(value, super.totalLines, () {
      super.totalLines = value;
    });
  }

  late final _$totalEditsAtom = Atom(
    name: '_StatsController.totalEdits',
    context: context,
  );

  @override
  int get totalEdits {
    _$totalEditsAtom.reportRead();
    return super.totalEdits;
  }

  @override
  set totalEdits(int value) {
    _$totalEditsAtom.reportWrite(value, super.totalEdits, () {
      super.totalEdits = value;
    });
  }

  late final _$totalLettersAtom = Atom(
    name: '_StatsController.totalLetters',
    context: context,
  );

  @override
  int get totalLetters {
    _$totalLettersAtom.reportRead();
    return super.totalLetters;
  }

  @override
  set totalLetters(int value) {
    _$totalLettersAtom.reportWrite(value, super.totalLetters, () {
      super.totalLetters = value;
    });
  }

  late final _$totalDigitsAtom = Atom(
    name: '_StatsController.totalDigits',
    context: context,
  );

  @override
  int get totalDigits {
    _$totalDigitsAtom.reportRead();
    return super.totalDigits;
  }

  @override
  set totalDigits(int value) {
    _$totalDigitsAtom.reportWrite(value, super.totalDigits, () {
      super.totalDigits = value;
    });
  }

  late final _$letterFrequencyAtom = Atom(
    name: '_StatsController.letterFrequency',
    context: context,
  );

  @override
  ObservableMap<String, int> get letterFrequency {
    _$letterFrequencyAtom.reportRead();
    return super.letterFrequency;
  }

  @override
  set letterFrequency(ObservableMap<String, int> value) {
    _$letterFrequencyAtom.reportWrite(value, super.letterFrequency, () {
      super.letterFrequency = value;
    });
  }

  late final _$digitFrequencyAtom = Atom(
    name: '_StatsController.digitFrequency',
    context: context,
  );

  @override
  ObservableMap<String, int> get digitFrequency {
    _$digitFrequencyAtom.reportRead();
    return super.digitFrequency;
  }

  @override
  set digitFrequency(ObservableMap<String, int> value) {
    _$digitFrequencyAtom.reportWrite(value, super.digitFrequency, () {
      super.digitFrequency = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_StatsController.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
totalNotes: ${totalNotes},
totalChars: ${totalChars},
totalLines: ${totalLines},
totalEdits: ${totalEdits},
totalLetters: ${totalLetters},
totalDigits: ${totalDigits},
letterFrequency: ${letterFrequency},
digitFrequency: ${digitFrequency}
    ''';
  }
}
