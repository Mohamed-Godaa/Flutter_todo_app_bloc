// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

/// {@template todo}
/// A single todo item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Todo]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}

//@immutable

@JsonSerializable()
class Todo extends Equatable {
  Todo({
    String? id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id cannot be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  final String id; //Unique id cannot be empty or null
  final String title; //title (may be empty)
  final String description; //description (defaults to empty string)
  final bool isCompleted; // true if completed!

  Todo copyWith({
    String? id, //Unique id cannot be empty or null
    String? title, //title (may be empty)
    String? description, //description (defaults to empty string)
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

// Extracts a todo from Json
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;
