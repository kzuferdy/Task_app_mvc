import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manajemen_proyek/common/app_color.dart';
import 'package:manajemen_proyek/core/session.dart';
import 'package:manajemen_proyek/presentation/pages/dashboard_page.dart';
import 'package:manajemen_proyek/presentation/pages/login_page.dart';
import 'package:manajemen_proyek/presentation/pages/register_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: 'Project Management App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: AppColor.primary,
          scaffoldBackgroundColor: AppColor.surface,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
            surface: AppColor.surface,
            surfaceContainer: AppColor.surfaceContainer,
            error : AppColor.error,
          ),
          textTheme: GoogleFonts.interTextTheme(),
          shadowColor: AppColor.primary.withOpacity(0.3),
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data == null) return const LoginPage();
          return const DashboardPage();
        },
      ),
        routes: {
          LoginPage.routeName:(context)=>const LoginPage(),
          DashboardPage.routeName:(context)=>const DashboardPage(),
          RegisterPage.routeName:(context)=>const RegisterPage(),
        },
    );
  
  }
}
