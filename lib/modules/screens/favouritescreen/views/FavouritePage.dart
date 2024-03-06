import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/favourite.dart';
import '../../detailsscreen/controller/qoutes_controller.dart';
import '../model/favourite_db_model.dart';
import '../../../utils/DbHelper.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    getAllFavorite = DBHelper.dbHelper.fatchAllFavorite();
  }

  Future<List<FavoriteDataBaseModel>>? getAllFavorite;

  GetQuotesController getQuotesController = Get.put(GetQuotesController());
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            "favourite",
          ),
          centerTitle: true,
        ),
      ),
      body: FutureBuilder(
        future: getAllFavorite,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<FavoriteDataBaseModel>? data = snapshot.data;
            if (data == null || data.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "assets/images/Favorite/data.png",
                      //   height: Get.height * 0.35,
                      // ),
                      Text(
                        "No favourite quotes!",
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                            fontSize: Get.height * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(
                  12,
                ),
                child: ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, i) => ListTile(
                    title: Text(
                      data[i].quotes,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        data[i].author,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Get.snackbar(
                          "Quote",
                          "is Remove Successfully",
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.lightBlue,
                          icon: const Icon(Icons.add_alert),
                        );
                        favoriteController.toggleFavorite(data[i].quotes);
                        DBHelper.dbHelper.updateSecondQuote(
                          favorite:
                              favoriteController.isFavorite(data[i].quotes)
                                  ? 1
                                  : 0,
                          quote: data[i].quotes,
                        );
                        DBHelper.dbHelper.deleteFavorite(quote: data[i].quotes);
                        getQuotesController.getQuotesList(
                            allQuotes: DBHelper.dbHelper
                                .fatchAllQuotes(id: data[i].id!));
                      },
                      icon: Obx(
                        () => Icon(
                          CupertinoIcons.heart,
                          color: favoriteController.isFavorite(data[i].quotes)
                              ? Colors.black
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, _) => const Divider(),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
