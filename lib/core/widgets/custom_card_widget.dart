import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

Widget customCardTaskWidget({
  required BuildContext context,
  required String title,
  required String date,
}){
  return Card(
    elevation: 2,
    margin: const EdgeInsets.all(12),
    color: const Color(0xffFDFDFD),
    child: Container(
      // height: 79,
      width: MediaQuery.of(context).size.width > 600 ? 300 :double.infinity,
      // margin: const EdgeInsets.fromLTRB(18, 21, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child:   ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title, //  'Build UI Android',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal
              ),
            ),
            const SizedBox(height: 6,),
            Text(
              date, //'Due Date: Mon. 21/3/2024',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal
                
              ),
            ),
          ],
        ),
        minLeadingWidth: 0,
        trailing: const SvgImageWidget(
          iconName: 'task_done', 
          color: Color(0xff4ECB71),
          height: 35,
          width: 35,
        ),
      ),
    ),
  );
}

/* 


 */