import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:manajemen_proyek/presentation/controllers/home/agenda_today_controller.dart';
import 'package:manajemen_proyek/presentation/controllers/home/mood_today_controller.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final moodTodayController = Get.put(MoodTodayController());
  final agendaTodayController = Get.put(AgendaTodayController());

  @override
  void dispose() {
    MoodTodayController.delete();
    AgendaTodayController.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        buildHeader(),
      ]
    );
  }

  Widget buildHeader(){
    return SizedBox();
  }

  Widget buildYourMoodToday(){
    return SizedBox();
  }

  Widget buildYourAgendaToday(){
    return SizedBox();
  }
}