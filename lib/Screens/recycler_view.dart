import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/Controller/recycler_list_controller.dart';
import 'package:provider/provider.dart';

class RecyclerView extends StatelessWidget {
  static const route = '/recyclerView';

  const RecyclerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final realmC = Provider.of<RecyclerListController>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut();
        return false;
      },
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () => realmC.realmAdd(), child: Text('Reset')),
            TextButton(
                onPressed: () => realmC.realmSort(SortyBy.name),
                child: Text('Name')),
            TextButton(
                onPressed: () => realmC.realmSort(SortyBy.age),
                child: Text('Age')),
            TextButton(
                onPressed: () => realmC.realmSort(SortyBy.city),
                child: Text('City')),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.maybePop(context);
            },
            icon: const Icon(Icons.logout),
          ),
          title: const Text('RecyclerView'),
        ),
        body: Consumer<RecyclerListController>(
            builder: (context, controller, child) {
          return ListView.builder(
            itemCount: controller.persons.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text('${controller.persons[index].name}'),
                subtitle: Text(
                    'age: ${controller.persons[index].age} , city: ${controller.persons[index].city} '),
              );
            }),
          );
        }),
      ),
    );
  }
}
