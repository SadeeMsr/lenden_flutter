import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getSampleTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      final json = queryResultToJson(result);
                      print(jsonEncode(json));
                      Navigator.pushNamed(context, '/');
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
                      primaryColor: Colors.cyan,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: const CupertinoThemeData(
                        primaryColor: Colors.cyan,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return const BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return const BorderSide(
                                color: Colors.cyan,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.grey,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.cyan,
                                  );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Colors.cyan,
                                ),
                          ),
                        ),
                      ),
                      textTheme: const TextTheme(
                        displayMedium: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headlineSmall: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        titleMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      )
                          .copyWith(
                            onPrimary: Colors.white,
                          )
                          .copyWith(background: Colors.white),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> queryResultToJson(SurveyResult result) {
    return <String, dynamic>{
      "finishReason": result.finishReason.name,
      "steps": result.results
          .map((step) => <String, dynamic>{
                "id": step.id?.id,
                "startDate": step.startDate.toIso8601String(),
                "endDate": step.endDate.toIso8601String(),
                "results": step.results
                    .map((r) => <String, dynamic>{
                          "id": r.id?.id,
                          "result": r.result is BooleanResult
                              ? ((r.result as BooleanResult) ==
                                      BooleanResult.POSITIVE
                                  ? true
                                  : (r.result as BooleanResult) ==
                                          BooleanResult.NEGATIVE
                                      ? false
                                      : null)
                              : r.result is TimeOfDay
                                  ? '${(r.result as TimeOfDay).hour}:${(r.result as TimeOfDay).minute}'
                                  : r.result is DateTime
                                      ? (r.result as DateTime).toIso8601String()
                                      : r.result,
                          "startDate": r.startDate.toIso8601String(),
                          "endDate": r.endDate.toIso8601String(),
                          "valueIdentifier": r.valueIdentifier,
                        })
                    .toList()
              })
          .toList()
    };
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to Lenden',
          text:
              'We\'d like to ask you some questions. Please be kind and patient',
          buttonText: 'Let\'s start!',
        ),
        QuestionStep(
          title: 'How many persons may be contacted for a reference?',
          text:
              'References in the context of job resumes/university post grad application/loan application',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'None', value: '0'),
              TextChoice(text: '1', value: '1'),
              TextChoice(text: '2', value: '2'),
              TextChoice(text: '3', value: '3'),
              TextChoice(text: '4', value: '4'),
              TextChoice(text: '5', value: '5'),
            ],
            defaultSelection: TextChoice(text: 'None', value: '0'),
          ),
        ),
        QuestionStep(
          text: 'How many bank accounts do you have?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: '0', value: '0'),
              TextChoice(text: '1', value: '1'),
              TextChoice(text: '2', value: '2'),
              TextChoice(text: '3', value: '3'),
              TextChoice(text: '4', value: '4'),
              TextChoice(text: '5', value: '5'),
              TextChoice(text: '6', value: '6'),
            ],
            defaultSelection: TextChoice(text: 'None', value: '0'),
          ),
        ),
        QuestionStep(
          title:
              'Which of the financial products do you not have but would like to have in next 12 months',
          text:
              'A hypothetical question, we won\'t giving you any money regardless of which option you choose.',
          isOptional: false,
          answerFormat: const MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Credit card', value: 'Credit card'),
              TextChoice(text: 'Loan', value: 'Loan'),
              TextChoice(text: 'Home Loan', value: 'Home Loan'),
              TextChoice(text: 'Mortgage', value: 'Mortgage'),
              TextChoice(text: 'Deposit Account(Savings)', value: 'Savings AC'),
              TextChoice(
                  text: 'Deposit Account (Current)', value: 'Current AC'),
              TextChoice(text: 'Personal loan', value: 'Personal Loan'),
              TextChoice(text: 'Business Loan', value: 'Business Loan'),
              TextChoice(text: 'Other Products', value: 'ther Products'),
              TextChoice(text: 'None', value: 'None'),
            ],
          ),
        ),
        QuestionStep(
          title:
              'Would prefer to have smaller amount of money now or a larger amount of money three months later?',
          text:
              'A hypothetical question, we won\'t giving you any money regardless of which option you choose.',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Now', value: '0'),
              TextChoice(text: 'Later', value: '1'),
            ],
            defaultSelection: TextChoice(text: 'None', value: '0'),
          ),
        ),
        QuestionStep(
          title:
              'Would prefer to have smaller amount of money now or a larger amount of money six months later?',
          text:
              'A hypothetical question, we won\'t giving you any money regardless of which option you choose.',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Now', value: '0'),
              TextChoice(text: 'Later', value: '1'),
            ],
            defaultSelection: TextChoice(text: 'None', value: '0'),
          ),
        ),

        QuestionStep(
          title: 'How many dependents do you have?',
          text:
              'Dependents in this context are people in your immediate family/circle that you have to take financial responsibility for',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 6,
            defaultValue: 3,
            minimumValueDescription: '0',
            maximumValueDescription: '6',
          ),
        ),

        QuestionStep(
          title: 'How many years of work experience do you have?',
          text:
              'Work in this context isn\'t necesarily salary based positions (e.g. voluntary work, tutoring, free-lancing, business, etc are applicable too.)',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 6,
            defaultValue: 3,
            minimumValueDescription: '0',
            maximumValueDescription: '6',
          ),
        ),

        QuestionStep(
          title: 'How many hours on average do you work per week?',
          text:
              'Work in this context isn\'t necesarily salary based positions (e.g. voluntary work, tutoring, free-lancing, business, etc are applicable too.)',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 6,
            defaultValue: 3,
            minimumValueDescription: '0',
            maximumValueDescription: '6',
          ),
        ),

        QuestionStep(
          title: 'What is your monthly Income',
          text:
              'Please enter 0 if you currently don\'t have any sources of income',
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your monthly Income',
          ),
          isOptional: true,
        ),

        QuestionStep(
          title: 'How old are you?',
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your age',
          ),
          isOptional: true,
        ),

        QuestionStep(
          title:
              'Which of the following was your High School Qualification Board?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'NTCB EV', value: 'NTCB EV'),
              TextChoice(text: 'NTCB BM', value: 'NTCB BM'),
              TextChoice(text: 'British Council', value: 'British Council'),
            ],
          ),
        ),

        QuestionStep(
          title: 'What is your major?',
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),

        QuestionStep(
          title: 'What is you minor?',
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),

        QuestionStep(
          title: 'How many credits have you completed till date?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Please enter your credits',
          ),
          isOptional: true,
        ),

        QuestionStep(
          title:
              'How many credits does your program require in total for you to graduate?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Number of credits require',
          ),
          isOptional: true,
        ),

        QuestionStep(
          title: 'How many semesters have you completed so far?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Please enter semester numbers',
          ),
          isOptional: true,
        ),

        // QuestionStep(
        //   title: 'Medication?',
        //   text: 'Are you using any medication',
        //   answerFormat: const BooleanAnswerFormat(
        //     positiveAnswer: 'Yes',
        //     negativeAnswer: 'No',
        //     result: BooleanResult.POSITIVE,
        //   ),
        // ),

        // QuestionStep(
        //   title: 'Select your body type',
        //   answerFormat: const ScaleAnswerFormat(
        //     step: 1,
        //     minimumValue: 1,
        //     maximumValue: 5,
        //     defaultValue: 3,
        //     minimumValueDescription: '1',
        //     maximumValueDescription: '5',
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Known allergies',
        //   text: 'Do you have any allergies that we should be aware of?',
        //   isOptional: false,
        //   answerFormat: const MultipleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Penicillin', value: 'Penicillin'),
        //       TextChoice(text: 'Latex', value: 'Latex'),
        //       TextChoice(text: 'Pet', value: 'Pet'),
        //       TextChoice(text: 'Pollen', value: 'Pollen'),
        //     ],
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Done?',
        //   text: 'We are done, do you mind to tell us more about yourself?',
        //   isOptional: true,
        //   answerFormat: const SingleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Yes', value: 'Yes'),
        //       TextChoice(text: 'No', value: 'No'),
        //     ],
        //     defaultSelection: TextChoice(text: 'No', value: 'No'),
        //   ),
        // ),
        // QuestionStep(
        //   title: 'When did you wake up?',
        //   answerFormat: const TimeAnswerFormat(
        //     defaultValue: TimeOfDay(
        //       hour: 12,
        //       minute: 0,
        //     ),
        //   ),
        // ),
        // QuestionStep(
        //   title: 'When was your last holiday?',
        //   answerFormat: DateAnswerFormat(
        //     minDate: DateTime.utc(1970),
        //     defaultDate: DateTime.now(),
        //     maxDate: DateTime.now(),
        //   ),
        // ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[7].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return Future.value(task);
  }

  // Future<Task> getJsonTask() async {
  //   final taskJson =
  //       await rootBundle.loadString('assets/data/surveyData_json.json');
  //   final taskMap = json.decode(taskJson);

  //   return Task.fromJson(taskMap);
  // }
}
