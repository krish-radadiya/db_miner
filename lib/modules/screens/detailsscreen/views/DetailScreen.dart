import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math' as math;
import '../controller/category_controller.dart';
import '../controller/qoutes_controller.dart';
import '../../../model/qoute_databse.dart';
import '../../../utils/DbHelper.dart';
import '../../../utils/common.dart';
import 'SecondDetailsSCreen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());

    GetQuotesController getQuotesController = Get.put(GetQuotesController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            categoryController.categoryName.value,
          ),
        ),
        body: FutureBuilder(
          future: getAllQuotes,
          builder: (context, snapshot) {
            print(snapshot.connectionState.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<QuotesDatabaseModel>? data = snapshot.data;

                return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    final quote = data![index].quotes;
                    // final isFavorite = favoriteController.isFavorite(quote);
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          height: Get.height * 0.38,
                          width: Get.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color((math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(0.2),
                              Color((math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(0.2),
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  data[index].quotes,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                        text: data[index].quotes,
                                      )).then(
                                        (value) => Get.snackbar(
                                            "Quote", "Successfully Copy",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.green.withOpacity(0.5),
                                            duration:
                                                const Duration(seconds: 3),
                                            animationDuration:
                                                const Duration(seconds: 1)),
                                      );
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.copy))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (data[index].favorite == 0) {
                                        Get.snackbar(
                                          snackPosition: SnackPosition.BOTTOM,
                                          "Quote",
                                          "is Added Successfully",
                                          colorText: Colors.white,
                                          backgroundColor: Colors.lightBlue,
                                          icon: const Icon(Icons.add_alert),
                                        );
                                        DBHelper.dbHelper.updateQuote(
                                            favorite: 1,
                                            quote: data[index].quotes);
                                        QuotesDatabaseModel
                                            quotesDataBaseModel =
                                            QuotesDatabaseModel(
                                          id: data[index].id,
                                          quotes: data[index].quotes,
                                          author: data[index].author,
                                          favorite: data[index].favorite,
                                        );
                                        DBHelper.dbHelper.insertFavorite(
                                            data: quotesDataBaseModel);
                                      } else {
                                        DBHelper.dbHelper.updateSecondQuote(
                                            favorite: 0,
                                            quote: data[index].quotes);
                                        DBHelper.dbHelper.deleteFavorite(
                                            quote: data[index].quotes);
                                      }
                                      getQuotesController.getQuotesList(
                                        allQuotes: DBHelper.dbHelper
                                            .fatchAllQuotes(
                                                id: data[index].id!),
                                      );
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.favorite))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const SecondDetailsScreen(),
                                          arguments: data[index].quotes);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.edit))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(data[index].quotes);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(
                                              Icons.share,
                                            ))),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }

            return const Text("No Data");
          },
        ));
  }
}
