import 'package:client/component/buttons.dart';
import 'package:client/pages/select_talk/select_talk_page.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void showRatingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        ),
      );
    },
  );
}

Widget dialogContent(BuildContext context) {
  // Get the current date

  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: ColorTheme.WhiteColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ให้คะแนนผู้ใช้',
              style: FontTheme.body1,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            CupertinoIcons.star_fill,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SmPrimaryButton(
            text: 'บันทึก',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TalkPage()),
              );
            },
          ),
        ),
      ],
    ),
  );
}
