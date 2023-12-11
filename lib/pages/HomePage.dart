import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas/widgets/AppBarWidget.dart';
import 'package:uas/widgets/DrawerWidget.dart';
import 'package:uas/widgets/Kategoriwidget.dart';
import 'package:uas/widgets/PopulerWidget.dart';
import 'package:uas/widgets/TerbaruWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBarWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.blueGrey,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (value) {
                            // setState diperlukan untuk memberitahu Flutter bahwa state telah berubah
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              hintText: "Silahkan cari apa yang anda cari",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Kategori",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Kategoriwidget(),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Populer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          PopulerWidget(),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Terbaru",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // TerbaruWidget akan menerima searchQuery dari _searchController.text
          TerbaruWidget(searchQuery: _searchController.text),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }
}
