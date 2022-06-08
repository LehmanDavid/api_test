import 'package:bloc1/model/state_status.dart';
import 'package:bloc1/service/text_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/info_bloc.dart';
import '../model/info_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController controller;
  TextService textService = TextService();
  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state.status is FailureStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text((state.status as FailureStatus).message),
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            controller: controller,
            itemCount: state.infos.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == state.infos.length) {
                if (state.status is InitialStatus) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Container();
                }
              }
              final info = state.infos[index];
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${info.id}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text('Title: ${info.title}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text('Body: ${info.body}'),
                      const Divider(
                        thickness: 3.0,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _scrollListener() {
    if (_isBottom) context.read<InfoBloc>().add(LoadApiEvent());
  }

  bool get _isBottom {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
