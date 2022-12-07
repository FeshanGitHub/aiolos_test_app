import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../model/product_list_response.dart';

class HomeScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var isProcess = false.obs;
  dynamic list = {}.obs;
  dynamic searchList = {}.obs;
  RxInt products = 0.obs;
  List chips = ['Sheet Masks', 'Masks & Peels', 'Sleeping Masks'];
  var selectedChips = [].obs;
  var pageCount = [].obs;
  RxInt currentPage = 1.obs;
  RefreshController refreshController = RefreshController();
  final ScrollController controller = ScrollController();
  var hasNextPage = true.obs;
  var isLoadMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    productSearch();
    controller.addListener(() {
      scrollListener();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
  }

  Future productSearch() async {
    isProcess.value = true;
    if (searchController.text.isEmpty) {
      final http.Response response = await http.get(
        Uri.parse(
            'http://15.207.2.231:9500/product/product-search?url_key=makeup&productSorting=&page_size=10&page_no=1&searchByKeyword=&searchByWidgetProduct='),
      );
      print(currentPage);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        var productList = json.decode(response.body);
        var data = ProductListResponseModel.fromJson(productList);
        if (kDebugMode) {
          print(data.data.totalRecords);
        }
        list = data;
        products.value = data.data.products.length;
        isProcess.value = false;
      }
    } else if (searchController.text.isNotEmpty) {
      final http.Response response = await http.get(
        Uri.parse(
            'http://15.207.2.231:9500/product/product-search?url_key=makeup&productSorting=&page_size=4500&page_no=1&searchByKeyword=${searchController.text}&searchByWidgetProduct='),
      );
      print(currentPage);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        var productList = json.decode(response.body);
        var data = ProductListResponseModel.fromJson(productList);
        if (kDebugMode) {
          print(data.data.totalRecords);
        }
        list = data;
        products.value = data.data.products.length;
        isProcess.value = false;
      }
    }
  }

  void scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      print('Scroll Listener Called');
      isLoadMore.value = true;
      currentPage = 1.obs;
      currentPage++;
      productSearch();
      isLoadMore.value = false;
    }
  }
}
