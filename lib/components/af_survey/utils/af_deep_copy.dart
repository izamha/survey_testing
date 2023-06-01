import 'package:survey_testing/components/af_survey/models/af_question.dart';

extension DeepCopy on AfQuestion {
  /// Returns a clone of the question and the reference
  AfQuestion clone() {
    return AfQuestion.fromJson(toJson());
  }
}
