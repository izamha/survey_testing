import 'package:survey_testing/components/af_survey/models/identifier/af_identifier.dart';

class AfStepIdentifier extends AfIdentifier {
  AfStepIdentifier({String? id}) : super(id: id);

  // AfStepIdentifier.fromJson(Map<String, dynamic> json) : id = json['id'];
  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  bool operator ==(other) => other is AfStepIdentifier && id == other.id;
  @override
  int get hashCode => id.hashCode;
}
