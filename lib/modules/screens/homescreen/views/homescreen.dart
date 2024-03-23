import 'dart:async';
import 'dart:math';
import 'package:dminer/modules/screens/detailsscreen/views/DetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/DbHelper.dart';
import '../../../utils/common.dart';
import '../../detailsscreen/model/category_database_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Future<List<CategoryDatabaseModel>>? getAllRecord;
  LocalJsonController localjsoncontroller = Get.put(LocalJsonController());

  final List<Color> _colors = List.generate(
    18,
    (index) =>
        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
  );
  late List<Color> _containerColors;

  @override
  void initState() {
    super.initState();
    getAllRecord = DBHelper.dbHelper.fatchAllCategory();
    _containerColors = List.generate(_colors.length, (index) => _colors[index]);
  }

  CategoryController categoryController = Get.put(CategoryController());
  ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.03,
              child: Container(
                color: const Color(0xffcf5260),
              ),
            ),
            Container(
              height: Get.height * 0.30,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage("assets/other images/quote.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt,
              ),
              title: Text(
                "Quote Category",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.water,
              ),
              title: Text(
                "Other Quote",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.heart_fill,
              ),
              title: Text(
                "My Favorite",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.refresh_sharp,
              ),
              title: Text(
                "Theme",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.toNamed(
                  "/theme",
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.edit_attributes_outlined,
              ),
              title: Text(
                "Rate & Review",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
              ),
              title: Text(
                "Feedback",
                style: GoogleFonts.hind(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBar(
            leading: IconButton(
              icon: const Icon(Icons.list_rounded),
              onPressed: () {
                var scaffoldKey;
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.closeDrawer();
                } else {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
            title: Text(
              "Quotes",
              style: GoogleFonts.lilitaOne(),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed("/favourite");
                },
                icon: Icon(CupertinoIcons.heart_fill),
              ),
            ],
            backgroundColor: _themeController.appBarColor.value,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAllRecord,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<CategoryDatabaseModel>? data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text("NO DATA AVAILABLE"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 32,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final containerColor =
                          _containerColors[index % _containerColors.length];
                      return GestureDetector(
                        onTap: () {
                          categoryController
                              .setCategoryName(data[index].category_name);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return const DetailsScreen();
                              },
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 600),
                            ),
                          );
                          getAllQuotes = DBHelper.dbHelper
                              .fatchAllQuotes(id: data[index].id);
                        },
                        child: Card(
                          elevation: 10,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.017,
                                ),
                                Container(
                                  height: Get.height * 0.14,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: containerColor.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    imagePaths[index % imagePaths.length],
                                    scale: 6,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.012,
                                ),
                                Text(
                                  data[index].category_name,
                                  style: GoogleFonts.teko(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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

class LocalJsonController {}
