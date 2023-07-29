import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height,
      ),
      child: AppText(text: 'text'),
    );
  }
}
