import 'package:flutter/material.dart';
import 'package:rehab_care/screens/home/home_export.dart';

import '../../../config/config_export.dart';
import '../../screens_export.dart';

class NoBeneficiariesWidget extends StatefulWidget {
  const NoBeneficiariesWidget({Key? key}) : super(key: key);

  @override
  State<NoBeneficiariesWidget> createState() => _NoBeneficiariesWidgetState();
}

class _NoBeneficiariesWidgetState extends State<NoBeneficiariesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          width: size.width,
          height: size.height - 175.0,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo_grey.png"),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).no_ben,
                textScaleFactor: 1,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddBeneficiaryScreen.routeName,
                      arguments: state.listMajor);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blueColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).add_ben,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
