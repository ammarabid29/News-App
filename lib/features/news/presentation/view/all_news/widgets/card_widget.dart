import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';

class CardWidget extends StatelessWidget {
  final Articles article;
  const CardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    final format = DateFormat("MMMM dd, yyyy");
    DateTime dateTime = DateTime.parse(article.publishedAt.toString());

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: Container(
            width: width * 0.85,
            height: height * 0.43,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ??
                    "https://www.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1732584341.jpg",
                fit: BoxFit.cover,
                placeholder: (context, url) => Utils().spinKit(),
                errorWidget: (context, url, error) => Image.network(
                  "https://www.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1732584341.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: height * 0.16,
              width: width * 0.7,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    article.title ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    article.source?.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    format.format(dateTime),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
