import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:manajemen_proyek/common/app_color.dart';
import 'package:manajemen_proyek/common/enums.dart';
import 'package:manajemen_proyek/common/info_.dart';
import 'package:manajemen_proyek/presentation/controllers/login_controller.dart';
import 'package:manajemen_proyek/presentation/pages/dashboard_page.dart';
import 'package:manajemen_proyek/presentation/pages/register_page.dart';
import 'package:manajemen_proyek/presentation/widgets/custom_button.dart';
import 'package:manajemen_proyek/presentation/widgets/input_auth.dart';
import 'package:manajemen_proyek/presentation/widgets/top_clip_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void gotoRegister() {
    Navigator.pushReplacementNamed(context, RegisterPage.routeName);
  }

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == '') {
      Info.failed('Email must be filled');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Info.failed('Email not valid');
      return;
    }

    if (password == '') {
      Info.failed('Password must be filled');
      return;
    }

    final state = await loginController.executeRequest(
      email,
      password,
    );

    if (state.statusRequest == StatusRequest.failed) {
      Info.failed(state.message);
      return;
    }

    if (state.statusRequest == StatusRequest.success) {
      Info.success(state.message);
      if (mounted) {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }
      return;
    }
  }

  @override
  void dispose() {
    LoginController.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      buildHeader(),
                      const Gap(40),
                      buildInput(),
                    ],
                  ),
                  buildRegisterNavigation(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHeader() {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: TopClipPainter(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(MediaQuery.paddingOf(context).top),
            Image.asset(
              'assets/images/logo_auth.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const Gap(45),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColor.primary,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Please enter your account to login',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.textBody,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InputAuth(
            controller: emailController,
            hint: 'Email',
            icon: 'assets/icons/email.png',
          ),
          const Gap(24),
          InputAuth(
            controller: passwordController,
            hint: 'Password',
            obscureText: true,
            icon: 'assets/icons/lock.png',
          ),
          const Gap(32),
          Obx(() {
            final state = loginController.state;
            if (state.statusRequest == StatusRequest.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              width: double.infinity,
              child: ButtonPrimary(
                onPressed: login,
                title: 'Login',
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildRegisterNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColor.textTitle,
            ),
          ),
          const Gap(4),
          InkWell(
            onTap: gotoRegister,
            child: const Text(
              'Register Here',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColor.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
