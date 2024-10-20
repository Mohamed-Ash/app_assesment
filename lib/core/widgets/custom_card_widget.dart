import 'package:app_assesment/core/helper/date_helper.dart';
import 'package:app_assesment/core/themes/app_text_style.dart';
import 'package:app_assesment/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

Widget customCardTaskWidget({
  required BuildContext context,
  required String title,
  required String status,
  required DateTime date,
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
              style: AppTextStyles.bodyMedium(),
            ),
            const SizedBox(height: 6,),
            Text(
              formatDateHelper(date),   
              style: AppTextStyles.hintStyle()
            ),
          ],
        ),
        minLeadingWidth: 0,
        trailing: SvgImageWidget(
          iconName: status == 'not_done' ?  'not_done_round' : 'task_done', 
          color: const Color(0xff4ECB71),
          height: 35,
          width: 35,
        ),
      ),
    ),
  );
  
}

/* 


 */