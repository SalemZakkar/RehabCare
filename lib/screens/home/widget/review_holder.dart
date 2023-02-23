import 'package:flutter/material.dart';

import '../../../config/config_export.dart';
import '../../screens_export.dart';
import '../model/review_model.dart';

class ReviewHolder extends StatefulWidget {
  final ReviewModel reviewModel;

  const ReviewHolder({Key? key, required this.reviewModel}) : super(key: key);

  @override
  State<ReviewHolder> createState() => _ReviewHolderState();
}

class _ReviewHolderState extends State<ReviewHolder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ReviewsPage.routeName,
            arguments: ReviewsPage(reviewModel: widget.reviewModel));
      },
      child: Container(
        width: size.width * 0.45,
        height: 220,
        alignment: Alignment.center,
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.helpCenter),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.reviewModel.evaName ?? "",
              textScaleFactor: 1,
            )
          ],
        ),
      ),
    );
  }
}
