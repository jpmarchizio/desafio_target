import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.readString(),
      title: reader.readBool() ? reader.readString() : null,
      content: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.id);
    writer.writeBool(obj.title != null);
    if (obj.title != null) writer.writeString(obj.title!);
    writer.writeString(obj.content);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
