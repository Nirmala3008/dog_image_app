import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_ceo_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartImages = Provider.of<Cart>(context).images;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(

              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 21,
                color:Colors.black,
              )),
          title: Text('Cart Page',style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500),),
          elevation: 0,
        ),
        body: cartImages.length>0
            ? ListView.builder(
              itemCount: cartImages.length,
              itemBuilder: (context, index) {
                final cartImage = cartImages[index];
                return Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                    margin: EdgeInsets.only(left: 10, right: 20, top: 7),
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100, maxWidth: 200),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: CachedNetworkImage(
                              imageUrl: cartImage.imageUrl,
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
                  ),
                  // Image.network(cartImage.imageUrl, height: 200,),

                  Text('Amount: ${cartImage.amount}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),),
               ] );
              },
            )
            :Center(child: Text('No Data',style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500),)),
      ),
    );
  }
}
