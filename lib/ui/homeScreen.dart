import 'package:class_note/data/storage.dart';
import 'package:class_note/ui/createNoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../operations.dart';
import 'detailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> mykey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Class Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateNoteScreen()));
          },
          child: const Icon(Icons.add_chart_sharp),
        ),
        
        body: Consumer<SubjectOperation>(
            builder: (context, subject, child) => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount:
                subject.getSubject.length,
                itemBuilder: (context, index) {
                  return ListTile(

                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [

                          IconButton(onPressed: (){
                            //deleting all topics related to this subject
                            Provider.of<TopicOperation>(context, listen: false).deleteAllTopics(subject.getSubject[index].subId);

                            //deleting subject
                            subject.deleteSubject(subject.getSubject[index].subId);
                            },
                            icon: const Icon(Icons.delete_sharp),
                          ),
                          IconButton(onPressed: (){
                            //editing subjet
                            subject.editSubject(subject.getSubject[index].subId,"New Dilli");
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),

                    subtitle: Text(
                        "${subject.getSubject[index].shortDescription}"),

                    title: Text(
                     "${ subject.getSubject[index].title}",
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (_) =>  DetailsScreen(
                            title: subject.getSubject[index].title.toString(), subId: subject.getSubject[index].subId.toString())));
                    },

                  );
                }),

        )



        );
  }
}
