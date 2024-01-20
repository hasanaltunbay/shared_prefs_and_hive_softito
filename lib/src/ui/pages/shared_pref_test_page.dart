import 'package:flutter/material.dart';

import '../../services/shared_prefs_service.dart';

class SharedPrefTestPage extends StatefulWidget {
  const SharedPrefTestPage({super.key});

  @override
  State<SharedPrefTestPage> createState() => _SharedPrefTestPageState();
}

class _SharedPrefTestPageState extends State<SharedPrefTestPage> {
  List<String> gecmisLoglar = [];
  late final controller = TextEditingController();

  late final prefService = SharedPrefsService();

  var testVerisi = '';

  @override
  void initState() {
    super.initState();
    SharedPrefsService.initService().then((value) {
      gecmisLoglar.add(value
          ? 'SharedPrefsService Basariyla devreye alindi'
          : 'SharedPrefsService hatali su anda');

      testVerisi = prefService.getString('test') ?? 'BOS SUAN';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Shared Preferences"),
      ),
      body: Center(
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: gecmisLoglar.map((e) => Text(e)).toList()),
            const SizedBox(
              height: 100,
            ),
            Text('TEST DATA VERISI => $testVerisi'),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  Flexible(
                      child: TextButton(
                          onPressed: () {
                            prefService
                                .setString('test', controller.text)
                                .then((value) {
                              gecmisLoglar.add(value
                                  ? 'test keyi adi altina ${controller.text} eklendi'
                                  : 'Hata');
                              setState(() {});
                            });
                          },
                          // onPressed: () async {
                          //   final result = await prefService.setString(
                          //       'test', controller.text);
                          //   gecmisLoglar.add(result
                          //       ? 'test keyi adi altina ${controller.text} eklendi'
                          //       : 'Hata');
                          //   setState(() {});
                          // },
                          child: const Text('ekle')))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
