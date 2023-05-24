import 'package:class_note/data/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            context
                .read<SubjectOperation>()
                .addSubject("${DateTime.now().second.toString()}");
            print("${context.read<SubjectOperation>().getSubject.length}");
          },
          child: const Icon(Icons.add_chart_sharp),
        ),
        
        body: Consumer<SubjectOperation>(
            builder: (context, subject, child) => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:
                subject.getSubject.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Text(
                        "${context.watch<SubjectOperation>().getSubject[index].title}"),
                    title: Text(
                      subject.getSubject[index].title,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>  DetailsScreen(curindex: index)));
                    },
                  );
                }),

        )



        );
  }
}
