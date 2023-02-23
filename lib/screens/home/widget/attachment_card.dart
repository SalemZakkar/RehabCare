import 'package:flutter/material.dart';
import 'package:rehab_care/screens/home/home_export.dart';
import 'package:rehab_care/screens/home/model/model_export.dart';

import '../../../config/config_export.dart';

class AttachmentCard extends StatefulWidget {
  final Attachment attachment;
  final int index;

  const AttachmentCard(
      {Key? key, required this.attachment, required this.index})
      : super(key: key);

  @override
  State<AttachmentCard> createState() => _AttachmentCardState();
}

class _AttachmentCardState extends State<AttachmentCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: size.width,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(widget.attachment.type.toLowerCase() == "pdf"
                  ? "Pdf"
                  : S.of(context).image),
              subtitle: Text(
                widget.attachment.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
              trailing: InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(
                        DeleteAttachmentEvent(name: widget.attachment.name));
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Theme.of(context).errorColor,
                  )),
            ),
          ),
        );
      },
    );
  }
}
