import 'package:flutter/cupertino.dart';

class SubjectName  {
  final String title;
  String ? shortDescription;
  List<Topics> ? topics;

  SubjectName({required this.title,this.shortDescription,this.topics});


}

class Topics extends ChangeNotifier{
  final String title;
  String ? description;

  Topics({required this.title,this.description});


}



