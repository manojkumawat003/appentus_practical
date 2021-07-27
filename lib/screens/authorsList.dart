import 'dart:convert';

import 'package:appentus_demo/main.dart';
import 'package:appentus_demo/store/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/store/action.dart' as action;

class AuthorsListScreen extends StatefulWidget {
  AuthorsListScreen({Key? key}) : super(key: key);

  @override
  _AuthorsListScreenState createState() => _AuthorsListScreenState();
}

class _AuthorsListScreenState extends State<AuthorsListScreen> {
  @override
  void initState() {
    store.dispatch(action.fetchAuthorsList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          body: store.state.authorsList.authorData == null
              ? Center(child: CircularProgressIndicator())
              : store.state.authorsList.authorData!.isEmpty
                  ? Text("Empty")
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: store.state.authorsList.authorData!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                store
                                    .state.authorsList.authorData![index].author
                                    .toString(),
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      store.state.authorsList.authorData![index]
                                          .downloadUrl
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          }),
                    ),
        );
      },
    );
  }
}
