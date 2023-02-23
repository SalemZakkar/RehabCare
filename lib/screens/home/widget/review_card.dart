import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/bloc/bloc_export.dart';
import 'package:rehab_care/screens/home/bloc/reviews_bloc/review_bloc.dart';
import 'package:rehab_care/screens/home/model/answer_model.dart';
import 'package:rehab_care/screens/home/model/question_model.dart';

import '../../../config/config_export.dart';

class ReviewCardWidget extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const ReviewCardWidget(
      {Key? key, required this.questionModel, required this.index})
      : super(key: key);

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  List<bool> radioValues = [false, false, false];

  void setRadios(int r) {
    if (r != -2) {
      for (int i = 0; i < 3; i++) {
        radioValues[i] = false;
      }
      radioValues[r] = true;
    }
  }

  Map<String, int> m = {"1": 0, "-1": 1, "0": 2};
  Map<int, String> ans = {0: "1", 1: "-1", 2: "0"};

  void setAnswer(int r) {
    if (answers[widget.index] != null) {
      answers[widget.index] = AnswerModel(
          answer: ans[r], questionId: widget.questionModel.questionId ?? "");
    } else {
      answers.putIfAbsent(
          widget.index,
          () => AnswerModel(
              answer: ans[r],
              questionId: widget.questionModel.questionId ?? ""));
    }
  }

  Color iconColor = Colors.grey;
  bool able = true;
  bool able2 = true;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showAlertDialog(context, widget.questionModel.questionText ?? "",
            "${S.of(context).question} ${widget.index + 1}");
      },
      child: BlocProvider<ReviewBloc>(
        create: (context) => ReviewBloc(),
        child: BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            if (state is ReviewInitial) {
              if (able) {
                context.read<ReviewBloc>().add(CheckQuestionEvent(
                    questionId: widget.questionModel.questionId ?? ""));
                able = false;
              }
            }
            if (state is GetAnswerDone) {
              //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //   setState(() {
              if (able2) {
                iconColor = Theme.of(context).primaryColor;
                setRadios(m[state.answerModel?.answer ?? ""] ?? -2);
                able2 = false;
                debugPrint(
                    "----------------------------------------------------");
                debugPrint(
                    "${widget.index}   ${state.answerModel?.answer ?? ""}");
                debugPrint(
                    "----------------------------------------------------");
              }
              // });
              // });
            }
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: size.width,
              height: (expanded ? 250 : 65),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          AppAssets.helpCenter,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${S.of(context).question} ${widget.index + 1}",
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color),
                        ),
                        const Spacer(),
                        Icon(
                          CupertinoIcons.flag_circle_fill,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: animationController,
                          ),
                          color: Colors.grey,
                          onPressed: () {
                            (expanded
                                ? animationController.reverse()
                                : animationController.forward());
                            setState(() {
                              expanded = !expanded;
                              if (kDebugMode) {
                                print(answers);
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          setRadios(0);
                        });
                        setAnswer(0);
                      },
                      leading: Radio(
                        onChanged: (value) {
                          setState(() {
                            setRadios(0);
                          });
                          setAnswer(0);
                        },
                        groupValue: true,
                        value: radioValues[0],
                        activeColor: blueColor,
                      ),
                      title: Text(
                        S.of(context).can,
                        textScaleFactor: 1,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          setRadios(1);
                        });
                        setAnswer(1);
                      },
                      leading: Radio(
                        onChanged: (value) {
                          setState(() {
                            setRadios(1);
                          });
                          setAnswer(1);
                        },
                        groupValue: true,
                        value: radioValues[1],
                        activeColor: blueColor,
                      ),
                      title: Text(
                        S.of(context).cant,
                        textScaleFactor: 1,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          setRadios(2);
                        });
                        setAnswer(2);
                      },
                      leading: Radio(
                        onChanged: (value) {
                          setState(() {
                            setRadios(2);
                          });
                          setAnswer(2);
                        },
                        groupValue: true,
                        value: radioValues[2],
                        activeColor: blueColor,
                      ),
                      title: Text(
                        S.of(context).sometimes,
                        textScaleFactor: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String text, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            title,
            textScaleFactor: 0.8,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
          ),
          scrollable: false,
          content: Container(
            width: 500,
            height: 300,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Text(
              text,
              textAlign: TextAlign.center,
            )),
          ),
        );
      });
}
