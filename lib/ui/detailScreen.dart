import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/storage.dart';
import '../operations.dart';

class DetailsScreen extends StatefulWidget {
  final String subId;
  final String title;
  const DetailsScreen({Key? key, required this.subId, required this.title}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  List<Topics> results = [];

  List<Topics> _runFilter(String key) {
    if (widget.subId.isEmpty) {
      results = context.watch<TopicOperation>().getTopics;
    } else {
      results = context.watch<TopicOperation>().getTopics
          .where((user) =>
          user.subId.toLowerCase().contains(widget.subId.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    return results;

  }
  @override
  void initState() {
    //_runFilter(widget.currentKey);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle:true,
        title: Text(widget.title),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("sending subject Id: ${widget.subId}");
            context.read<TopicOperation>().addTopic(
                widget.subId,
              DateTime.now().millisecond.toString(),
              " dummy details"
            );
            print("print the 0 index topic ID:${Provider.of<TopicOperation>(context,listen: false).getTopics[0].topicId}");
            print("print the 0 index sub ID:${Provider.of<TopicOperation>(context,listen: false).getTopics[0].subId}");
          },
          child: const Icon(Icons.add_chart_sharp),
        ),


        body: Consumer<TopicOperation>(
          builder: (context, topics, child) => ListView.builder(
              itemCount:_runFilter(widget.subId).length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    isThreeLine: true,
                    minVerticalPadding: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    tileColor: Colors.black12,


                    title: Text(
                      _runFilter(widget.subId)[index].title,
                    ),

                    subtitle: Text(
                        "${results[index].description}"),

                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){topics.editTopic(results[index].topicId, "boom");},
                              icon: const Icon(Icons.edit)),

                          IconButton(onPressed: (){topics.deleteTopic(results[index].topicId);},
                            icon: const Icon(Icons.delete),),
                        ],
                      ),
                    ),

                    onTap: (){},
                  ),
                );
              }),
        ));
  }
}
