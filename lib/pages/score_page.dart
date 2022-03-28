import 'package:flutter/material.dart';
import 'landing_page.dart';
class ScorPage extends StatelessWidget {

  final int score; // Daha öncesinde quiz dart da oluşturduğumuz değişkeni kullanıyoruz. Toplam kaç tane soru bildiğini öğrenmek için
  final int totalQuestions;// Bu değişkenimiz ise kaç tane soru olduğunu söylüyor bize.

  ScorPage(this.score,this.totalQuestions);

@override
Widget build(BuildContext context) {
  return new Material(
    color:  Colors.blueAccent,  // Arka plan rengini tanımladık.
    child: new Column( // Kolon açtık
      mainAxisAlignment: MainAxisAlignment.center,  // Kolon içerisini ortaladık
      children: <Widget>[
        new Text("Skorunuz: ", style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50.0),), // Yazımız ve özellikleri
        new Text(score.toString()+"/"+totalQuestions.toString(), style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50.0),
        ),// Değişkenlerimizi burada kullandık ve yazı şekillerini belirledik.

        new IconButton(  // Burada bir icon oluşturarak navigator kullanıyoruz ve o icona tıklandığında LandingPage sayfasına yönelendirme yapıyor.
            icon: new Icon(Icons.arrow_right),
            color: Colors.white,  // Icon özellikleri
            iconSize: 50.0,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new LandinPage()), (Route route)=> route==null)
        )
      ],
    ),
  );
}
}