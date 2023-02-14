import 'package:dars5/core/database_helper.dart';
import 'package:dars5/core/model/word_model.dart';
import 'package:dars5/di.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
class SqflitePage extends StatefulWidget {

  const SqflitePage({Key? key}) : super(key: key);

  @override
  State<SqflitePage> createState() => _SqflitePageState();
}

class _SqflitePageState extends State<SqflitePage> {


  final db = di.get<DatabaseHelper>();
  final controller = TextEditingController();
  var words = <WordModel>[];
  var isUz = true;

  @override
  void initState() {
    controller.addListener(() {
      search();
    });
    setState(() {
      controller.clear();
    });
    super.initState();
  }

  void search() {
    EasyDebounce.debounce(
      'my-debouncer',
      const Duration(milliseconds: 300),
      () async {
        if (isUz) {
          words = await db.findByUz(controller.text);

        } else {
          words = await db.findByEn(controller.text);
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    EasyDebounce.cancel('my-debouncer');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("SqflitePage: ${isUz ? "[uz->en]" : "[en->uz]"}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      // onChanged: (value) {
                      // },
                    onTap: (){
                        setState(() {
                          controller.clear();
                          controller == null;
                        });
                    },
                      scrollPadding: const EdgeInsets.all(0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: isUz ? "Uzbek " : "  English",
                        hintStyle: const TextStyle(color: Colors.black26),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.clear))
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    // controller.text = "fdfgdf";
                    isUz = !isUz;
                    setState(() {});
                    search();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(
                    Icons.g_translate,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Builder(builder: (context) {
                if (words.isEmpty) {
                  return const Center(
                      child: Text(
                    "Empty",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ));
                }
                return ListView.separated(
                  itemCount: words.length,
                  separatorBuilder: (_, i) => const SizedBox(height: 18),
                  itemBuilder: (context, i) {
                    return transleteItem(i);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  transleteItem(int i) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) =>  Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)),
              // height: MediaQuery.of(context).size.height * 0.26,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children:  [
                    const Text(
                      'Translete',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    // title
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(14)),
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Builder(
                        builder: (context) {
                          search();
                          if(isUz){
                            print("en: ${words[i].en}\n uz: ${words[i].uz}");
                            return  Text(
                              words[i].en,
                              style: TextStyle(fontSize: 32, color: Colors.white),
                            );
                          }else{
                            return Text(
                              words[i].uz,
                              style: TextStyle(fontSize: 32, color: Colors.white),
                            );

                          }

                        }
                    ),
                  ),
                )
                  ],
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))));

        print("bosildi");
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            isUz ? words[i].uz : words[i].en,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }


}
