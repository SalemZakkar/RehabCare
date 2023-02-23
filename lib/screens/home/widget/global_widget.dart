import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/screens/home/home_export.dart';

import '../../../config/config_export.dart';
import '../model/major.dart';

Widget imageLead(Size size, bool online, String? imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: blueColor),
                  borderRadius: BorderRadius.circular(100)),
              width: 60,
              height: 60,
              child: imageUrl == null
                  ? Image.asset(AppAssets.person)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(400),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, string) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (c, q, qq) => Icon(
                          Icons.error,
                          color: lightTheme.errorColor,
                        ),
                        imageBuilder: (context, provider) {
                          return Image(
                            image: provider,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )),
          Positioned(
              child: Icon(
            Icons.circle,
            color: (online ? Colors.green : Colors.redAccent),
            size: 20,
          )),
        ],
      ),
    ),
  );
}

Future<Major?> getMedicalCase(BuildContext context) async {
  String medical = "";
  String id = "";
  List<Major> list = context.read<HomeBloc>().state.listMajor;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            S.of(context).medical_condition,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index].name ?? " "),
                  onTap: () {
                    medical = list[index].name ?? " ";
                    id = list[index].id ?? "";
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      });
  if (id == "") {
    return null;
  }
  return Major(id: id, name: medical);
}
