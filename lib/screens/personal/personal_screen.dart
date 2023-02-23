import 'package:flutter/material.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';
import '../dialogs.dart';
import '../home/home_export.dart';
import '../home/model/model_export.dart';
import '../home/widget/widget_export.dart';
import 'widget/export_widget.dart';

class PersonalScreen extends StatefulWidget {
  static const String routeName = "/personalScreen";

  const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChildrenParentErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, true, error: S.of(context).network_error);
          });
          return noNetwork(context, () {
            context.read<HomeBloc>().add(ChildrenParentGetEvent(
                context.read<AuthBloc>().state.myUserLogin));
            context.read<HomeBloc>().add(MajorGetEvent());
          });
        }
        List<ChildrenParent> children = state.listChildrenParent;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          killLoading(context, false);
        });
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 10),
          physics: const BouncingScrollPhysics(),
          itemCount: children.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                //padding: const EdgeInsets.on(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: PersonCardWidget(),
                    ),
                    //Container(width: MediaQuery.of(context).size.width,height: 0.5,color: Theme.of(context).dividerColor,),
                    //SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).beneficiaries,
                            textScaleFactor: 1.2,
                          )
                        ],
                      ),
                    ),
                    //Container(width: MediaQuery.of(context).size.width,height: 0.5,color: Theme.of(context).dividerColor,),
                    // SizedBox(height: 5,),
                  ],
                ),
              );
            } else {
              return BeneficiaryWidget(
                childrenParentParent: children[index - 1],
                flag: false,
              );
            }
          },
        );
      },
    );
  }
}
