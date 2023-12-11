import 'package:flutter/material.dart';

class Kategoriwidget extends StatelessWidget {
  const Kategoriwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            // Widget Kategori Kompor
            buildKategoriItem(context, "Kompor", "assets/images/kompor.png"),

            // Widget Kategori Oven
            buildKategoriItem(context, "Oven", "assets/images/oven.jpg"),

            // Widget Kategori Mixer
            buildKategoriItem(context, "Mixer", "assets/images/mixer.jpeg"),

            // Widget Kategori Rak Piring
            buildKategoriItem(
                context, "Rak Piring", "assets/images/rak piring.jpeg"),

            // Widget Kategori Pisau
            buildKategoriItem(context, "Pisau", "assets/images/pisau.png"),

            // Widget Kategori Wajan dan Panci
            buildKategoriItem(
                context, "Wajan dan Panci", "assets/images/wajan.png"),

            // Widget Kategori Spatula, Sendok, dll
            buildKategoriItem(
                context, "Spatula, Sendok, dll", "assets/images/spatula.png"),
          ],
        ),
      ),
    );
  }

  Widget buildKategoriItem(
      BuildContext context, String Kategori, String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman KategoriPage dengan mengirimkan parameter Kategori
          Navigator.pushNamed(context, "kategoriPage", arguments: Kategori);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
              Text(
                Kategori,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
