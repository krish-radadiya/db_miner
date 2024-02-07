import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/Quotesmodel.dart';

class HomePageController extends GetxController {
  List<QuotesModel> quoteList = [];
  RxBool isLoading = false.obs;
  int value = 3.obs();
  bool isswitch = false.obs();

  @override
  void onInit() {
    // TODO: implement onInit
    print('oninit');
    //late DatabaseHelper databaseHelper;
    //  DatabaseHelper.createTables();
    isLoading.value = true;
    readJson().then((value) => {isLoading.value = false});
    update();
    super.onInit();
  }

  List<QuotesModel> quoteData = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/quotes.json');
    final data = await json.decode(response);

    for (var d in data) {
      // QuotesModel quote=QuotesModel.fromJson(d);
      // await insertStudent(quote);
      // quoteList.add(QuotesModel.fromJson(d));
    }

    // print(await getQuotes());
    print(quoteList.length);
    print('kldsnc');

    update();
  }
}
