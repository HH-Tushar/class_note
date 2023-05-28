import 'package:flutter/cupertino.dart';

class SubjectName  {
 final String subId;
   String ? title;
  String ? shortDescription;


  SubjectName({required this.subId,this.title,this.shortDescription});


}

class Topics{
  final String subId;
  final String topicId;
   String title;
  String ? description;

  Topics({required this.topicId,required this.subId,required this.title,this.description});


}



