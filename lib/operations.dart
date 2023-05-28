

import 'package:flutter/cupertino.dart';
import 'data/storage.dart';

class SubjectOperation extends ChangeNotifier{

  final List<SubjectName>_subjectsList=[];
  List<SubjectName> get getSubject{
    return _subjectsList;
  }

  void addSubject(String subTitle,String ? desc){
    _subjectsList.add(
        SubjectName(
          subId: DateTime.now().millisecond.toString(),
            title: subTitle,
            shortDescription: desc??"no details have provided",
            )
    );
    print("added new subject");
    print("current key from main subject is: ${getSubject[0].subId}");
    notifyListeners();
  }

  void deleteSubject(String myKey){
    _subjectsList.removeWhere((subject) => subject.subId.contains(myKey));
    notifyListeners();
  }
  void editSubject(String subId,String subTitle){
    _subjectsList.where((element) => element.subId==subId).forEach((element) {
      element.title=subTitle;print("${element.title}");});
    print("on the editing function");
    notifyListeners();
  }

}

//topic related operation
class TopicOperation extends ChangeNotifier{

   final List<Topics>_topicsList=[];

  List<Topics> get getTopics{
    return _topicsList;
  }


  void addTopic(String subId ,String topicTitle,String ? topicDescription){

    getTopics.add(
        Topics(
          title: topicTitle,
          subId: subId,
          topicId:"$subId${DateTime.now().microsecondsSinceEpoch}",
          description: topicDescription??"dont ahve any",
        ));

    print("added new topic by using key : $subId");
    notifyListeners();
  }

  void deleteAllTopics(String subId){
    _topicsList.removeWhere((topic) => topic.topicId.contains(subId));
    notifyListeners();
  }
  void deleteTopic(String topicId){
    _topicsList.removeWhere((element) => element.topicId==topicId);
    notifyListeners();
    //_topicsList.where((element) => element.key.contains(myKey)).toList();
  }
  void editTopic(String topicId,String topicTitle){
    _topicsList.where((element) => element.topicId==topicId).forEach((element) {
      element.title=topicTitle;print("${element.title}");});
    print("on the editing function");
    notifyListeners();
  }

}







