// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoteController on _NoteController, Store {
  late final _$notesAtom = Atom(
    name: '_NoteController.notes',
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

  late final _$_NoteControllerActionController = ActionController(
    name: '_NoteController',
    context: context,
  );

  @override
  void addNote(String? title, String content) {
    final _$actionInfo = _$_NoteControllerActionController.startAction(
      name: '_NoteController.addNote',
    );
    try {
      return super.addNote(title, content);
    } finally {
      _$_NoteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editNote(NoteModel note, String? title, String content) {
    final _$actionInfo = _$_NoteControllerActionController.startAction(
      name: '_NoteController.editNote',
    );
    try {
      return super.editNote(note, title, content);
    } finally {
      _$_NoteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteNote(String id) {
    final _$actionInfo = _$_NoteControllerActionController.startAction(
      name: '_NoteController.deleteNote',
    );
    try {
      return super.deleteNote(id);
    } finally {
      _$_NoteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes}
    ''';
  }
}
