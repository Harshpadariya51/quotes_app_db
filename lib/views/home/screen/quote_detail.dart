import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/models/quotes_model.dart';
import 'package:quotes_app_db/views/home/homepage_controller.dart';
import 'package:share/share.dart';

class QuoteDetail extends StatelessWidget {
  final Quote quote;
  final controller = Get.put(QuoteDetailController());
  QuoteDetail({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Hero(
          tag: 'Quotes',
          child: Text(
            "Quote",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0,
                  blurStyle: BlurStyle.solid,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    image: const AssetImage('assets/logos/quote-logo.png'),
                    height: 50,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 15),
                Hero(
                  tag: quote.quote,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          quote.quote,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '@${quote.author}',
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.toggleLike();
                        },
                        icon: Obx(
                          () => Icon(
                            controller.isLiked.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isLiked.value ? Colors.red : null,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${controller.likeCount}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
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
                          Icons.share,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 140),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logos/facebook.png'),
                height: 30,
              ),
              SizedBox(width: 20),
              Image(
                image: AssetImage('assets/logos/instagram.png'),
                height: 30,
              ),
              SizedBox(width: 20),
              Image(
                image: AssetImage('assets/logos/whatsapp.png'),
                height: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Share the Quote..",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
