import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_pref_and_hive/src/models/person_model.dart';

import '../../services/hive_service.dart';

class PageHiveTest extends StatefulWidget {
  const PageHiveTest({super.key});

  @override
  State<PageHiveTest> createState() => _PageHiveTestState();
}

class _PageHiveTestState extends State<PageHiveTest> {
  final formKey = GlobalKey<FormState>();
  var personModel = PersonModel.empty();
  late final Box<PersonModel> box;
  bool boxLoaded = false;

  initLocalDb() async {
    final result = await HiveService.initService();
    print(result);
    box = await HiveService.openBox<PersonModel>();
    setState(() {
      boxLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initLocalDb();
    // Future.microtask(() async {
    //   final result = await HiveService.initService();
    //   print(result);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive"),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (e) => personModel.name = e,
                      validator: (e) =>
                          (e?.length ?? 0) < 2 ? 'Ismin 2 half olamaz' : null,
                    ),
                    TextFormField(
                        onChanged: (e) =>
                            personModel.age = (int.tryParse(e) ?? 0),
                        validator: (e) => (int.tryParse(e ?? '0') ?? 0) < 18
                            ? 'yas 18 den kucuk olamaz'
                            : null),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await HiveService.addToBox(box, personModel);
                            personModel = PersonModel.empty();
                          }
                        },
                        child: const Text('Gonder')),
                    if (boxLoaded)
                      Container(
                        child: ValueListenableBuilder(
                            valueListenable: box.listenable(),
                            builder: (context, box, child) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: box.values.length,
                                  itemBuilder: (context, index) {
                                    final element = box.values.elementAt(index);
                                    return ListTile(
                                      title: Text('Isim : ${element.name}'),
                                      subtitle: Text('Yasi : ${element.age}'),
                                      trailing: IconButton(
                                          onPressed: () {
                                            HiveService.remove(box, index);
                                          },
                                          icon: const Icon(Icons.delete)),
                                    );
                                  });
                            }),
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
