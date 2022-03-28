import 'dart:math';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CorrectWrongOverlay extends StatefulWidget{

  // Bu dart dosyamızda sorunun cevabına göre ekrana gelecek olan icon ve görsel temanın ayarları bulunmaktadır.

  final bool _isCorrect;
  final VoidCallback _onTap;

  CorrectWrongOverlay(this._isCorrect, this._onTap);  // Burada ise bool değişkeni ile sorunun doğru veya yanlış olup olmadığını tutuyoruz. Hazırladığımız metodu ise aşağıda icon ve yazı değişikliği için kullanacağız.

@override
  State createState()=> new CorrectWrongOverlayState();

}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin  { // İcon'a animasyon yapacağımız için SingleTickerProviderStateMixin metodunu tanımladık.

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override

  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2),vsync: this);    // QuestionText de olduğu gibi buranın da animasyon ayarlarını yaptık. Burada ki animasyonumuz 2 saniye sürecek.
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut); // Animasyon şeklimiz elasticOut. Diğerinden daha farklı
    _iconAnimation.addListener(()=> this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose(){
    _iconAnimationController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54, // Black54 seçmemizde ki sebep, Sonuç doğru veya yanlış olduğunda İcon'un arka planına karanlık verip İcon'u ön plana çekmek için. Stack burada çok işime yarıyor.
      child: new InkWell( // Ardından yine onTap kullanıyoruz.
        onTap: ()=> widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center, // İconumuzu tam ortaya alıyoruz.
          children: <Widget>[
            new Container( // İconumuzu bu Container içerisinde yaratıyoruz.
              decoration: new BoxDecoration( // İconun kutu dekarasyonunu yapıyoruz.
                color: Colors.white,// Dekarasyonun rengine beyaz veriyoruz.
                shape: BoxShape.circle// Kutu dekerasyonumuzu BoxShape özelliğimiz ile yuvarlak yani daire haline getiriyoruz.
              ),
              child: new Transform.rotate(
                angle: _iconAnimation.value*2*pi,  // Burada yazdığımız kod bloğu ise, Widgeti merkezinden tutup rotate etmemizi sağlıyor. Animasyona görsellik katıyor
                child: new  Icon(  widget._isCorrect == true ? Icons.done : Icons.clear, size: _iconAnimation.value*80 ),
              ) , // İconumuzu burada hazırlıyoruz.Yukarıda hazırladığımız parametreyi burada kullanarak cevap yanlış ise clear iconunu return edecek, cevap doğru ise done iconu return edecek. // Ardından da icon boyutunu belirledik.
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 10.0), // Burada ki padding işlememizde ise İcon ile yazı arasında 10 piksellik boşluk açtık.
            ),
            new Text(widget._isCorrect == true ? "Doğru!" : "Yanlış!",style: new TextStyle(color: Colors.white,fontSize: 30.0),) // Burada ise iconumuzun altında bulunacak yazıyı yazıyoruz. Ardından boyutunu ve özelliklerini tanımlıyoruz.
            // Yukarıda hazırladığımız parametreye göre quiz_page sayfasında değişkene hangi değer verilirse o return edilecek.
          ],
        ),
      ),
    );
  }
}