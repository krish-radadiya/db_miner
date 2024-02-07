import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../model/get_qoute_model.dart';
import '../../../model/qoute_databse.dart';

class GetQuotesController extends GetxController {
  GetQuotesMethod getQuotesMethod = GetQuotesMethod(
    getAllQuotes: Future(
      () => [],
    ),
  );

  getQuotesList({required Future<List<QuotesDatabaseModel>> allQuotes}) {
    getQuotesMethod.getAllQuotes = allQuotes;
    update();
  }
}
