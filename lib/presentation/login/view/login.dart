import 'package:aiolos/presentation/resources/asset_manager.dart';
import 'package:aiolos/presentation/resources/color_manager.dart';
import 'package:aiolos/presentation/resources/font_manager.dart';
import 'package:aiolos/presentation/resources/string_manager.dart';
import 'package:aiolos/scale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/progress_hud.dart';
import '../controller/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProgressHUD(
          opacity: 0.3,
          inAsyncCall: controller.isProcess.value,
          child: uiSetup(context),
        ));
  }

  Widget uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetManager.loginBackground),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.login,
                style: TextStyle(
                    fontSize: FontSize.s40,
                    fontFamily: FontFamily.gilroyBold,
                    color: Colors.white),
              ),
              SizedBox(
                height: ScaleController.H * 0.045,
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: ScaleController.W * 0.1),
                        padding: EdgeInsets.only(
                            right: ScaleController.W * 0.003,
                            top: ScaleController.H * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(ScaleController.W * 0.2)),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xffe5e5e5),
                                  offset: Offset(5, 5),
                                  blurRadius: 3,
                                  spreadRadius: 11),
                            ]),
                        child: Center(
                          child: TextFormField(
                            controller: controller.usernameController,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              hintText: AppStrings.userName,
                              hintStyle:
                                  TextStyle(fontFamily: FontFamily.gilroyBold),
                              prefixIcon: Icon(Icons.person),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdadada))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdadada))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScaleController.W * 0.1),
                        padding: EdgeInsets.only(
                            right: ScaleController.W * 0.2,
                            top: ScaleController.H * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(ScaleController.W * 0.2)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffe5e5e5),
                                offset: Offset(5, 5),
                                blurRadius: 3,
                              )
                            ]),
                        child: TextFormField(
                          controller: controller.passwordController,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              hintText: AppStrings.password,
                              hintStyle:
                                  TextStyle(fontFamily: FontFamily.gilroyBold),
                              prefixIcon: Icon(Icons.lock_open_outlined),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScaleController.H * 0.15,
                    // color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScaleController.W * 0.03),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            controller.login();
                          },
                          child: CircleAvatar(
                            radius: ScaleController.H * 0.037,
                            backgroundColor: ColorManager.button,
                            child: Icon(
                              Icons.arrow_right_alt_sharp,
                              color: Colors.white,
                              size: ScaleController.H * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScaleController.H * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: ScaleController.W * 0.25),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: FontSize.s18,
                      fontFamily: FontFamily.gilroyBold),
                ),
              ),
              SizedBox(
                height: ScaleController.H * 0.1,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScaleController.H * 0.01,
                        horizontal: ScaleController.W * 0.05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffe5e5e5),
                              offset: Offset(2, 1),
                              blurRadius: 3,
                              spreadRadius: 5),
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(ScaleController.W * 0.06),
                            bottomRight:
                                Radius.circular(ScaleController.W * 0.06))),
                    child: Text(
                      AppStrings.register,
                      style: TextStyle(
                          color: ColorManager.textRegister,
                          fontSize: FontSize.s20,
                          fontFamily: FontFamily.gilroyBold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
