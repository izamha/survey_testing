import 'package:uuid/uuid.dart';

class AfIdentifier {
  final String id;
  AfIdentifier({String? id}) : id = id ?? const Uuid().v4();

  AfIdentifier.fromJson(Map<String, dynamic> json) : id = json['id'];
  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  bool operator ==(other) => other is AfIdentifier && other.id == id;
  @override
  int get hashCode => id.hashCode;
}
