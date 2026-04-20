import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readBool() ? reader.readString() : null;
    final content = reader.readString();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final editCount = reader.availableBytes > 0 ? reader.readInt() : 0;
    return NoteModel(id: id, title: title, content: content, createdAt: createdAt, editCount: editCount);
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.id);
    writer.writeBool(obj.title != null);
    if (obj.title != null) writer.writeString(obj.title!);
    writer.writeString(obj.content);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.editCount);
  }
}
