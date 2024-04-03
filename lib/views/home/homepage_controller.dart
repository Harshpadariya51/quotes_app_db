import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quotes_app_db/helper/api_helper.dart';
import 'package:quotes_app_db/models/quotes_model.dart';

class QuoteController extends GetxController {
  var quotes = <Quote>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var fetchedQuotes = await APIHelper.apiHelper.fetchedQuote();
    if (fetchedQuotes != null) {
      quotes.assignAll(fetchedQuotes
          .map((quote) => Quote(
                id: quote.id,
                quote: quote.quote,
                author: quote.author,
              ))
          .toList());
    }
  }
}

class QuoteDetailController extends GetxController {
  var isLiked = false.obs;
  var likeCount = 0.obs;

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likeCount.value++;
    } else {
      likeCount.value--;
    }
  }
}
