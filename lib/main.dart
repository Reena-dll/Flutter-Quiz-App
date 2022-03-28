import 'package:flutter/material.dart';
import 'pages/landing_page.dart';

// Burası bizim main sayfamız ve burada  çok işlem yapılmayacak. Sadece girilen parametre ve fonksiyonlar Class'lar yardımıyla buraya çekilecek.

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,  // Sağ üstte ki debug imagesini kaldırmaya yarayan metot.
    home: LandinPage(), // LandingPage sayfasını çağırıyoruz.
  )
  );
}