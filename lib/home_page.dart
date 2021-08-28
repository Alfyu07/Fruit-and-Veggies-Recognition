import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_and_veggies_recognition/models/provider.dart';
import 'package:fruit_and_veggies_recognition/models/result.dart';
import 'package:fruit_and_veggies_recognition/models/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    TensorFlowLite.loadModel();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);

      if (image == null) return;
      return File(image.path);
    }

    final provider = Provider.of<MyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit and Veggies Recognition'),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: provider.results.length != 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: provider.results.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24,
                          color: Color(0xff7090B0).withOpacity(0.15),
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.file(
                          provider.results[index].image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The object is ${provider.results[index].result}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                final File? image = await pickImage(ImageSource.gallery);
                if (image == null) return;
                // print(image.path);
                List output = await TensorFlowLite.classifyImage(image);
                print(output);

                final Result result = Result(image, output[0]['label']);
                provider.results.add(result);
                setState(() {});
              },
              child: Icon(Icons.photo_album),
            ),
            SizedBox(height: 24),
            FloatingActionButton(
              onPressed: () async {
                final File? image = await pickImage(ImageSource.camera);
                if (image == null) return;
                print(image.path);
                List output = await TensorFlowLite.classifyImage(image);
                print(output);
                final Result result = Result(image, output[0]['label']);
                provider.results.add(result);
                setState(() {});
              },
              child: Icon(Icons.camera),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
