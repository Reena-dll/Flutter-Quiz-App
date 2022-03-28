import 'package:flutter/material.dart';
import 'choice_page.dart';

// Burası bizim açılış sayfamız olacak. Uyguluma ilk açıldığında ekrana gelecek olan ilk sayfa.

class LandinPage extends StatelessWidget{
@override
  Widget build(BuildContext context){
  return  new Material(
    color: Colors.greenAccent,  // Giriş sayfası arka plan rengi
    child: new InkWell(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  new ChoicePage())),  // NAVİGATOR YÖNLENDİRME METODU KULLANDIK!!!.
      // onTap kullanmamızda ki sebep, ekrana tıklama efekti vermek ve button görevi göstermek. Ardından QuizPage sayfasına yönlendirmek.
      child: new Column(  // Kolon oluşturmamızda ki sebep ise yazılar alt alta gelecek ve yazıları ortalamamız için daha kolay olacak.
        mainAxisAlignment: MainAxisAlignment.center,  // Yazıları ortaya çeken kod.
        children: <Widget>[
          new Text("Sınava Hoş Geldin ", style: new TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold) ,),//Açılış sayfasında ki textlerin özelliklerini belirliyoruz.
          new Text("Başlamak İçin Basınız!!!", style: new TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),//Renkleri, kalınlıkları, Boyutları ..
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0), // Araya 10 piksel yer açtık.  // Foto ile Text arasına boşluk atıyor.
          ),
          Image.asset('images/icon.png',width: 200.0,height: 200.0) // Benim kuşumun fotoğrafı. Aynı zamanda uygulama logosu :)
        ],
      ),
    ),
  );
}

}