import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/screens/home/model/banner_model.dart';

import '../../../config/config_export.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../dialogs.dart';
import '../../screens_export.dart';
import '../home_export.dart';
import '../model/model_export.dart';
import 'widget_export.dart';

class Beneficiaries extends StatefulWidget {
  const Beneficiaries({Key? key}) : super(key: key);

  @override
  State<Beneficiaries> createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  List<BannerModel> listImage = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ChildrenParentGetState) {
          listImage = state.bannerModel;
        }
        if (state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChildrenParentDeleteState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, false);
          });
        }
        if (state is ChildrenParentErrorState) {
          //debugPrint(dialogRunning.toString());
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, true, error: S.of(context).network_error);
          });
          return noNetwork(context, () {
            context.read<HomeBloc>().add(ChildrenParentGetEvent(
                context.read<AuthBloc>().state.myUserLogin));
            context.read<HomeBloc>().add(MajorGetEvent());
          });
        }
        if (state is ChildrenParentUpdateState) {
          context.read<HomeBloc>().add(ChildrenParentGetEvent(
              context.read<AuthBloc>().state.myUserLogin));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, false);
            Navigator.pushNamedAndRemoveUntil(
                context, NavigationBarScreen.routeName, (route) => false);
          });
        }

        if (state.listChildrenParent.isEmpty) {
          return const NoBeneficiariesWidget();
        }
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   if (dialogRunning) {
        //     Navigator.pop(context);
        //     dialogRunning = false;
        //   }
        // });
        return Container(
          width: size.width,
          color: Theme.of(context).scaffoldBackgroundColor,
          height: size.height,
          alignment: Alignment.center,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.listChildrenParent.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: listImage.isEmpty
                      ? const SizedBox()
                      : CarouselSlider.builder(
                          itemCount: listImage.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              CachedNetworkImage(
                            imageUrl: listImage[itemIndex].url.toString(),
                            placeholder: (context, string) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (a, b, c) => Center(
                              child: Icon(
                                Icons.error,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            aspectRatio: 2.0,
                            initialPage: 2,
                          ),
                        ),
                );
              } else if (index == state.listChildrenParent.length + 1) {
                return Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: addButton(context, size, state.listMajor));
              } else {
                return BeneficiaryWidget(
                    childrenParentParent: state.listChildrenParent[index - 1],
                    flag: false);
              }
            },
          ),
        );
      },
    );
  }
}

Widget addButton(BuildContext context, Size size, List<Major> list) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed<List<Major>>(
            context, AddBeneficiaryScreen.routeName,
            arguments: list);
      },
      child: Container(
        width: size.width * 0.5,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).textTheme.caption?.color,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          S.of(context).add_ben,
          textScaleFactor: 1,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
