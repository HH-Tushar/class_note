import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/confirmDelete.dart';
import '../data/storage.dart';
import '../operations/operations.dart';
import 'createNoteScreen.dart';
import 'opicDetailsScreen.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String subId;
  final String title;
  final String? desc;
  const SubjectDetailsScreen(
      {Key? key, required this.subId, required this.title, this.desc})
      : super(key: key);

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  String highlightNode = "";
  List<Topics> results = [];

  List<Topics> _runFilter(String key) {
    if (widget.subId.isEmpty) {
      results = context.watch<TopicOperation>().getTopics;
    } else {
      results = context
          .watch<TopicOperation>()
          .getTopics
          .where((user) =>
              user.subId.toLowerCase().contains(widget.subId.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    return results;
  }

  void action(String topicId) {
    //deleting all topics related to this subject
    Provider.of<TopicOperation>(context, listen: false).deleteTopic(topicId);
  }

  @override
  void initState() {
    //_runFilter(widget.currentKey);
    Provider.of<TopicOperation>(context, listen: false).loadTopicsDate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CreateNoteScreen(
                      subId: widget.subId,
                      isTopic: true,
                    )));
          },
          child: const Icon(Icons.add_chart_sharp),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ExpansionTile(
            title: const Text(
              "Introduction:",
            ),
            children: [Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Text("${widget.desc}",softWrap: true,),
            )],
          ),
          const Center(
              child: Text(
            "Topics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )),
          Consumer<TopicOperation>(
            builder: (context, topics, child) => ListView.builder(
                shrinkWrap: true,
                itemCount: _runFilter(widget.subId).length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      isThreeLine: true,
                      minVerticalPadding: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      tileColor: highlightNode == results[index].topicId
                          ? Colors.redAccent
                          : Colors.black12,
                      title: Text(
                        _runFilter(widget.subId)[index].title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        "${results[index].description}",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: SizedBox(
                        width: 115,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => CreateNoteScreen(
                                          isTopic: true,
                                          topicId:
                                              topics.getTopics[index].topicId,
                                      title: topics.getTopics[index].title,
                                      description: topics.getTopics[index].description,
                                        )));
                              },
                              shape: const CircleBorder(),
                              color: Colors.green,
                              elevation: 10,
                              minWidth: 25,
                              height: 45,
                              child: const Icon(Icons.edit),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                final bool confirmation = await showDialog(
                                    context: context,
                                    builder: (_) => const ConfirmDelete());
                                // confirming deleting
                                if (confirmation) {
                                  action(topics.getTopics[index].topicId);
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TopicDetailsScreen(
                          topicTitle: results[index].title, topicDetails: "${results[index].description}",)));
                      },
                    ),
                  );
                }),
          ),
        ]));
  }
}
