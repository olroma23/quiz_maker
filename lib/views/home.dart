import 'package:flutter/material.dart';
import 'package:quiz_maker/services/firestore_service.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirestoreService firestoreService = FirestoreService();
  Stream stream;

  @override
  initState() {
    super.initState();
    stream = firestoreService.getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/create_quiz");
        },
      ),
      body: _homeBody(),
    );
  }

  Widget _homeBody() {
    return Container(
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    var imageUrl =
                        snapshot.data.documents[index].data["imageUrl"];
                    var title = snapshot.data.documents[index].data["title"];
                    var description =
                        snapshot.data.documents[index].data["description"];
                    return QuizTile(imageUrl, title, description);
                  });
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  QuizTile(this.imageUrl, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 150,
                width: MediaQuery.of(context).size.width - 40,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width - 40,
                height: 150,
              ),
            ),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6),
                Text(description,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center),
              ],
            )
          ],
        ),
      ),
    );
  }
}
