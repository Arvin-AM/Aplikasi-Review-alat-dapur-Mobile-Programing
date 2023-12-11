import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/pages/ItemPage.dart';

class TerbaruWidget extends StatefulWidget {
  final String? searchQuery;

  const TerbaruWidget({Key? key, this.searchQuery}) : super(key: key);

  @override
  _TerbaruWidgetState createState() => _TerbaruWidgetState();
}

class _TerbaruWidgetState extends State<TerbaruWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('item').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var dataList = snapshot.data!.docs;

        // Filter data berdasarkan pencarian
        var filteredData = dataList.where((document) {
          var data = document.data() as Map<String, dynamic>;

          if (widget.searchQuery != null &&
              !data['nama']
                  .toLowerCase()
                  .contains(widget.searchQuery!.toLowerCase())) {
            return false;
          }

          return true;
        }).toList();

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: filteredData.map<Widget>((document) {
                var data = document.data() as Map<String, dynamic>;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 380,
                    height: 130,
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
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(
                            data['gambar'] ?? '',
                            height: 120,
                            width: 100,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                data['nama'] ?? '',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['Kategori'] ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
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
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemPage(
                                        itemId: document.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Lihat Detail ->"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  fixedSize: Size(130, 7),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
