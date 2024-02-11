import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_ceo_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'history_page.dart';


class HomePage extends StatelessWidget {
  Future<String> fetchDogImage() async {
    final response =
    await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['message'];
    } else {
      throw Exception('Failed to load image');
    }
  }
  int cIndex = 0;
  final iconLinearGradiant = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80)
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Images', style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children:[
            Consumer<ImageHistory>(
              builder: (context, provider, child) {
                return provider.history.isEmpty
                    ? Text('Press the button to load an image',style: GoogleFonts.poppins(
                    color: Theme.of(context).dividerColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),)
                    : IntrinsicHeight(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: CachedNetworkImage(
                              imageUrl: provider.history.last.toString(),
                              errorWidget: (BuildContext context, String url, abc) {
                                return const Center(child: Icon(Icons.image_not_supported));
                              },
                              progressIndicatorBuilder: (BuildContext context, String url,
                                  DownloadProgress? loadingProgress) {
                                return Stack(alignment: Alignment.center, children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress!.progress,
                                      color: Theme.of(context).dividerColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ]);
                              }),
                        ));
                // Image.network(provider.history.last);
              },
            ),
            SizedBox(height: 7),
            ElevatedButton(
              onPressed: () async {
                final imageUrl = await fetchDogImage();
                Provider.of<ImageHistory>(context, listen: false).addImage(imageUrl);
              },
              child: Text('Load Dog Image'),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.4),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },

              child: Text('View History'),
            ),
            ElevatedButton(
              onPressed: () {
                int amount =  0;
                // Provider.of<Cart>(context, listen: false).addItem(
                //   CartItem(imageUrl: imageUrl, amount: amount),
                // );

                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/cart');
              },
              child: Text('Add to cart'),
            ),

          ],
        ),
      ),

    );
  }

}