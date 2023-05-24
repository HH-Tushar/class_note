

import 'package:flutter/cupertino.dart';
import 'data/storage.dart';

class SubjectOperation extends ChangeNotifier{

  final List<SubjectName>_subjectsList=[];
  List<SubjectName> get getSubject{
    return _subjectsList;
  }

  void addSubject(String subTitle){
    _subjectsList.add(
        SubjectName(
            title: subTitle,
            shortDescription: "this is my picker",
          topics: []
            )
    );
    print("added new subject");
    notifyListeners();
  }

  void addTopic(int curindex ,String xx){
    List<Topics>? curlist=getSubject[curindex].topics;
    curlist?.add(Topics(title: xx));
    getSubject.add(
    SubjectName(
        title: getSubject[curindex].title,
        shortDescription: getSubject[curindex].shortDescription,
        topics:curlist));

    getSubject.removeAt(curindex);
    print("added new topic in index : $curindex");
    notifyListeners();
  }
}
