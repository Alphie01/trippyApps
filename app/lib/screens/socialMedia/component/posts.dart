import 'package:app/constants/theme.dart';
import 'package:app/screens/socialMedia/component/classes/post.dart';
import 'package:app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostUI extends StatelessWidget {
  const PostUI({super.key, required this.postClasses});
  final PostClasses postClasses;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppTheme.firstColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: postClasses.postBelongs.userProfilePhoto),
                        borderRadius: BorderRadius.circular(35)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: postClasses.postBelongs.userName!,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(text: 'Rotaya Göz At')
                      ],
                    ),
                  )
                ],
              ),
              FaIcon(
                FontAwesomeIcons.listDots,
                color: AppTheme.textColor,
                size: 18,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            height: 250,
            decoration: BoxDecoration(color: Colors.amber),
          ),
          Container(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: AppTheme.textColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: AppText(text: '123'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.share,
                            color: AppTheme.textColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: AppText(text: '123'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                FaIcon(
                  FontAwesomeIcons.bookmark,
                  color: AppTheme.textColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
