import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPage extends StatefulWidget {
  final String itemId;

  const ItemPage({Key? key, required this.itemId}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> itemData;

  @override
  void initState() {
    super.initState();
    // Memanggil data dari Firestore berdasarkan ID item
    itemData =
        FirebaseFirestore.instance.collection('item').doc(widget.itemId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: itemData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Mendapatkan data dari Firestore
            var item = snapshot.data!.data()!;
            // Membangun UI menggunakan data dari Firestore
            return buildItemDetails(item);
          }
        },
      ),
    );
  }

  Widget buildItemDetails(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.network(
              item['gambar'] ?? '',
              height: 300,
            ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 25,
                          ),
                          SizedBox(width: 5),
                          Text(
                            (item['rating'] ?? '').toString(),
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['nama'] ?? '',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['Kategori'] ?? '',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        item['desc'] ?? '',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.design_services_outlined),
                          Text(
                            "Detail :",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Row(
                        children: [
                          Text(
                            item['detail'] ?? '',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      child: Row(
                        children: [
                          Text(
                            item['ukuran'] ?? '',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
