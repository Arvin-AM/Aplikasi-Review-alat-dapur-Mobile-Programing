import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/firestore/firestore_service.dart';
import 'package:uas/pages/ItemPage.dart';

class PopulerWidget extends StatefulWidget {
  const PopulerWidget({Key? key}) : super(key: key);

  @override
  State<PopulerWidget> createState() => _PopulerWidgetState();
}

class _PopulerWidgetState extends State<PopulerWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getTopRatedItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            List itemList = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: itemList.map<Widget>((document) {
                  DocumentSnapshot documentSnapshot = document;
                  Map<String, dynamic> data =
                      documentSnapshot.data() as Map<String, dynamic>;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemPage(
                              itemId: document.id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 208,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  data['gambar'] ?? '',
                                  height: 140,
                                  width: 90,
                                ),
                              ),
                              Text(
                                data['nama'] ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['Kategori'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[700],
                                    size: 17,
                                  ),
                                  Text(
                                    (data['rating'] ?? '').toString(),
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }
      },
    );
  }
}
