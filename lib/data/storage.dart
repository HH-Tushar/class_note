
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? subPref;
SharedPreferences? topicsPref;

class SubjectName  {
 final String subId;
   String ? title;
  String ? shortDescription;


  SubjectName({required this.subId,this.title,this.shortDescription});


  SubjectName.fromMap( Map<String,dynamic> map)

     : subId=map['subId'],
       title=map['title'],
       shortDescription=map['shortDescription'];


 Map  <String,dynamic>toMap(){
   return {
     'subId':subId,
     'title':title,
     'shortDescription':shortDescription,
   };
 }


}


//Topic class
class Topics{
  final String subId;
  final String topicId;
   String title;
  String ? description;

  Topics({required this.topicId,required this.subId,required this.title,this.description});


  Topics.fromMap( Map<String,dynamic> map)

      : subId=map['subId'],
        topicId=map['topicId'],
        title=map['title'],
        description=map['description'];


  Map  <String,dynamic>toMap(){
    return {
      'subId':subId,
      'topicId':topicId,
      'title':title,
      'description':description,
    };
  }

}



