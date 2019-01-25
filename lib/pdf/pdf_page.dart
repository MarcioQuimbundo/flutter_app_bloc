import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PDFPage extends StatelessWidget {
  String pathPDF = "";

  PDFPage(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}

class PDFLoadingScreen extends StatefulWidget {
  @override
  _PDFLoadingScreenState createState() => new _PDFLoadingScreenState();
}

class _PDFLoadingScreenState extends State<PDFLoadingScreen> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "http://africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void deleteFileOfPdfUrl() async {
    final url = "http://africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    if (file.existsSync()) {
      file.delete();
      setState(() {
        pathPDF = "";
        print("deleted");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Open PDF"),
              onPressed: () => (pathPDF != "")
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PDFPage(pathPDF)),
                    )
                  : null,
            ),
            RaisedButton(
                child: Text("Delete PDF"),
                onPressed: () => deleteFileOfPdfUrl()),
          ],
        ),
      ),
    );
  }
}
