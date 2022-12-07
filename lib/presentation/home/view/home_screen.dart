import 'package:aiolos/presentation/resources/asset_manager.dart';
import 'package:aiolos/presentation/resources/color_manager.dart';
import 'package:aiolos/presentation/resources/font_manager.dart';
import 'package:aiolos/presentation/resources/routes_manager.dart';
import 'package:aiolos/presentation/resources/string_manager.dart';
import 'package:aiolos/scale_controller.dart';
import 'package:aiolos/utils/crud/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_screen_controller.dart';

class Home extends GetView<HomeScreenController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            backgroundColor: ColorManager.background,
            appBar: AppBar(
              toolbarHeight: ScaleController.H * 0.1,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AssetManager.homeTitle,
                  width: ScaleController.W * 0.15,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  removeToken();
                  Get.offAllNamed(RoutesManager.loginRoute);
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                ),
              ),
              actions: [
                const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                SizedBox(
                  width: ScaleController.W * 0.05,
                ),
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
                SizedBox(
                  width: ScaleController.W * 0.015,
                ),
              ],
            ),
            body: Obx(() => controller.isProcess.value == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: ScaleController.H * 0.02,
                          ),
                          Container(
                              width: ScaleController.W * 0.85,
                              height: ScaleController.H * 0.08,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent, width: 0.5),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: controller.searchController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: AppStrings.hintText,
                                      labelStyle: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: FontFamily.gilroyRegular,
                                          color: Colors.black),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScaleController.W * 0.05))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScaleController.W * 0.05))),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            controller.productSearch();
                                          },
                                          child: const Icon(
                                            Icons.search_sharp,
                                            color: Colors.pink,
                                          ))),
                                ),
                              )),
                          controller.list.data.totalRecords == 0
                              ? SizedBox(
                                  height: ScaleController.H * 0.5,
                                  width: ScaleController.W,
                                  child: Center(
                                    child: Text(
                                      "${controller.searchController.text} is not available",
                                      style: TextStyle(
                                          fontSize: FontSize.s18,
                                          fontFamily: FontFamily.gilroyRegular),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: GridView.builder(
                                      controller: controller.controller,
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(
                                          ScaleController.W * 0.025),
                                      itemCount: controller
                                              .searchController.text.isEmpty
                                          ? controller.list.data.pageSize
                                          : controller.list.data.totalRecords,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.525,
                                              crossAxisCount: 2),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: ScaleController.W *
                                                        0.025,
                                                    top: ScaleController.H *
                                                        0.0125),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Featured',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.pink,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.14,
                                                width: ScaleController.W * 0.35,
                                                child: Image.asset(
                                                  AssetManager.product,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  controller.list.data
                                                      .products[index].name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              const Text(
                                                AppStrings.quantity,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              Text(
                                                '₹${controller.list.data.products[index].mrp}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              const Text(
                                                AppStrings.offer,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              controller
                                                          .list
                                                          .data
                                                          .products[index]
                                                          .rating ==
                                                      0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.star_border,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                        const Icon(
                                                          Icons.star_border,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                        const Icon(
                                                          Icons.star_border,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                        const Icon(
                                                          Icons.star_border,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                        const Icon(
                                                          Icons.star_border,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: ScaleController
                                                                  .W *
                                                              0.01,
                                                        ),
                                                        const Text(
                                                          AppStrings.rating,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : controller
                                                              .list
                                                              .data
                                                              .products[index]
                                                              .rating ==
                                                          1
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  ScaleController
                                                                          .W *
                                                                      0.01,
                                                            ),
                                                            const Text(
                                                              AppStrings.rating,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : controller
                                                                  .list
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .rating ==
                                                              2
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                                const Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                                const Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                                const Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      ScaleController
                                                                              .W *
                                                                          0.01,
                                                                ),
                                                                const Text(
                                                                  AppStrings
                                                                      .rating,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : controller
                                                                      .list
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .rating ==
                                                                  3
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .star_border,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .star_border,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                    SizedBox(
                                                                      width: ScaleController
                                                                              .W *
                                                                          0.01,
                                                                    ),
                                                                    const Text(
                                                                      AppStrings
                                                                          .rating,
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : controller
                                                                          .list
                                                                          .data
                                                                          .products[
                                                                              index]
                                                                          .rating ==
                                                                      4
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .star_border,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              ScaleController.W * 0.01,
                                                                        ),
                                                                        const Text(
                                                                          AppStrings
                                                                              .rating,
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : controller
                                                                              .list
                                                                              .data
                                                                              .products[index]
                                                                              .rating ==
                                                                          5
                                                                      ? Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 15,
                                                                            ),
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 15,
                                                                            ),
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 15,
                                                                            ),
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 15,
                                                                            ),
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 15,
                                                                            ),
                                                                            SizedBox(
                                                                              width: ScaleController.W * 0.01,
                                                                            ),
                                                                            const Text(
                                                                              AppStrings.rating,
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.black,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                              SizedBox(
                                                height:
                                                    ScaleController.H * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .favorite_border_rounded,
                                                    color: Colors.pink,
                                                    size: ScaleController.W *
                                                        0.05,
                                                  ),
                                                  SizedBox(
                                                    width: ScaleController.W *
                                                        0.02,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          ScaleController.H *
                                                              0.05,
                                                      width: ScaleController.W *
                                                          0.3725,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.pink),
                                                      child: const Text(
                                                        AppStrings.add,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      })),
                          SizedBox(
                            height: ScaleController.H * 0.12,
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: ScaleController.H * 0.01),
                        child: Container(
                          width: ScaleController.W,
                          height: ScaleController.H * 0.1,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  RotatedBox(
                                    quarterTurns: 45,
                                    child: Icon(
                                      Icons.compare_arrows,
                                      color: Colors.grey,
                                      size: ScaleController.W * 0.075,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        AppStrings.sortBy,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        AppStrings.popularity,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              RotatedBox(
                                quarterTurns: 45,
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: ScaleController.W * 0.0025,
                                  indent: ScaleController.W * 0.025,
                                  endIndent: ScaleController.W * 0.025,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.grey,
                                    size: ScaleController.W * 0.075,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        AppStrings.filter,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        AppStrings.applyFilter,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))));
  }
}
