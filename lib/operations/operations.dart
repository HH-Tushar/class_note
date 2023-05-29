
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import '../data/storage.dart';

class SubjectOperation extends ChangeNotifier{

   List<SubjectName>_subjectsList=[];

   List<SubjectName> get getSubject{
     return _subjectsList;
   }

   loadSubjectDate() async {
     subPref = await SharedPreferences.getInstance();
     List<String>? noteList = subPref?.getStringList('subjects');
     _subjectsList = noteList!
         .map((eachElement) => SubjectName.fromMap(jsonDecode(eachElement)))
         .toList();
     notifyListeners();
   }


  void addSubject(String subTitle,String desc){
       _subjectsList.add(
           SubjectName(
             subId: DateTime
                 .now()
                 .millisecond
                 .toString(),
             title: subTitle.isNotEmpty?subTitle:"No Name",
             shortDescription: desc.isNotEmpty?desc: "No details have provided",
           )
       );
       //adding
       List<String> noteList = _subjectsList.map((notes) =>
           jsonEncode(notes.toMap())).toList();
       subPref!.setStringList('subjects', noteList);

    notifyListeners();
  }

  void deleteSubject(String myKey){
    _subjectsList.removeWhere((subject) => subject.subId.contains(myKey));

    List<String> newList = _subjectsList.map((notes) => jsonEncode(notes.toMap())).toList();
    subPref!.setStringList('subjects', newList);
    notifyListeners();
  }


  void editSubject(String subId,String subTitle,String ?description){

    _subjectsList.where((element) => element.subId==subId).forEach((element) {

      if(subTitle.isNotEmpty){element.title=subTitle;}
      if(description!=null){element.shortDescription=description;
      }
    });

    List<String> newList = _subjectsList.map((notes) => jsonEncode(notes.toMap())).toList();
    subPref!.setStringList('subjects', newList);
    notifyListeners();
  }




}

//topic related operation
class TopicOperation extends ChangeNotifier{

   List<Topics>_topicsList=[];

  List<Topics> get getTopics{
    return _topicsList;
  }

   loadTopicsDate() async {

     topicsPref = await SharedPreferences.getInstance();
     List<String>? noteList = subPref?.getStringList('topics');
     _topicsList = noteList!
         .map((eachElement) => Topics.fromMap(jsonDecode(eachElement)))
         .toList();

     notifyListeners();
   }


  void addTopic(String subId ,String topicTitle,String  topicDescription){

    if(topicTitle.isNotEmpty || topicDescription.isNotEmpty) {
      getTopics.add(
          Topics(
            title: topicTitle,
            subId: subId,
            topicId: "$subId${DateTime
                .now()
                .microsecondsSinceEpoch}",
            description: topicDescription ?? "dont ahve any",
          ));
      List<String> noteList = _topicsList.map((notes) =>
          jsonEncode(notes.toMap())).toList();
      topicsPref!.setStringList('topics', noteList);

      if (kDebugMode) {
        print("added new topic by using key : $subId");
      }
    }

    notifyListeners();
  }

  void deleteAllTopics(String subId){
    if(_topicsList.isNotEmpty) {
      _topicsList.removeWhere((topic) => topic.topicId.contains(subId));

      List<String> noteList = _topicsList.map((notes) =>
          jsonEncode(notes.toMap())).toList();
      topicsPref!.setStringList('topics', noteList);
    }
    notifyListeners();
  }
  void deleteTopic(String topicId){

    _topicsList.removeWhere((element) => element.topicId==topicId);

    List<String> noteList = _topicsList.map((notes) => jsonEncode(notes.toMap())).toList();
    topicsPref!.setStringList('topics', noteList);
    notifyListeners();

  }
  void editTopic(String topicId,String topicTitle,String description){
    _topicsList.where((element) => element.topicId==topicId).forEach((element) {
      if(topicTitle.isNotEmpty){element.title=topicTitle;}
      if(description.isNotEmpty){element.description=description;}
    });

    List<String> newList = _topicsList.map((notes) => jsonEncode(notes.toMap())).toList();
    topicsPref!.setStringList('topics', newList);

    if (kDebugMode) {
      print("on the topic editing function");
      print(topicTitle);
      print(description);
    }
    notifyListeners();
  }



}







