import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../operations.dart';

class DetailsScreen extends StatefulWidget {
  final curindex;
  const DetailsScreen({Key? key,required this.curindex}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context
                .read<SubjectOperation>()
                .addTopic(widget.curindex,"dj");
            //print("length of topics is ${context.read<SubjectOperation>().getTopics.length}");
          },
          child: const Icon(Icons.add_chart_sharp),
        ),


        body: Consumer<SubjectOperation>(
          builder: (context, subject, child) => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:
              subject.getSubject[widget.curindex].topics?.length??1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    subject.getSubject[widget.curindex].topics![index].title,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),

                  onTap: () {
                    print("current index is ${widget.curindex}");
                    print("you r tapping in index is $index");
                  },
                );
              }),

        )
    );
  }
}
