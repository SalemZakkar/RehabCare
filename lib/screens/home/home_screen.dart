import 'package:flutter/material.dart';

import '../../bloc/bloc_export.dart';
import '../authentication/bloc/auth_bloc.dart';
import 'bloc/home_bloc.dart';
import 'widget/widget_export.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    context.read<HomeBloc>().add(
        ChildrenParentGetEvent(context.read<AuthBloc>().state.myUserLogin));
    context.read<HomeBloc>().add(MajorGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return const Scaffold(
                  body: Beneficiaries(),
                );
              },
            );
          },
        );
      },
    );
  }
}
