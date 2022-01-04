import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'firebase_test',
      home: GetCollectionUseStream(),
      //home: GetDocUseStream(),
      //home: GetCollectionUseFuture(),
      //home: GetDocUseFuture(),
    );
  }
}

class GetCollectionUseStream extends StatelessWidget {
  const GetCollectionUseStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _users = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _users,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text('name:${data['name']}'),
                  subtitle: Text('age:${data['age'].toString()}'),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class GetDocUseStream extends StatelessWidget {
  const GetDocUseStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference _users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _users.doc('aaa').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text("name:${data['name']}   age:${data['age']}");
          },
        ),
      ),
    );
  }
}

class GetCollectionUseFuture extends StatelessWidget {
  const GetCollectionUseFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<QuerySnapshot> _users = FirebaseFirestore.instance.collection('users').get();

    return Scaffold(
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: _users,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text('name:${data['name']}'),
                      subtitle: Text('age:${data['age'].toString()}'),
                    );
                  }).toList(),
                );
          },
        ),
      ),
    );
  }
}

class GetDocUseFuture extends StatelessWidget {
  const GetDocUseFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference _users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: _users.doc('bbb').get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text("name:${data['name']}   age:${data['age']}");
          },
        ),
      ),
    );
  }
}