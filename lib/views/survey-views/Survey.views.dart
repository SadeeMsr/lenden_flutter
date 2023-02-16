import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:http/http.dart' as http;

//=============================================================================================================================

//=============================================================================================================================

class Survey extends StatefulWidget {
  final String data;

  const Survey({Key? key, required this.data}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onResult: (SurveyResult result) async {
                    final json = result.toJson();
                    var body =
                        jsonEncode({'userId': widget.data, 'answers': json});
                    var url = Uri.parse(
                        'http://shababe.pythonanywhere.com/addSurvey/');
                    try {
                      var resp = await http
                          .post(url,
                              headers: {"Content-Type": "application/json"},
                              body: body)
                          .catchError((_) => print('Logging message failed'));
                      print(resp.statusCode);
                    } on SocketException {
                      print("error");
                    }
                    SystemNavigator.pop();
                    // Navigator.pushNamed(context, '/');
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
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p1'),
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
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p2'),
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
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p3'),
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
          stepIdentifier: StepIdentifier(id: 'p4'),
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
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p5'),
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
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p6'),
          title: 'You regularly Make new friends?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p7'),
          title:
              'You spend a lot of your free time exploring various random topics that pique your interest?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p8'),
          title: 'You usually stay calm, even under a lot of pressure?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p9'),
          title:
              'At social events, you rarely try to introduce yourself to new people and mostly talk to the ones you already know?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p10'),
          title:
              'You prefer to completely finish one project before starting another?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p11'),
          title: 'You are very sentimental?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p12'),
          title: 'You like to use organizing tools like schedules and lists?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p13'),
          title:
              'You feel comfortable just walking up to someone you find interesting and striking up a conversation ?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'p14'),
          title:
              'You are not too interested in discussing various interpretations and analyses of creative works?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Strongly agree', value: '5'),
              TextChoice(text: 'Agree', value: '4'),
              TextChoice(text: 'Neutral', value: '3'),
              TextChoice(text: 'Disagree', value: '2'),
              TextChoice(text: 'Strongly disagree', value: '1'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd11'),
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
          stepIdentifier: StepIdentifier(id: 'd12'),
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
          stepIdentifier: StepIdentifier(id: 'd13'),
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
          stepIdentifier: StepIdentifier(id: 'd21'),
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
          stepIdentifier: StepIdentifier(id: 'd22'),
          title: 'How old are you?',
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your age',
          ),
          isOptional: true,
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd23'),
          title: 'What is your gender?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Male', value: 'Male'),
              TextChoice(text: 'Female', value: 'Female'),
              TextChoice(text: 'Other', value: 'Other'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd24'),
          title:
              'Which of the following was your High School Qualification Board?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'NTCB(English Version)', value: 'NTCB EV'),
              TextChoice(text: 'NTCB(Bangla Medium)', value: 'NTCB BM'),
              TextChoice(text: 'NTCB(Bangla Medium)', value: 'NTCB BM'),
              TextChoice(text: 'British Council', value: 'British Council'),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd25'),
          title: 'What is your major?',
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd26'),
          title: 'What is you minor?',
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd27'),
          title: 'How many credits have you completed till date?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Please enter your credits',
          ),
          isOptional: true,
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd28'),
          title:
              'How many credits does your program require in total for you to graduate?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Number of credits require',
          ),
          isOptional: true,
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: 'd29'),
          title: 'How many semesters have you completed so far?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Please enter semester numbers',
          ),
          isOptional: true,
        ),
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
}
