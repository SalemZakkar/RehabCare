import 'package:flutter/material.dart';
import 'package:rehab_care/screens/authentication/authentication_export.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/bloc/reviews_bloc/review_bloc.dart';

import '../../config/config_export.dart';
import 'widget/widget_export.dart';

class AllReviewsScreen extends StatefulWidget {
  static const String routeName = "/allReviews";
  final String childId;
  final String majorId;

  const AllReviewsScreen(
      {Key? key, required this.majorId, required this.childId})
      : super(key: key);

  @override
  State<AllReviewsScreen> createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {
  bool able = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reviews),
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
                    context.read<ReviewBloc>().add(GetReviewsEvent(
                        childId: widget.childId, majorId: widget.majorId));
                    able = false;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetReviewDone) {
                  if (state.data.isEmpty) {
                    return noData(context);
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3),
                      itemBuilder: (context, index) {
                        return ReviewHolder(
                          reviewModel: state.data[index],
                        );
                      },
                      itemCount: state.data.length,
                    );
                  }
                }
                if (state is ReviewError) {
                  return noNetwork(context, () {
                    context.read<ReviewBloc>().add(GetReviewsEvent(
                        childId: widget.childId, majorId: widget.majorId));
                  });
                }
                return const Center();
              },
            ),
          )),
    );
  }
}
