import 'package:flutter/material.dart';
import 'package:rehab_care/bloc/bloc_export.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/bloc/reviews_bloc/review_bloc.dart';
import 'package:rehab_care/screens/home/model/review_model.dart';

import '../../config/config_export.dart';
import 'widget/widget_export.dart';

class ReviewsPage extends StatefulWidget {
  final ReviewModel reviewModel;
  static const String routeName = "/Reviews";

  const ReviewsPage({Key? key, required this.reviewModel}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  bool able = true;
  int cnt = 0;
  List<Widget> cards = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        answers.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.reviewModel.evaName ?? ""),
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          alignment: Alignment.center,
          child: BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(),
            child: BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, state) {
                if (state is ReviewInitial) {
                  if (able) {
                    context.read<ReviewBloc>().add(GetQuestionEvent(
                        evaId: widget.reviewModel.evaId ?? ""));
                    able = false;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ReviewError) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    killLoading(context, true,
                        error: S.of(context).network_error);
                  });
                  return noNetwork(context, () {
                    context.read<ReviewBloc>().add(GetQuestionEvent(
                        evaId: widget.reviewModel.evaId ?? ""));
                  });
                }
                if (state is SendAnswerDone) {
                  killLoading(context, false);
                  answers.clear();
                  context
                      .read<ReviewBloc>()
                      .add(ResetReview(evaId: widget.reviewModel.evaId ?? ""));
                }
                if (state is GetQuestionsDone) {
                  if (state.data.isEmpty) {
                    return noData(context);
                  }
                  if (cnt < state.data.length) {
                    for (var element in state.data) {
                      cards.add(ReviewCardWidget(
                          questionModel: element, index: cnt++));
                    }
                    cards.add(sendButton(
                        context,
                        widget.reviewModel.childId ?? "",
                        widget.reviewModel.evaId ?? ""));
                  }
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: cards,
                      ),
                    ),
                  );
                }
                debugPrint(state.toString());
                return const Center();
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget sendButton(BuildContext context, String childId, String evaId) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 80,
    color: Colors.transparent,
    alignment: Alignment.center,
    child: InkWell(
      onTap: () {
        showLoadingDialog(context);
        List<String> qIds = [];
        List<String> answer = [];
        answers.forEach((key, value) {
          qIds.add(value.questionId ?? "");
          answer.add(value.answer ?? "");
        });
        context.read<ReviewBloc>().add(SendAnswerEvent(
            childId: childId, qIds: qIds, answers: answer, evaId: evaId));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).textTheme.caption?.color),
        alignment: Alignment.center,
        child: Text(
          S.of(context).save,
          textScaleFactor: 1,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
