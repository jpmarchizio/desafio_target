// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeController, Store {
  late final _$notesAtom = Atom(
    name: '_HomeController.notes',
    context: context,
  );

  @override
  ObservableList<NoteModel> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<NoteModel> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_HomeController.errorMessage',
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

  late final _$isLoadingAtom = Atom(
    name: '_HomeController.isLoading',
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

  late final _$isLoggedInAtom = Atom(
    name: '_HomeController.isLoggedIn',
    context: context,
  );

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$loadNotesAsyncAction = AsyncAction(
    '_HomeController.loadNotes',
    context: context,
  );

  @override
  Future<void> loadNotes() {
    return _$loadNotesAsyncAction.run(() => super.loadNotes());
  }

  late final _$addNoteAsyncAction = AsyncAction(
    '_HomeController.addNote',
    context: context,
  );

  @override
  Future<void> addNote(String? title, String content) {
    return _$addNoteAsyncAction.run(() => super.addNote(title, content));
  }

  late final _$editNoteAsyncAction = AsyncAction(
    '_HomeController.editNote',
    context: context,
  );

  @override
  Future<void> editNote(NoteModel note, String? title, String content) {
    return _$editNoteAsyncAction.run(
      () => super.editNote(note, title, content),
    );
  }

  late final _$deleteNoteAsyncAction = AsyncAction(
    '_HomeController.deleteNote',
    context: context,
  );

  @override
  Future<void> deleteNote(String id) {
    return _$deleteNoteAsyncAction.run(() => super.deleteNote(id));
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_HomeController.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
notes: ${notes},
errorMessage: ${errorMessage},
isLoading: ${isLoading},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
