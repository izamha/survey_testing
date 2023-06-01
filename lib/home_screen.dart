import 'package:flutter/material.dart';

import 'components/af_survey/models/af_question.dart';
import 'components/af_survey/models/af_question_result.dart';
import 'components/af_survey/widgets/af_survey.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  List<AfQuestionResult> _questionResults = [];

  final List<AfQuestion> _initialData = [
    AfQuestion(
      isMandatory: true,
      questionText: 'Do you like drinking coffee?',
      answerChoices: {
        "Yes": [
          AfQuestion(
              singleChoice: true,
              questionText: "What are the brands that you've tried?",
              answerChoices: {
                "Nestle": null,
                "Starbucks": null,
                "Coffee Day": [
                  AfQuestion(
                    questionText: "Did you enjoy visiting Coffee Day?",
                    isMandatory: true,
                    answerChoices: {
                      "Yes": [
                        AfQuestion(
                          questionText: "Please tell us why you like it",
                        )
                      ],
                      "No": [
                        AfQuestion(
                          questionText: "Please tell us what went wrong",
                        )
                      ],
                    },
                  )
                ],
              })
        ],
        "No": [
          AfQuestion(
            questionText: "Do you like drinking Tea then?",
            answerChoices: {
              "Yes": [
                AfQuestion(
                    singleChoice: false,
                    questionText: "What are the brands that you've tried?",
                    answerChoices: {
                      "Nestle": null,
                      "ChaiBucks": null,
                      "Indian Premium Tea": [
                        AfQuestion(
                          questionText: "Did you enjoy visiting IPT?",
                          answerChoices: {
                            "Yes": [
                              AfQuestion(
                                questionText: "Please tell us why you like it",
                              )
                            ],
                            "No": [
                              AfQuestion(
                                questionText: "Please tell us what went wrong",
                              )
                            ],
                          },
                        )
                      ],
                    })
              ],
              "No": null,
            },
          )
        ],
      },
    ),
    AfQuestion(
      questionText: "What age group do you fall in?",
      isMandatory: false,
      answerChoices: const {
        "18-20": null,
        "20-30": null,
        "Greater than 30": null,
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: IntrinsicHeight(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: AfSurvey(
                onNext: (questionResults) {
                  _questionResults = questionResults;
                },
                initialData: _initialData,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text("Validate"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Do something
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
