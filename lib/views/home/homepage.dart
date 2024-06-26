import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/helper/quotedatabase_helper.dart';
import 'package:quotes_app_db/models/quotes_model.dart';
import 'package:quotes_app_db/views/home/homepage_controller.dart';
import 'package:quotes_app_db/views/home/screen/favorite_db.dart';
import 'package:quotes_app_db/views/home/screen/quote_detail.dart';
import 'package:share/share.dart';

class Homepage extends StatelessWidget {
  final QuoteController quoteController = Get.put(QuoteController());
  final dbHelper = DatabaseHelper.instance;

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'Quotes',
          flightShuttleBuilder: (context, _, __, ___, ____) {
            return const Scaffold(
              backgroundColor: Colors.transparent,
              body: Text(
                "Quotes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            );
          },
          child: const Text(
            "Quotes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: const Text("Favorite"),
                  onTap: () {
                    Get.to(const FavoritesScreen());
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (quoteController.quotes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: quoteController.quotes.length,
              itemBuilder: (context, index) {
                Quote quote = quoteController.quotes[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      QuoteDetail(quote: quote),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 7.0,
                          blurStyle: BlurStyle.solid,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 8),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: (quote.id % 2 == 0)
                                ? Colors.purple.withOpacity(0.2)
                                : Colors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Hero(
                            tag: quote.quote,
                            flightShuttleBuilder: (context, _, __, ___, ____) {
                              return Scaffold(
                                backgroundColor: Colors.transparent,
                                body: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        quote.quote,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '@${quote.author}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quote.quote,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '@${quote.author}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  quoteController.addToFavorites(quote);
                                },
                                icon: Obx(
                                  () {
                                    return Icon(
                                      quote.isFavorite.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(quote.quote).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Quote copied'),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Share.share(quote.quote);
                                },
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
