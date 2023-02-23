import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';
import '../home/home_export.dart';
import '../home/model/model_export.dart';
import '../home/widget/widget_export.dart';

class SelectBeneficiaryScreen extends StatefulWidget {
  static const String routeName = "/selectBeneficiary";

  const SelectBeneficiaryScreen({Key? key}) : super(key: key);

  @override
  State<SelectBeneficiaryScreen> createState() =>
      _SelectBeneficiaryScreenState();
}

class _SelectBeneficiaryScreenState extends State<SelectBeneficiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).select_ben),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ChildrenParentErrorState) {
              return noNetwork(context, () {
                context.read<HomeBloc>().add(ChildrenParentGetEvent(
                    context.read<AuthBloc>().state.myUserLogin));
                context.read<HomeBloc>().add(MajorGetEvent());
              });
            }
            List<ChildrenParent> children = state.listChildrenParent;
            if (children.isEmpty) {
              return const NoBeneficiariesWidget();
            } else if (children.isNotEmpty) {
              return ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop<ChildrenParent>(context, children[index]);
                      },
                      contentPadding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: Theme.of(context).cardColor,
                      leading: Image.asset(AppAssets.person),
                      title: Text(
                        children[index].childName.toString(),
                        textScaleFactor: 1,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2?.color),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
