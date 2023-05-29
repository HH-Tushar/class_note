
import 'package:class_note/ui/createNoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/confirmDelete.dart';
import '../operations/operations.dart';
import 'subjectDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void action(String subId){

      //deleting all topics related to this subject
      Provider.of<TopicOperation>(context,
          listen: false)
          .deleteAllTopics(subId);

      //deleting subject
      context
          .read<SubjectOperation>()
          .deleteSubject(subId);
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<SubjectOperation>(context, listen: false).loadSubjectDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Class Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CreateNoteScreen(isTopic: false,)));
          },
          child: const Icon(Icons.add_chart_sharp),
        ),
        body: Consumer<SubjectOperation>(
          builder: (context, subject, child) => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemCount: subject.getSubject.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.green.shade50,

                    subtitle: Text(
                        "${subject.getSubject[index].shortDescription}",
                        maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black)),
                    title: Text(
                      "${subject.getSubject[index].title}",maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    ),

                    leading: Image.asset(
                      "assets/folder.png",
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),

                    trailing: SizedBox(
                      width: 115,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateNoteScreen(
                              subId: subject.getSubject[index].subId, isTopic: false,
                            title: subject.getSubject[index].title,
                              description: subject.getSubject[index].shortDescription,
                            )));},
                            shape: const CircleBorder(),
                            color: Colors.green,
                            elevation: 10,
                            minWidth: 25,
                            height: 45,
                            child: const Icon(Icons.edit),
                          ),
                          MaterialButton(
                            onPressed: ()async {

                             final bool confirmation = await showDialog(
                                 context: context, builder: (_) => const ConfirmDelete());

                           // confirming deleting
                             if(confirmation) {
                               action(subject.getSubject[index].subId);
                             }
                            },
                            shape: const CircleBorder(),
                            color: Colors.green,
                            elevation: 10,
                            minWidth: 45,
                            height: 45,
                            child: const Icon(Icons.delete_rounded),
                          ),

                        ],
                      ),
                    ),

                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SubjectDetailsScreen(
                              title: subject.getSubject[index].title
                                  .toString(),
                              subId: subject.getSubject[index].subId
                                  .toString(),
                            desc: subject.getSubject[index].shortDescription!.toString(),)));
                    },


                  ),
                );
              }),
        ));
  }
}
