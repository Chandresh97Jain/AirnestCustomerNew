import 'package:flutter/cupertino.dart';

import 'global_text.dart';

class NoDataFound extends StatelessWidget {
  final double height;
   const NoDataFound({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Textwidget(
            text: 'No Data Found',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}


