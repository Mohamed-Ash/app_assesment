import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

Widget customCardTaskWidget(context){
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
      child: const ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Build UI Android',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal
              ),
            ),
            SizedBox(height: 6,),
            Text(
              'Due Date: Mon. 21/3/2024',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal
                
              ),
            ),
          ],
        ),
        minLeadingWidth: 0,
        trailing: SvgImageWidget(
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