import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<String> favoriteQuotes = <String>[].obs;

  void toggleFavorite(String quote) {
    if (favoriteQuotes.contains(quote)) {
      favoriteQuotes.remove(quote);
    } else {
      favoriteQuotes.add(quote);
    }
  }

  bool isFavorite(String quote) {
    return favoriteQuotes.contains(quote);
  }
}
