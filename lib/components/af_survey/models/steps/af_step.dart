import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_testing/components/af_survey/exceptions/step_not_defined_exception.dart';
import 'package:survey_testing/components/af_survey/models/af_question_result.dart';
import 'package:survey_testing/components/af_survey/models/identifier/af_step_identifier.dart';

abstract class AfStep {
  final AfStepIdentifier stepIdentifier;
  @JsonKey(defaultValue: false)
  final bool isOptional;
  @JsonKey(defaultValue: 'Next')
  final String? buttonText;
  final bool canGoBack;
  final bool showProgress;
  final bool showAppBar;

  AfStep({
    AfStepIdentifier? stepIdentifier,
    this.isOptional = false,
    this.buttonText = 'Next',
    this.canGoBack = true,
    this.showProgress = true,
    this.showAppBar = true,
  }) : stepIdentifier = stepIdentifier ?? AfStepIdentifier();

  Widget createView({required AfQuestionResult? questionResult});

  factory AfStep.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == 'intro') {
      // InstructionStep
    } else if (type == 'question') {
      // QuestionStep
    } else if (type == 'completion') {
      // CompletionStep
    }
    throw const AfStepNotDefinedException();
  }

  Map<String, dynamic> toJson();

  @override
  bool operator ==(other) =>
      other is AfStep &&
      other.stepIdentifier == stepIdentifier &&
      other.isOptional == isOptional &&
      other.buttonText == buttonText;
  @override
  int get hashCode =>
      stepIdentifier.hashCode ^ isOptional.hashCode ^ buttonText.hashCode;
}
