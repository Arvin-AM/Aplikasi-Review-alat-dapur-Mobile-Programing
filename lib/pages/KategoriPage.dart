import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import library Firestore
import 'package:uas/pages/ItemPage.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan parameter Kategori dari Navigator
    final String? Kategori =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Kategori: $Kategori",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query Firestore sesuai dengan Kategori yang dipilih
        stream: FirebaseFirestore.instance
            .collection('item')
            .where('Kategori', isEqualTo: Kategori)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Ambil data dari snapshot dan tampilkan
          final dataList = snapshot.data?.docs ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: dataList.map<Widget>((document) {
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
      ),
    );
  }
}
