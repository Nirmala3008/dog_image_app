import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_ceo_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(

              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 21,
                color:Colors.black,
              )),
        ),
        title: Text('History Page',style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500),),
        elevation: 0,
      ),
      body: Consumer<ImageHistory>(
        builder: (context, imageHistory, _) {
          return imageHistory.history.length>0
            ?GridView.builder(
            shrinkWrap: true,
            // padding: const EdgeInsets.all(4.0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            itemCount: imageHistory.history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _showAddToCartDialog(context, imageHistory.history[index]);
                },
                child:Container(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: IntrinsicHeight(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 180),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.grey.withOpacity(.2),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      imageHistory.history[index],
                                      maxHeight: 180,
                                    ))),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: CachedNetworkImage(
                                  imageUrl: imageHistory.history[index],
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
                            ),
                          ),
                        )),
                  ),
                )

              );
            },
          )
          :Center(
              child: Text('No Data',style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500),)
          );
        },
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, String imageUrl) {
    TextEditingController _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add to Cart',style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17.5,
              fontWeight: FontWeight.w500),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
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
                  ),
                ),
              ),
              // Image.network(imageUrl),
              SizedBox(height: 7,),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  errorStyle: TextStyle(fontSize: 16.0),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    // fontFamily: 'Poppins',
                    fontSize: 14.5,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w400,
                    // height: 1
                  ),

                  // filled: true,
                  // fillColor: Theme.of(context).cardColor,
                  errorBorder: InputBorder.none,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                    // borderSide: BorderSide(
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                        width: 1, color:  Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(9),
                    ),
                  ),
                  labelText: 'Enter an amount',

                  floatingLabelBehavior: FloatingLabelBehavior.never,

                  contentPadding: const EdgeInsets.only(top: 10, left: 15),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  // fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                  // height: 1
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: GoogleFonts.poppins(
                // color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),),
            ),
            TextButton(
              onPressed: () {
                int amount = int.tryParse(_amountController.text) ?? 0;
                if (amount > 0) {
                  Provider.of<Cart>(context, listen: false).addImage(
                    CartImage(imageUrl: imageUrl, amount: amount),
                  );
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushNamed(context, '/cart');

                  // Navigator.push(context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CartPage(),
                  //   ),
                  // );
                  print('Added to cart: $imageUrl - Amount: $amount');

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
              },
              child: Text('Add to Cart',style: GoogleFonts.poppins(
                  // color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),),
            ),
          ],
        );
      },
    );
  }
}
