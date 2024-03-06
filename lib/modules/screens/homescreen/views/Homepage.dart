import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math' as math;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../detailsscreen/controller/category_controller.dart';
import '../../../controller/themeController.dart';
import '../../detailsscreen/model/category_database_model.dart';
import '../../../utils/DbHelper.dart';
import '../../../utils/common.dart';
import '../../detailsscreen/views/DetailScreen.dart';
import '../../favouritescreen/views/FavouritePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<CategoryDatabaseModel>>? getAllRecord;
  RxBool is_Switch = false.obs;

  @override
  void initState() {
    super.initState();
    getAllRecord = DBHelper.dbHelper.fatchAllCategory();
    // _containerColors = List.generate(_colors.length, (index) => _colors[index]);
  }

  @override
  Widget build(BuildContext context) {
    final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());

    CategoryController categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Category",
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(
            0,
          ),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                accountName: Text(
                  "Krish Radadiya",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                accountEmail: Text(
                  "RADADIYAKRISH62@GMAIL.COM",
                ),
                currentAccountPictureSize: Size.square(
                  50,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(
                    255,
                    165,
                    255,
                    137,
                  ),
                  child: Text(
                    "R",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text(
                ' Theme ',
              ),
              trailing: GetBuilder<GetXSwitchState>(
                builder: (_) => Switch(
                  value: getXSwitchState.isSwitcheded,
                  onChanged: (value) {
                    getXSwitchState.changeSwitchState(
                      value,
                    );
                    Get.changeTheme(
                      getXSwitchState.isSwitcheded
                          ? ThemeData.light()
                          : ThemeData.dark(),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(const FavouritePage()),
              child: const ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Favourite"),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<CategoryDatabaseModel>? data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(
                14,
              ),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      getAllQuotes =
                          DBHelper.dbHelper.fatchAllQuotes(id: data[index].id);
                      getAllQuotes!.then(
                        (value) => print(
                          value.length,
                        ),
                      );
                      categoryController
                          .setCategoryName(data[index].category_name);
                      //
                      // print(categoryController.categoryName.value);
                      Get.to(
                        () => const DetailsScreen(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          data![index].category_name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getAllRecord,
      ),
    );
  }
}
