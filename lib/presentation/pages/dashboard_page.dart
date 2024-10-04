import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manajemen_proyek/common/app_color.dart';
import 'package:manajemen_proyek/data/models/solution_model.dart';
import 'package:manajemen_proyek/presentation/pages/fragment/analytic_fragmen.dart';
import 'package:manajemen_proyek/presentation/pages/fragment/home_fragment.dart';
import 'package:manajemen_proyek/presentation/pages/fragment/solution_fragment.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

    static const routeName = '/dashboard';


  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final navIndex = 0.obs;

  final List<Map<String,dynamic>> menu =[
    {
      'icon' : 'assets/icons/home_outlined.png', 
      'view' : const HomeFragment(),
    },
    {
      'icon' : 'assets/icons/chart_outlined.png', 
      'view' : const AnalyticFragment(),
    },
    {
      'icon' : 'assets/icons/doc_outlined.png', 
      'view' : const SolutionFragment(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(() {
        return menu [navIndex.value]['view'] as Widget;
      }
    ),
    bottomNavigationBar: buildMenu(),
    );
  }

  Widget buildMenu() {
    return Obx(() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: AppColor.primary.withOpacity(0.4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(menu.length, (index) {
              bool isActive = index == navIndex.value;
              String icon = menu[index]['icon'];
              return Material(
                borderRadius: BorderRadius.circular(12),
                color: isActive ? AppColor.primary : Colors.white,
                child: InkWell(
                  onTap: () {
                    navIndex.value = index;
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: ImageIcon(
                        AssetImage(icon),
                        color: isActive ? Colors.white : AppColor.primary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}